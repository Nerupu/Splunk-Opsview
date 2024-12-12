#!/bin/bash


OSINF=$(cat /etc/os-release | grep '^NAME' | awk -F'=' '{print $2}')

if [[ "$OSINF" =~ Red\ Hat* ]]
	
	then
	
	## Install nvme - tool
	
	sudo yum install nvme-cli -y > /dev/null 2>&1
	
	## Get count
	
	device_count=$(lsblk -d | grep nvme | wc -l)
	
	if [[ "$device_count" -ge 2 ]]
		
		then
		
		## Iteration to create symbolic link
		
		for os_device_name in /dev/nvme[1-$(printf '%x\n' $device_count)]n1
		
		do
			
			ebs_device_name=$(sudo nvme id-ns "$os_device_name" -v -b  | awk '{print $2}' | tr -d '\0')
			
			cd /dev/
			
			nvm_dev_name=$(echo $os_device_name | awk -F'/' '{print $3}')
			
			ln -s ${nvm_dev_name} ${ebs_device_name} > /dev/null 2>&1
			
		done
		
	fi
fi