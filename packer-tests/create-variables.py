#!/usr/bin/env python

import json
import os
import requests


os.environ['PACKER_BUILD_CENTOS_VERSION'] = "7"
os.environ['PACKER_BUILD_CENTOS_ISO'] = "CentOS-7-x86_64-Minimal-1804.iso"
os.environ['PACKER_BUILD_CENTOS_ISO_CHECKSUM_TYPE'] = "sha256"
os.environ['PACKER_BUILD_CENTOS_MIRROR_URL'] = "http://mirrors.ocf.berkeley.edu"
os.environ['PACKER_BUILD_COREOS_CHANNEL'] = "stable"
os.environ['PACKER_BUILD_COREOS_VERSION'] = "current"
os.environ['PACKER_BUILD_COREOS_ISO'] = "coreos_production_iso_image.iso"
os.environ['PACKER_BUILD_COREOS_ISO_CHECKSUM_TYPE'] = "md5"
os.environ['PACKER_BUILD_AWS_SSH_PRIVATE_KEY_FILE'] = "/Users/tdy02/Downloads/tom-aws-virginia.pem"



def get_config():
  config = {}
  for k, v in os.environ.items():
    if 'PACKER_BUILD' in k:
      k_new = k.split('PACKER_BUILD_')[1].lower()
      config[k_new] = v
  return config


def get_centos_hash():
  request = requests.get("{}/centos/{}/isos/x86_64/{}sum.txt".format(config["centos_mirror_url"], config["centos_version"], config["centos_iso_checksum_type"]))
  return request.text

def get_coreos_hash():
  request = requests.get("http://{}.release.core-os.net/amd64-usr/{}/coreos_production_iso_image.iso.DIGESTS".format(config['coreos_channel'], config['coreos_version']))
  return request.text

def make_os_hashmap(hashstring):
  hashes = {}
  for i in hashstring.split('\n'):
    j = ' '.join(i.split())
    if j and '#' not in j:
      f = j.split(' ')
      hashes[f[1]] = f[0]
  return hashes


config = get_config()
coreos_hashes = get_coreos_hash()
centos_hashes = get_centos_hash()

try:
  config['centos_iso_checksum'] = make_os_hashmap(centos_hashes)[config['centos_iso']]
except Exception as e:
  print e.message
  print make_os_hashmap(centos_hashes)
config['coreos_iso_checksum'] = make_os_hashmap(coreos_hashes)[config['coreos_iso']]

with open('variables.json','wb') as f:
  f.write(json.dumps(config))

