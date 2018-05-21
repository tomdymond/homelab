all: build-centos build-coreos

build-centos: prepare variables.json centos-web centos-app centos-db

build-coreos: prepare variables.json coreos


centos-web: variables.json
	packer build -force \
	-var-file secrets.json \
	-var-file variables.json \
	-var 'node_role=web' \
	centos.json

centos-app: variables.json
	packer build -force \
	-var-file secrets.json \
	-var-file variables.json \
	-var 'node_role=app' \
	centos.json

centos-db: variables.json
	packer build -force \
	-var-file secrets.json \
	-var-file variables.json \
	-var 'node_role=db' \
	centos.json

variables.json:
	python create-variables.py

coreos:
	packer build -force \
	-var-file secrets.json \
	-var-file variables.json \
	-var 'node_role=db' \
	coreos.json

prepare: clean-builds clean-config
	mkdir -p builds
	mkdir -p packer_cache

clean-config:
	rm -f variables.json

clean-builds:
	rm -rf builds

clean-cache:
	rm -rf packer_cache


clean: clean-builds clean-cache clean-config

.PHONY: clean build clean-builds clean-cache generate

