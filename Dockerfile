FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

COPY .mvn .mvn
COPY mvnw pom.xml ./

RUN ./mvnw dependency:go-offline -B
COPY src ./src

RUN ./mvnw package -DskipTests

# ---

FROM eclipse-temurin:21-jre AS RELEASE
WORKDIR /app

COPY --from=build /app/target/tech-chalenge-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]