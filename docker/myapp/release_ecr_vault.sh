NAME=myapp
AWS_VAULT_PROFILE=private

docker build -t ${NAME} .
aws-vault exec ${AWS_VAULT_PROFILE} -- aws ecr get-login --no-include-email --region us-east-1 > docker_login
source docker_login
rm docker_login
docker tag ${NAME}:latest ${REPO_URL}:latest
docker push ${REPO_URL}:latest
