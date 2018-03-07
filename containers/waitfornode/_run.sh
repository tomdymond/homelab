#!/usr/bin/env bash
docker run -v $(pwd)/data:/data mesosphere-bootstrap-discovery $@
