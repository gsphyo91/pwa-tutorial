FROM node:14.15.0-alpine as builder

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json /app/package.json

# RUN npm install
RUN yarn

COPY . /app
# RUN npm run build
RUN yarn build

FROM nginx:alpine

RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx

COPY --from=builder /app/build /usr/chare/nginx/html

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]