FROM debian:9-slim

ENV IDF_PATH /opt/esp-idf
ENV IDF_VERSION v3.3.2

RUN apt update && \
        apt install -y git wget flex bison gperf cmake ninja-build ccache libffi-dev libssl-dev python3 python3-pip python3-setuptools libusb-1.0-0 libncurses-dev && \
        update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN git clone --recursive https://github.com/espressif/esp-idf.git -b $IDF_VERSION $IDF_PATH && \
    sed -i 's/capture_output=True/stdout=subprocess.PIPE, stderr=subprocess.PIPE/g' \
           $IDF_PATH/tools/idf_tools.py && \
    (cd $IDF_PATH ; ./install.sh ) && \
    rm -rf $IDF_PATH/examples

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "bash" ]
