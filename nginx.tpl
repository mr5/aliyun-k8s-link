
user  nginx;
worker_processes  1;

error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    set_real_ip_from  10.0.0.0/8;
    set_real_ip_from  192.168.0.0/16;
    set_real_ip_from  172.16.0.0/12;
    real_ip_header    X-Forwarded-For;
    real_ip_recursive on;

    include       /etc/nginx/mime.types;
    resolver ${NGINX_DNS_RESOLVER};
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;
    server {
        listen       80;
        server_name  localhost;
        location ~ /([^/]+)/(.*) {
          proxy_pass http://$1.svc.cluster.local/$2;
        }
    }
}
