ARG JDK_VERSION=23
ARG BASE_IMAGE_VARIANT=alpine
ARG PLANTUML_VERSION=1.2025.2

FROM eclipse-temurin:${JDK_VERSION}-${BASE_IMAGE_VARIANT}

ENV PLANTUML_JAR=/plantuml.jar
ENV LANG=en_GB.UTF-8

RUN (\
    set -eux; \
    apk add --no-cache graphviz wget ca-certificates font-noto fontconfig make; \
    wget -q -O ${PLANTUML_JAR} https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar; \
    java -Djava.awt.headless=true -jar ${PLANTUML_JAR} -version; \
    dot -version; \
    make --version; \
    )

ADD fontconfig.conf /etc/fonts/conf.d/91-local.conf

ENV PLANTUML_VERSION=${PLANTUML_VERSION}

ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/plantuml.jar"]
