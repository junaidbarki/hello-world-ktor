# Stage 1: Build
FROM gradle:9.1.0-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle buildFatJar --no-daemon

# Stage 2: Run
FROM eclipse-temurin:21-jre-jammy
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]