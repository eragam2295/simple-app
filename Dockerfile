FROM tomcat:8
# take the war and copy into webapps in tom cat
COPY target/*.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]
