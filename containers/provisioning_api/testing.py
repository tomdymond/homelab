#!/usr/bin/env python

import ConfigParser, os
import requests
import sys

config = ConfigParser.RawConfigParser(allow_no_value=True)
config.readfp(open('{}/.ilo.conf'.format(os.environ['HOME'])))

cidata = {"foo": "bar"}

if len(sys.argv) < 2:
  print "Specify ILO IP as argument"
  sys.exit()

payload = {
  "ilo_ip": sys.argv[1],
  "role": "foo",
  "iso_version": "2333",
  "cidata": cidata,
  "ilo_user": config.get('ilo', 'login'),
  "ilo_password": config.get('ilo', 'password'),
  "seed_node": "127.0.0.1"
}

r = requests.post('http://127.0.0.1:5000/provision', json=payload)
print r.text

