#/usr/bin/env bash
#
# run once to create your terraform remote state bucket & lock table.
# these values must agree with your module arguments or defaults!

REGION="us-west-2"
STATE_BUCKET="terraform-fargate"
LOCK_TABLE="terraform_locks"

aws s3 mb --region ${REGION} s3://${STATE_BUCKET}
aws --region ${REGION} dynamodb create-table --table-name ${LOCK_TABLE} --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
