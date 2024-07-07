FROM maven:3.9.8-amazoncorretto-21-al2023 as maven
WORKDIR /
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests=true

FROM openjdk:21-slim
WORKDIR /
COPY --from=maven /target/*.jar app.jar
ENV SERVER_PORT=8081
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]