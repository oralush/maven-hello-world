FROM maven:3-jdk-8-alpine AS build
COPY my-app app
WORKDIR /my-app
RUN cd app && ls && mvn package -f pom.xml



FROM openjdk:8-jdk-alpine
ARG fullname
RUN addgroup -S appgroup && adduser -S zorki -G appgroup
USER zorki
COPY --from=build app/target/my-app/${fullname}.jar ${fullname}.jar
ENV fulljar=${fullname}.jar
RUN ls && pwd
RUN java -jar my-app-2.0.1.jar
CMD exec java -jar ${fulljar}

