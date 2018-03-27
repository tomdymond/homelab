#!/usr/bin/env python

from flask import Flask
from flask import request
import json
import os 
import sys
import hpilo

app = Flask(__name__)

if 'DATADIR' not in os.environ:
    DATADIR="/tmp"

ISO_URL = "http://{}/iso/{}"



class myIlo(object):
    def __init__(self, ip, ILO_USER, ilo_password, cidata, seed_node, iso_version):
        self.obj = hpilo.Ilo(ip, login=ILO_USER, password=ilo_password)
        self.cidata = cidata
        self.seed_node = seed_node
        self.iso_version = iso_version


    def eject_cd(self):
        """ """
        try:
            return self.obj.eject_virtual_media()
        except Exception as e:
            pass

    def get_mac_address(self):
        """ """
        try:
            for i in self.obj.get_host_data():
                if 'Port' in i.keys():
                    if i['Port'] == 'iLO':
                        return i['MAC']
        except Exception as e:
            print e.message
            return False
        
    def write_cloudinit_data(self):
        """ Write out cloud-init data """
        print "write_cloudinit_data"
        try:
            with open('{}/{}.json'.format(DATADIR, self.get_mac_address()), 'wb') as f:
                f.write(json.dumps(self.cidata))
            return True
        except Exception as e:
            print e.message
            return False

    def insert_cd(self):
        """ """
        try:
            self.obj.insert_virtual_media("cdrom", ISO_URL.format(self.seed_node, self.iso_version))
            self.obj.set_vm_status()
            return True
            
        except Exception as e:
            print e.message
            return False


    def reset_server(self):
        """ """
        try:
            print "Reset server"
            #self.obj.reset_server()
            return True
        except Exception as e:
            print e.message
            return False

@app.route('/provision', methods=['POST', 'GET'])
def index():


    data = json.loads(request.data)
    print data
    cidata = data['cidata']
    seed_node = data['seed_node']
    iso_version = data['iso_version']
    ilo_ip = data['ilo_ip']
    ilo_user = data['ilo_user']
    ilo_password = data['ilo_password']
    ilo_obj = myIlo(ilo_ip, ilo_user, ilo_password, cidata, seed_node, iso_version)

    try:
        print ilo_obj.obj.get_vm_status()
    except Exception as e:
        print e.message
        return "Failed to access ILO"


    ilo_obj.eject_cd()
    if ilo_obj.write_cloudinit_data():
        if ilo_obj.insert_cd():
            if ilo_obj.reset_server():
                return "Everying was successful"
        else:
            return "Failed to insert CD"
    else:
        return "Failed to write cloudinit file"
    


if __name__ == '__main__':
    app.run(debug=True, host= '0.0.0.0')


