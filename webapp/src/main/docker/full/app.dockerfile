FROM veronezi/sample-tomee:0.0.1-b10
WORKDIR /opt/tomee/webapps
COPY --from=veronezi/karaoke-war /opt/ /opt/tomee/webapps/ROOT
COPY --from=veronezi/karaoke-static /opt/output /opt/tomee/webapps/ROOT/app
WORKDIR /opt/tomee/