#!/usr/bin/env bash

BASE_IMAGE="CentOS-7-x86_64-DVD-1708.iso"
KS_BUILD="/data/kickstart_build"

pushd /data
  if [ ! -f "${BASE_IMAGE}" ]; then
    wget http://www.mirrorservice.org/sites/mirror.centos.org/7/isos/x86_64/{BASE_IMAGE}
  fi
  if [ ! -f hpacucli-9.30-15.0.x86_64.rpm ]; then
    wget https://downloads.hpe.com/pub/softlib2/software1/pubsw-linux/p1257348637/v77370/hpacucli-9.30-15.0.x86_64.rpm
  fi
popd

if [ ! -f /data/hpraid.tar.gz ]; then
  pushd /tmp
    if /usr/bin/mk_chroot_hpacucli /data/hpacucli-9.30-15.0.x86_64.rpm; then
      mv hpraid.tar.gz /data
    fi  
  popd
fi


rm -rf ${KS_BUILD}
mkdir -pv ${KS_BUILD}/{isolinux,utils}
mkdir -pv ${KS_BUILD}/isolinux/{images,ks,LiveOS,Packages}

mount -o loop /data/${BASE_IMAGE} /mnt
cp -rv /mnt/isolinux/* ${KS_BUILD}/isolinux/
cp -v /mnt/.discinfo ${KS_BUILD}/isolinux/
cp -rv /mnt/images/* ${KS_BUILD}/isolinux/images/ 
cp -rv /mnt/LiveOS/* ${KS_BUILD}/isolinux/LiveOS/ 
cp -rv /mnt/Packages/* ${KS_BUILD}/isolinux/Packages/
cp -v /isolinux.cfg ${KS_BUILD}/isolinux/isolinux.cfg
cp -v /data/hpraid.tar.gz ${KS_BUILD}/isolinux/

gunzip -c /mnt/repodata/*comps.xml.gz > ${KS_BUILD}/comps.xml

# Check if we have a real ks.cfg, otherwise use the SAMPLE one for testing
if [ ! -f /ks.cfg ]; then
  KS_FILE="/ks.cfg.SAMPLE"
else
  KS_FILE="/ks.cfg"
fi
cp ${KS_FILE} ${KS_BUILD}/isolinux/ks/ks.cfg

pushd  ${KS_BUILD}/isolinux
  echo " -- Creating repo"
  createrepo -g ${KS_BUILD}/comps.xml .
popd

pushd ${KS_BUILD}
  chmod 0664 isolinux/isolinux.bin

  echo " -- Building ISO"
  mkisofs -o custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -V 'CentOS 7 x86_64' -boot-load-size 4 -boot-info-table -R -J -v -T isolinux/
popd

echo "Done"

