############################################################
# Base Image: Node
############################################################

FROM node:16-alpine AS build

# Set working directory
WORKDIR '/usr/app'

# Dependencies
COPY ./package.json ./

RUN npm install 

COPY ./ ./

# Docker run build (not start) as this is the production setup
RUN npm run build



############################################################
# Base Image: Nginx
############################################################

# This is the final/main image we will be using
FROM nginx

# Port to expose on EC2
EXPOSE 80

# We only need the build directory from the React node above
COPY --from=build /usr/app/build /usr/share/nginx/html