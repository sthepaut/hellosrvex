FROM maven:3.5.2-jdk-8-alpine AS mavenim
COPY pom.xml /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn package

FROM java:8-jdk-alpine
VOLUME /tmp
EXPOSE 8080
COPY --from=mavenim /tmp/target/hellosrv-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]