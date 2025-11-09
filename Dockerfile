## build stage ##

FROM maven:3.5.3-jdk-8-alpine AS build
WORKDIR /app
COPY . .
RUN mvn install -DskipTests=True

## run stage ##
FROM alpine:3.19
RUN adduser -D goldenowl
RUN apk add openjdk8
WORKDIR /run
COPY --from=build /app/target/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar
RUN chown -R goldenowl:goldenowl /run
USER goldenowl
EXPOSE 8080
ENTRYPOINT java -jar /run/shoe-ShoppingCart-0.0.1-SNAPSHOT.jar
