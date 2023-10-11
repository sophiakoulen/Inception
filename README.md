# Inception

Inception is a project from 42Lausanne in which we have to work with Docker.
The goal is to create some Docker images and make them work together using docker-compose.

## Some tips and tricks

- Use `envsubst` to replace environment variables in a file. This is used in Nginx's official Docker image.
- Use `set -e` at the top of each "entrypoint" script to ensure that if one step fails, the container restarts.
