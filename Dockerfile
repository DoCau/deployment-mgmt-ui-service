FROM node:18-alpine AS stage_build
WORKDIR /app
COPY package*.json ./
RUN npm install --save-dev web-vitals
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=stage_build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]