FROM tiangolo/nginx-rtmp:latest

# Create nginx config
RUN echo 'events { worker_connections 1024; } \
rtmp { \
    server { \
        listen 1935; \
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
        listen 8888; \
        location /hls { \
            types { \
                application/vnd.apple.mpegurl m3u8; \
                video/mp2t ts; \
            } \
            root /var/www/html; \
            add_header Cache-Control no-cache; \
            add_header Access-Control-Allow-Origin *; \
        } \
    } \
}' > /etc/nginx/nginx.conf

EXPOSE 1935 8888
CMD ["nginx", "-g", "daemon off;"]
