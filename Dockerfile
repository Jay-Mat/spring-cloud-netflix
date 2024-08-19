FROM maven:9.8.3-jdk-17-slim AS build

# Copy the application source code to the container
COPY . /app

# Set the working directory to the application directory
WORKDIR /app

# Build the application using Maven
RUN mvn clean package

# Create a new image based on the build image
FROM openjdk:17-jre-slim

# Copy the built application JAR file from the build image
COPY --from=build /app/target/*.jar /app/

# Set the working directory to the application directory
WORKDIR /app

# Run the application JAR file
CMD ["java", "-jar", "*.jar"]