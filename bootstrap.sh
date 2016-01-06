# Update hosts file with private ip
echo "127.0.0.1 $(hostname)" >> /etc/hosts

# Update packages (several minutes)
#sudo apt-get update
#sudo apt-get -y upgrade

#install AWS CLI (1-2 mins)
sudo apt-get -y install awscli

#associate this instance with an elastic IP
MY_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 associate-address --region us-east-1 --instance-id "$MY_INSTANCE_ID" --allocation-id eipalloc-01b26365

# stop jenkins and purge default jenkins_home
sudo service jenkins-oc stop
sudo rm -rf /var/lib/jenkins-oc/*

#mount NFS storage
sudo apt-get -y install nfs-common
sudo mount -t nfs 10.0.2.83:/var/lib/cjoc /var/lib/jenkins-oc
#TODO use elastic IP

# start Jenkins
sudo service jenkins-oc start

#install Amazon CloudWatch Monitoring Scripts
sudo apt-get -y install unzip
sudo apt-get -y install libwww-perl libdatetime-perl

wget http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip
unzip CloudWatchMonitoringScripts-1.2.1.zip
rm CloudWatchMonitoringScripts-1.2.1.zip

#set a cron schedule for metrics reported to CloudWatch
(crontab -l ; echo "*/5 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron") | crontab -
