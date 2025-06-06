FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-21-jdk -y
WORKDIR /app
COPY . .
RUN chmod +x gradlew
RUN ./gradlew bootjar --no-daemon

#RUN STAGE
FROM eclipse-temurin:21
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/build/libs/renderapp-1.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]