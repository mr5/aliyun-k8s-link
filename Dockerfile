FROM nginx:1.15.0-alpine
RUN apk add --update gettext
COPY nginx.tpl /etc/nginx/nginx.tpl

CMD /bin/sh -c "export NGINX_DNS_RESOLVER=`cat /etc/resolv.conf | awk '/nameserver/{print $2}' | awk '{printf(\"%s \", $0)}'` && echo \"dns resolver: \$NGINX_DNS_RESOLVER\" && envsubst < /etc/nginx/nginx.tpl > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"
