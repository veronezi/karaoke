FROM veronezi/sample-tomee:0.0.1-b5
WORKDIR /opt/tomee/webapps
COPY --from=karaoke-war /opt/ /opt/tomee/webapps/ROOT
COPY --from=karaoke-static /opt/output /opt/tomee/webapps/ROOT/app
WORKDIR /opt/tomee/