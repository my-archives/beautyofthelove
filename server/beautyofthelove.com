# vim: set ft=nginx ts=4 sw=4 sts=4 et:

http {
    proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=one:8m max_size=3000m inactive=600m;
    proxy_temp_path /var/tmp;
    include mime.types;
    default_type application/octet-stream;
    sendfile on;
    keepalive_timeout 65;

    gzip on;
    gzip_comp_level 6;
    gzip_vary on;
    gzip_min_length  1000;
    gzip_proxied any;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
    gzip_buffers 16 8k;

    # proxy node express
    upstream beautyofthelove_upstream {
      server 127.0.0.1:45920;
      #server 127.0.0.1:61338;
      keepalive 64;
    }

    server {
        listen 80;

        server_name beautyofthelove.com www.beautyofthelove.com;

        if ($host = 'beautyofthelove.com' ) {
            rewrite  ^/(.*)$  http://www.beautyofthelove.com/$1 permanent;
        }

        error_page 502  /errors/502.html;

        location /errors {
          internal;
          alias /home/cfd/www/beautyofthelove.com/public/errors;
        }

        location ~ ^/(images/|img/|javascripts/|js/|css/|stylesheets/|flash/|media/|static/|robots.txt|humans.txt|favicon.ico) {
          root /home/cfd/www/beautyofthelove.com/public;
          access_log off;
          expires max;
        }

        location / {
          proxy_redirect off;
          proxy_set_header   X-Real-IP            $remote_addr;
          proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
          proxy_set_header   X-Forwarded-Proto $scheme;
          proxy_set_header   Host                   $http_host;
          proxy_set_header   X-NginX-Proxy    true;
          proxy_set_header   Connection "";
          proxy_http_version 1.1;
          proxy_cache one;
          proxy_cache_key sfs$request_uri$scheme;
          proxy_pass         http://beautyofthelove_upstream;
        }
    }
}
