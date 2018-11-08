FROM node:${node.version}
RUN mkdir -p /opt/base
WORKDIR /opt/base
COPY base/package.json /opt/base/

RUN addgroup --system jdoe
RUN adduser --system --ingroup jdoe jdoe

RUN chown jdoe:jdoe -R /opt

USER jdoe

# install packages from the official package.json
RUN npm install
