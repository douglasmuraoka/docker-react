# The first phase is the build phase, which the npm installs
# all the project dependencies and generate the production
# version of the project at the /app/build directory.
FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# This is the deploy phase, which uses nginx as base image,
# and deploys the /app/build as static content of our nginx
# server.
# Note: when running this container, do not forget to map
# the port to get access to the nginx server.
# Example: docker run <image_id> -p 8080:80
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html