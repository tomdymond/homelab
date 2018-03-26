#!/usr/bin/env bash

cd /data
if [ ! -f CentOS-7-x86_64-DVD-1708.iso ]; then
  wget http://www.mirrorservice.org/sites/mirror.centos.org/7/isos/x86_64/CentOS-7-x86_64-DVD-1708.iso
fi

mount -o loop CentOS-7-x86_64-DVD-1708.iso /mnt


KS_BUILD="/data/kickstart_build"

rm -rf ${KS_BUILD}

mkdir -p ${KS_BUILD}/{isolinux,utils}
mkdir -p ${KS_BUILD}/isolinux/{images,ks,LiveOS,Packages}

cp -r /mnt/isolinux/* ${KS_BUILD}/isolinux/
cp /mnt/.discinfo ${KS_BUILD}/isolinux/
cp -r /mnt/images/* ${KS_BUILD}/isolinux/images/ 
cp -r /mnt/LiveOS/* ${KS_BUILD}/isolinux/LiveOS/ 
cp -r /mnt/Packages/* ${KS_BUILD}/isolinux/Packages/
cp /isolinux.cfg ${KS_BUILD}/isolinux/isolinux.cfg
gunzip -c /mnt/repodata/*comps.xml.gz > ${KS_BUILD}/comps.xml

cp /ks.cfg ${KS_BUILD}/isolinux/ks/

cd ${KS_BUILD}/isolinux
echo " -- Creating repo"
createrepo -g ${KS_BUILD}/comps.xml .

cd ${KS_BUILD}
chmod 0664 isolinux/isolinux.bin

echo " -- Building ISO"
mkisofs -o custom.iso -b isolinux.bin -c boot.cat -no-emul-boot -V 'CentOS 7 x86_64' -boot-load-size 4 -boot-info-table -R -J -v -T isolinux/

echo "Done"

