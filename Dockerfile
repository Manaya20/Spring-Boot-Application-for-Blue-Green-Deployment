# Use the official OpenJDK image from the Docker Hub
FROM openjdk:11-jdk-slim

# Add the JAR file to the container
COPY target/myapp.jar /opt/myapp/myapp.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/opt/myapp/myapp.jar"]

# Expose the port the app runs on
EXPOSE 8080
