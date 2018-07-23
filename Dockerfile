FROM gliderlabs/logspout:latest

ADD https://papertrailapp.com/tools/papertrail-bundle.pem /etc/ssl/ca-bundle.pem
RUN cp /etc/ssl/ca-bundle.pem /etc/ssl/certs/ca-certificates.crt
