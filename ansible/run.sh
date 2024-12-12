# !/bin/bash
set -e
export S3_BUCKET_NAME='eaf-777506782670-opsview-eu-west-2'
export SPLUNK_ADMIN_PASSWORD='hzflgqDTLxwJpfbTltf0kyKWMmph2qPp'
export SPLUNK_CLUSTER_PASSWORD='xaw3oqkzfAVmL^ghze4@AzbuOfA0ayxD'
export REGION='eu-west-2'

ENVIRONMENT=dev01
ENVIRONMENT_DIRECTORY=env/$ENVIRONMENT

ansible-playbook -i $ENVIRONMENT_DIRECTORY site.yaml | tee >(xargs -L1 echo | while IFS= read -r line; do echo "$(date '+%Y-%m-%d %H:%M:%S') $line"; done >> ansible.log)

# aws ssm start-session --target i-0bc83d125a450520c --document-name AWS-StartPortForwardingSession --parameters '{"portNumber":["8000"],"localPortNumber":["8000"]}'