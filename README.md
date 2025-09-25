# Streaming Lab Cloud

Simple MediaMTX streaming server for cloud deployment.

## Usage:
- Stream to: rtmp://your-app.onrender.com:1935/live/test
- View at: https://your-app.onrender.com:8888/live/test/index.m3u8

## FFmpeg Command:
ffmpeg -re -i your-video.mp4 -c:v libx264 -preset veryfast -c:a aac -f flv rtmp://your-app.onrender.com:1935/live/test

Cloud version of the streaming lab.
