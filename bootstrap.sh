# Update hosts file (with private IP?)
echo "127.0.0.1 $(hostname)" >> /etc/hosts

# Update packages (several minutes)
#sudo apt-get update
#sudo apt-get -y upgrade

#install AWS CLI (1-2 mins)
sudo apt-get -y install awscli

#associate this instance with an elastic IP
MY_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 associate-address --region us-east-1 --instance-id "$MY_INSTANCE_ID" --allocation-id eipalloc-01b26365

# set JENKINS_HOME
# ...

# restart Jenkins
# ...
