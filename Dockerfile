FROM tomcat:8
# take the war and copy into webapps in tom cat
COPY  /home/ec2-user/jenkins/workspace/build13/target/*.war /usr/local/tomcat/webapps/myweb.war
CMD ["catalina.sh", "run"]
