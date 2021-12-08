ARG VARIANT=17-jdk-alpine
FROM openjdk:${VARIANT}

ENV PLANTUML_VERSION=1.2021.15
ENV PLANTUML_JAR=/plantuml.jar

ENV LANG en_GB.UTF-8

RUN (\
    set -eux; \
    apk add --no-cache graphviz wget ca-certificates ttf-dejavu fontconfig ; \
    wget -O ${PLANTUML_JAR} https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar; \
    java -Djava.awt.headless=true -jar ${PLANTUML_JAR} -version; \
    dot -version; \
)

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/plantuml.jar"]
