# Use Maven for build
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Use JRE 17 for runtime
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
COPY public ./public
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
