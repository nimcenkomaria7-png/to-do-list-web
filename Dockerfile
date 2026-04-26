# Стадия сборки 
FROM node:22 AS build 
WORKDIR /app 
COPY package*.json ./ 
RUN npm ci 
COPY . . 
RUN npm run build 
 
# Стадия развёртывания 
FROM nginx:stable-alpine AS production 
COPY --from=build /app/dist /usr/share/nginx/html 
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
