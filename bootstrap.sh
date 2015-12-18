#associate this instance with an elastic IP
aws ec2 associate-address --allocation-id eipalloc-01b26365

# Update hosts file
echo "127.0.0.1 $(hostname)" >> /etc/hosts

# Update packages
sudo apt-get update
sudo apt-get upgrade

# set JENKINS_HOME
# ...

# restart Jenkins
# ...
