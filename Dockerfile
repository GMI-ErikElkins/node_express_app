FROM node:12.13.0 as builder

WORKDIR /app/website
COPY website/package*.json ./
RUN npm ci
COPY docs /app/docs
COPY website ./
RUN npm run build

FROM nginxinc/nginx-unprivileged:1.16.0-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/website/build/cloud-native-wiki /usr/share/nginx/html
