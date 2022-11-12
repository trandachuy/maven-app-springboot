#FROM maven:3.6.0-jdk-11-slim AS build
#COPY src/ /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean install

#FROM openjdk:11-jre-slim
#COPY --from=build /home/app/target/*-*.*.*-SNAPSHOT.jar /usr/local/lib/demo.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]

FROM maven:3.8-jdk-8 AS build  
COPY src /usr/src/app/src  
COPY pom.xml /usr/src/app  
RUN mvn -f /usr/src/app/pom.xml clean install

FROM gcr.io/distroless/java  
COPY --from=build /usr/src/app/target/test-0.0.1-SNAPSHOT.jar /usr/app/test-0.0.1-SNAPSHOT.jar
EXPOSE 8080  
ENTRYPOINT ["java","-jar","/usr/app/test-0.0.1-SNAPSHOT.jar"]  
