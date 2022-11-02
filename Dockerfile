FROM neilpang/acme.sh

COPY ./dhparams.pem /etc/nginx/certs/dhparams.pem 

RUN apk add --no-cache --virtual .bin-deps bash 

SHELL ["/bin/bash", "-c"]

COPY . /fwacme/

WORKDIR /fwacme

RUN chmod +x ./install_cert.sh

ENTRYPOINT [ "/bin/bash", "./entry.sh" ]
