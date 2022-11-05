FROM neilpang/acme.sh

RUN apk add --no-cache --virtual .bin-deps bash 

SHELL ["/bin/bash", "-c"]

COPY . /fwacme/

WORKDIR /fwacme

RUN chmod +x ./install_cert.sh

ENTRYPOINT [ "/bin/bash", "./entry.sh" ]
