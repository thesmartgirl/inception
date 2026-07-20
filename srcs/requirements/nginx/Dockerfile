FROM alpine:3.22

RUN apk add --no-cache nginx openssl

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt \
    -subj "/C=TH/ST=Bangkok/L=Bangkok/O=42/OU=Inception/CN=ataan.42.fr"

CMD ["nginx", "-g", "daemon off;"]
