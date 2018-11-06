FROM karaoke-tomee
WORKDIR /opt/tomee/webapps
COPY --from=karaoke-war /opt/ /opt/tomee/webapps/ROOT
COPY --from=karaoke-static /opt/output /opt/tomee/webapps/ROOT/app
WORKDIR /opt/tomee/