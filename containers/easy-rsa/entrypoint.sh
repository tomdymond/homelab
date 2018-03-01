#!/bin/sh

export EASYRSA=/usr/share/easy-rsa/easyrsa3
export EASYRSA_PKI=/easy-rsa/pki

export PATH=${EASYRSA}:$PATH

easyrsa $@
