FROM registry.hub.docker.com/library/node:12-bullseye as build
RUN apt update && apt install -y python3 g++ make
RUN npm install --unsafe-perm -g cncjs@1.9.24

FROM registry.hub.docker.com/library/node:12-bullseye-slim
COPY --from=build /usr/local /usr/local
RUN apt update && apt install -y udev socat && apt clean

VOLUME /config
COPY cncjs.json /config/cncjs.json

EXPOSE 80
CMD /usr/local/bin/cncjs -H 0.0.0.0 -p 80 -c /config/cncjs.json