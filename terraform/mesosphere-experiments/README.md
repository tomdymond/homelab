[WIP]

Considering a few things here to avoid cyclic dependency

- Bootstrap node needs to know the IP addresses of masters and slaves. It gets this by using the terraform output
- Master/Slave nodes need to know the IP bootstrap node. 
  - Launch a container that will continuosly poll consul waiting for the bootstrap node to come online. Write BOOTSTRAP_NODE ip to /etc/mesos_bootstrap_node
  - Launch mesosphere-stack systemd service (read in /etc/mesos_bootstrap_node) once bootstrap node is online
