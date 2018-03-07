#!/usr/bin/env bash
docker build -t mesosphere-bootstrap-discovery .
docker tag mesosphere-bootstrap-discovery tomdymond/mesosphere-bootstrap-discovery
