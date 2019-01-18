FROM node:alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# this EXPOSE works on AWS Beanstalk to map the port (does not impact on local)
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
