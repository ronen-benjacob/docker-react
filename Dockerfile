# Build phase of the project (most of it will be removed after copy the deployment files)
FROM node:alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Start the Production web server to serve the app
# using another FROM statement make the previous block not actve anymore
FROM nginx
# copy the build folder (that contain the files to serve to the clients) from the previous stage to a shared folder
# of nginx as stated in the image's help page in docker hub website
COPY --from=builder /app/build /usr/share/nginx/html
 
 # we don't have to run anything to run nginx because this is the defualt command
 # RUN