# Update hosts file (with private IP?)
echo "127.0.0.1 $(hostname)" >> /etc/hosts

# Update packages
#sudo apt-get update
#sudo apt-get -y upgrade

#associate this instance with an elastic IP (need inet access first)
#aws ec2 associate-address --allocation-id eipalloc-01b26365

# set JENKINS_HOME
# ...

# restart Jenkins
# ...
