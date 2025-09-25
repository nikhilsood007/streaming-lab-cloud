FROM tiangolo/nginx-rtmp:latest

RUN mkdir -p /var/www/html/hls

RUN echo 'events { worker_connections 1024; } \
rtmp { \
    server { \
        listen 80; \
        chunk_size 4096; \
        application live { \
            live on; \
            hls on; \
            hls_path /var/www/html/hls; \
            hls_fragment 3; \
            hls_playlist_length 60; \
        } \
    } \
} \
http { \
    include /etc/nginx/mime.types; \
    server { \
        listen 8080; \
        location /hls { \
            types { \
                application/vnd.apple.mpegurl m3u8; \
                video/mp2t ts; \
            } \
            root /var/www/html; \
            add_header Cache-Control no-cache; \
            add_header Access-Control-Allow-Origin *; \
        } \
        location / { \
            return 200 "RTMP Server - Stream to rtmp://this-url:80/live/streamname"; \
            add_header Content-Type text/plain; \
        } \
    } \
}' > /etc/nginx/nginx.conf

EXPOSE 80 8080
CMD ["nginx", "-g", "daemon off;"]
