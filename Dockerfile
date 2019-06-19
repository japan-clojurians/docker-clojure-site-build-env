FROM debian:9.9-slim
WORKDIR /work

ENV PO4A_VERSION="0.56" PO4A_DIR="/opt/po4a"
ENV JBAKE_VERSION="2.6.4" JBAKE_DIR="/opt/jbake"
ENV REDPEN_VERSION="1.9.0" REDPEN_DIR="/opt/redpen"

ENV PERLLIB="${PO4A_DIR}/lib" \
    PATH="${PO4A_DIR}:${JBAKE_DIR}/bin:${REDPEN_DIR}/bin:${PATH}"

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update -y && apt-get install unzip curl perl openjdk-8-jdk python3-pip python3-dev -y

RUN mkdir -p "${PO4A_DIR}" && \
    curl -L -o /tmp/po4a.tar.gz "https://github.com/mquinson/po4a/releases/download/v${PO4A_VERSION}/po4a-${PO4A_VERSION}.tar.gz" && \
    tar -xvzf /tmp/po4a.tar.gz -C ${PO4A_DIR} --strip-components=1

RUN mkdir -p "${JBAKE_DIR}" && \
    temp=$(mktemp -d) && \
    curl -L -o /tmp/jbake.zip "https://dl.bintray.com/jbake/binary/jbake-${JBAKE_VERSION}-bin.zip" && \
    unzip /tmp/jbake.zip -d "${temp}" && \
    mv ${temp}/*/* ${JBAKE_DIR} && \
    rm -rf "${temp}"

RUN mkdir -p "${REDPEN_DIR}" && \
    curl -L -o /tmp/redpen.tar.gz "https://github.com/redpen-cc/redpen/releases/download/redpen-${REDPEN_VERSION}/redpen-${REDPEN_VERSION}.tar.gz" && \
    tar xvzf /tmp/redpen.tar.gz -C ${REDPEN_DIR} --strip-components=1
