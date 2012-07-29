# vim: set ft=nginx ts=4 sw=4 sts=4 et:

server {
    listen 80;

    server_name beautyofthelove.com www.beautyofthelove.com;
    access_log /home/cfd/www/logs/beautyofthelove.access.log;
    error_log /home/cfd/www/logs/beautyofthelove.error.log;

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
