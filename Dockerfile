# multi-steps
FROM node:alpine as builder

WORKDIR /app

COPY ./package*.json ./

RUN npm install

# copy source files execept those files specified in .gitignore
COPY . .

# build folder will be inside container, under /app/build
RUN npm run build

# we can't use the development server from React, therefore has to put in nginx
FROM nginx
EXPOSE 80
# copy our predefined nginx config file, into docker container  /etc/nginx/conf.d/default.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf 

# copy the whole /app/build folder generated from last step, and put into /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html