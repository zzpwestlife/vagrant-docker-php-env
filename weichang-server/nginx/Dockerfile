FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites/* /etc/nginx/conf.d/
COPY  ssl-cert/ssl.key /etc/nginx/ssl-cert/ssl.key
COPY ssl-cert/ssl.crt /etc/nginx/ssl-cert/ssl.crt
VOLUME ["/var/www", "/etc/nginx/conf.d"]