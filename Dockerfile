FROM openjdk:11
COPY target/myapp.jar /opt/app/myapp.jar
ENTRYPOINT ["java", "-jar", "/opt/app/myapp.jar"]
