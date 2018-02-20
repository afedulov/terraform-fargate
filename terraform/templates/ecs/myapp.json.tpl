[
  {
    "name": "${NAME}",
    "image": "${REPOSITORY_URL}:latest",
    "networkMode": "awsvpc",
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${LOGS_GROUP}",
          "awslogs-region": "${AWS_REGION}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "portMappings": [
      {
        "containerPort": 22,
        "hostPort": 22
      },
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]

  }
]
