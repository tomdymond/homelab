#!/usr/bin/env bash

set -e

BASE_IMAGE="CentOS-7-x86_64-DVD-1708.iso"
CUSTOM_ISO=/data/"$(echo ${BASE_IMAGE} | cut -f1 -d'.')_CUSTOM.ISO"
KS_BUILD="/data/kickstart_build"


function build_hparaid() {
  if [ ! -f /data/hpraid.tar.gz ]; then
    pushd /tmp
      if /usr/bin/mk_chroot_hpacucli /data/hpacucli-9.30-15.0.x86_64.rpm; then
        mv hpraid.tar.gz /data
      fi  
    popd
  fi
}


function build_iso() {
  rm -rfv /data/extracted_iso_image

  xorriso -osirrox on -indev /data/${BASE_IMAGE} -extract / /data/extracted_iso_image
  cp -v /grub.cfg /data/extracted_iso_image/EFI/BOOT/grub.cfg
  cp -v /isolinux.cfg /data/extracted_iso_image/isolinux/isolinux.cfg
  cp -v /data/hpraid.tar.gz /data/extracted_iso_image/isolinux/

  # Check if we have a real ks.cfg, otherwise use the SAMPLE one for testing
  if [ ! -f /ks.cfg ]; then
    KS_FILE="/ks.cfg.SAMPLE"
  else
    KS_FILE="/ks.cfg"
  fi
  mkdir -p /data/extracted_iso_image/ks
  cp -v ${KS_FILE} /data/extracted_iso_image/ks/ks.cfg

  pushd /data/extracted_iso_image/
    chmod 0664 isolinux/isolinux.bin

    echo " -- Building ISO"
    ISO_NAME="$(echo ${BASE_IMAGE} | cut -f1 -d'.')_CUSTOM.ISO"
    xorriso -as mkisofs -c isolinux/boot.cat -b isolinux/isolinux.bin -isohybrid-mbr /usr/share/syslinux/isohdpfx.bin -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e images/efiboot.img -no-emul-boot -isohybrid-gpt-basdat -volid "CentOS 7 x86_64" -sysid "LINUX" -J -o /data/${ISO_NAME} /data/extracted_iso_image

  popd
}


pushd /data
  if [ ! -f "${BASE_IMAGE}" ]; then
    wget http://www.mirrorservice.org/sites/mirror.centos.org/7/isos/x86_64/${BASE_IMAGE}
  fi
  if [ ! -f hpacucli-9.30-15.0.x86_64.rpm ]; then
    wget https://downloads.hpe.com/pub/softlib2/software1/pubsw-linux/p1257348637/v77370/hpacucli-9.30-15.0.x86_64.rpm
  fi
  if [ ! -f hpdsa-1.2.10-123.rhel7u4.x86_64.dd.gz ]; then
    wget https://downloads.hpe.com/pub/softlib2/software1/pubsw-linux/p286329307/v128141/hpdsa-1.2.10-123.rhel7u4.x86_64.dd.gz
    gunzip -c hpdsa-1.2.10-123.rhel7u4.x86_64.dd.gz > hpdsa.dd
  fi
popd

if [ ! -f "${CUSTOM_ISO}" ]; then
  build_hparaid
  build_iso
fi


echo "Done"

