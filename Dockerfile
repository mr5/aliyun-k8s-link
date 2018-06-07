FROM nginx:1.15.0-alpine

RUN apk add --update gettext
COPY nginx.tpl /etc/nginx/nginx.tpl

ENV NGINX_DNS_RESOLVER 114.114.114.114 8.8.8.8

CMD /bin/sh -c "envsubst < /etc/nginx/nginx.tpl > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"
