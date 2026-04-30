# Stage 1: Build
FROM gradle:9.1.0-jdk21 AS build
WORKDIR /app
COPY gradle/ gradle/
COPY gradlew .
COPY gradlew.bat .
COPY settings.gradle.kts .
COPY build.gradle.kts .
RUN gradle dependencies --no-daemon || return 0
COPY src/ src/
RUN gradle buildFatJar --no-daemon --stacktrace

# Stage 2: Run
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENV PORT=8080
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]