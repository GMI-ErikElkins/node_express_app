FROM node:12.13.0 as builder

WORKDIR /app/website
COPY package*.json ./
RUN npm ci

FROM nginxinc/nginx-unprivileged:1.16.0-alpine

