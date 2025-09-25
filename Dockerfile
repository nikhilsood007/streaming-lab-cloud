FROM alpine:latest

# Install MediaMTX
RUN apk add --no-cache curl && \
    curl -L https://github.com/bluenviron/mediamtx/releases/latest/download/mediamtx_v1.8.5_linux_amd64.tar.gz | \
    tar -xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/mediamtx

# Expose ports
EXPOSE 1935 8554 8888 8889 9997 9998

# Start MediaMTX with minimal config
CMD ["/usr/local/bin/mediamtx"]
