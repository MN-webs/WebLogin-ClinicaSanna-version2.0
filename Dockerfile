# Fase 1: Compilación con Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar configuración de dependencias
COPY pom.xml .

# Copiar los códigos fuentes y páginas según la estructura de NetBeans
COPY src/ ./src/
COPY web/ ./web/

# Ejecutar compilación limpia omitiendo pruebas
RUN mvn clean package -DskipTests

# Fase 2: Servidor de Despliegue con Tomcat 10.1
FROM tomcat:10.1-jdk17-temurin
WORKDIR /usr/local/tomcat

# Limpiar las aplicaciones de prueba por defecto de Tomcat
RUN rm -rf webapps/*

# Copiar el binario empaquetado directamente a la raíz del servidor web
COPY --from=build /app/target/ROOT.war webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
