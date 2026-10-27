FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY FlightServer.java index.html mysql-connector-j-26.7.0.jar ./
RUN javac -cp mysql-connector-j-26.7.0.jar FlightServer.java

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/FlightServer*.class ./
COPY --from=build /app/index.html ./
COPY --from=build /app/mysql-connector-j-26.7.0.jar ./
ENV PORT=10000
EXPOSE 10000
CMD ["sh", "-c", "java -cp .:mysql-connector-j-26.7.0.jar FlightServer \"${PORT:-10000}\"]
