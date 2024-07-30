FROM maven:3.9.8-amazoncorretto-21-al2023 AS maven
WORKDIR /
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests=true

FROM openjdk:21-slim
WORKDIR /
COPY --from=maven /target/*.jar server-mock.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","server-mock.jar"]