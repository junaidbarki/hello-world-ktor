# Stage 1: Build the fat JAR
FROM gradle:9.1.0-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle buildFatJar --no-daemon

# Stage 2: Run the JAR
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]