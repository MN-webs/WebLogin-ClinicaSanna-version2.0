# Usar directamente la imagen oficial de Tomcat 10.1 (basada en JDK 17)
FROM tomcat:10.1-jdk17-temurin
WORKDIR /usr/local/tomcat

# Limpiar las aplicaciones de prueba que vienen por defecto en Tomcat
RUN rm -rf webapps/*

# Copiar el archivo WAR que subiste a la raíz del servidor
COPY ROOT.war webapps/ROOT.war

# Exponer el puerto por defecto
EXPOSE 8080

CMD ["catalina.sh", "run"]
