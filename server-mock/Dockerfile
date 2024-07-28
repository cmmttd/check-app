FROM maven:3.9.8-amazoncorretto-21-al2023 as maven
WORKDIR /
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests=true

FROM openjdk:21-slim
WORKDIR /
COPY --from=maven /target/*.jar app.jar
ENV SERVER_PORT=443
ENV SELF_SIGNED_CERT_PASSWORD=${SELF_SIGNED_CERT_PASSWORD}
EXPOSE 443
ENTRYPOINT ["java","-jar","app.jar"]