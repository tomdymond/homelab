#!/usr/bin/env python

import requests
import sys
import os
import json
from time import sleep

if "CONSUL_SERVER" not in os.environ.keys():
  CONSUL_SERVER="127.0.0.1"
else:
  CONSUL_SERVER=os.environ["CONSUL_SERVER"]


if len(sys.argv) < 2:
  print "A host must be supplied"
  sys.exit()

SEARCH_NODE=sys.argv[1]
MAXWAIT=5

def get_nodes_from_consul():
  try:
    nodes = requests.get('http://{}:8500/v1/catalog/nodes'.format(CONSUL_SERVER)).json()
  except:
    nodes = json.loads(open('/tmp/sample.json').read())
  return nodes

def get_node():
  nodes = get_nodes_from_consul()
  for node in nodes:
    if SEARCH_NODE in node['Node']:
      return node['Address']

def write_node_ip(node_ip):
  with open("/data/bootstrap_ip", "wb") as f:
    f.write(node_ip)

wait_count = 0
while True:
  node_ip = get_node()
  if wait_count > MAXWAIT:
    print "Gave up waiting for node {} to appear in consul".format(SEARCH_NODE)
    sys.exit(1)
  if node_ip:
    write_node_ip(node_ip)
    print json.dumps({SEARCH_NODE: node_ip})
    sys.exit(0)
  else:
    print "Waiting to find {} in consul".format(SEARCH_NODE)
    sleep(10)
    wait_count += 1


