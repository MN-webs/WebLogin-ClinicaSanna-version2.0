# 1. Fase de Compilación (Build) usando Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar los archivos de configuración y código fuente
COPY pom.xml .
COPY src ./src

# Compilar y empaquetar el archivo .war omitiendo los tests si existen
RUN mvn clean package -DskipTests

# 2. Fase de Ejecución usando Apache Tomcat 10.1
FROM tomcat:10.1-jdk17-temurin
WORKDIR /usr/local/tomcat

# Eliminar las aplicaciones por defecto de Tomcat para limpiar el contexto
RUN rm -rf webapps/*

# Copiar el archivo WAR compilado desde la fase anterior y renombrarlo como ROOT.war
# Esto hace que tu aplicación responda directamente en la raíz de la URL (/)
COPY --from=build /app/target/*.war webapps/ROOT.war

# Exponer el puerto por defecto de Tomcat
EXPOSE 8080

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
