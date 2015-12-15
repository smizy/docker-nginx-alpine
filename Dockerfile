# FROM alpine:3.2
FROM gliderlabs/alpine
MAINTAINER smizy

RUN adduser -D -g '' -u 1000 docker 

RUN apk --update add \
	nginx \
	ca-certificates \
	&& \
	rm -rf /var/cache/apk/* && \
	ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log && \
	mkdir -p /tmp/nginx/client-body

ADD nginx.conf /etc/nginx/
ADD server.conf /etc/nginx/conf.d/

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]