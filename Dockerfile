FROM debian:9-slim

ARG MKSPIFFS_ARCH

ENV IDF_PATH /opt/esp-idf
ENV IDF_VERSION v4.0
ENV MKSPIFFS_VERSION 0.2.3

RUN apt update && \
        apt install -y git wget flex bison gperf cmake ninja-build ccache libffi-dev libssl-dev python3 python3-pip python3-setuptools libusb-1.0-0 libncurses-dev && \
        update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN git clone --recursive https://github.com/espressif/esp-idf.git -b $IDF_VERSION $IDF_PATH && \
    sed -i "s/'virtualenv', '--no-site-packages'/'virtualenv'/g" \
           $IDF_PATH/tools/idf_tools.py && \
    (cd $IDF_PATH ; ./install.sh ) && \
    rm -rf $IDF_PATH/examples

RUN apt install -y curl && \
    curl -Lo - "https://github.com/igrr/mkspiffs/releases/download/${MKSPIFFS_VERSION}/mkspiffs-${MKSPIFFS_VERSION}-esp-idf-${MKSPIFFS_ARCH}.tar.gz" | tar zxvf - && \
    mv "mkspiffs-${MKSPIFFS_VERSION}-esp-idf-${MKSPIFFS_ARCH}/mkspiffs" /usr/local/bin && \
    rm -rf mkspiffs-* && \
    apt remove -y curl

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "bash" ]
