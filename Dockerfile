# Fase 1: Compilación con Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar la configuración
COPY pom.xml .

# Copiar las carpetas nativas de NetBeans
COPY src/ ./src/
COPY web/ ./web/

# Compilar el proyecto
RUN mvn clean package -DskipTests

# Fase 2: Servidor Tomcat para correr la app
FROM tomcat:10.1-jdk17-temurin
WORKDIR /usr/local/tomcat

# Limpiar aplicaciones por defecto
RUN rm -rf webapps/*

# Copiar el resultado final a la raíz de Tomcat
COPY --from=build /app/target/ROOT.war webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
