#!/usr/bin/env bash


cd /srv/coreos
curl -O https://coreos.com/security/image-signing-key/CoreOS_Image_Signing_Key.asc
gpg --import --keyid-format LONG CoreOS_Image_Signing_Key.asc

wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz.sig
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz.sig
gpg --verify coreos_production_pxe.vmlinuz.sig
gpg --verify coreos_production_pxe_image.cpio.gz.sig


