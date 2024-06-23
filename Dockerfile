FROM nginx:alpine

RUN tree
COPY ./frontend/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
