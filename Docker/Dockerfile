FROM alpine

WORKDIR /app
ADD . /app

RUN ./prepare-build.sh && ./build.sh && ./clean-build.sh

CMD cd /opt/pf-config && /app/basic_pkt_fwd

