# Cambiamos jdk17 por jdk21 para que coincida con tu compilación local
FROM tomcat:10.1-jdk21-temurin
WORKDIR /usr/local/tomcat

# Limpiar las aplicaciones por defecto de Tomcat
RUN rm -rf webapps/*

# Copiar el archivo WAR que subiste a la raíz del servidor
COPY ROOT.war webapps/ROOT.war

# Exponer el puerto por defecto
EXPOSE 8080

CMD ["catalina.sh", "run"]
