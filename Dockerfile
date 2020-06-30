FROM node:12.13.0 as builder

WORKDIR /app/website
COPY website/package*.json ./
RUN npm config set registry https://npm.generalmills.com/
RUN npm ci
COPY docs /app/docs
COPY website ./
RUN npm run build

FROM nginxinc/nginx-unprivileged:1.16.0-alpine
LABEL com.jfrog.artifactory.retention.maxCount="1"

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/website/build/cloud-native-wiki /usr/share/nginx/html
