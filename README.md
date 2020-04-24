# akabe/esp-idf

A Docker image for ESP-IDF application build environment

## Getting started

### Build

```sh
docker run -it --rm -v path/to/your/source:/src -w /src akabe/esp-idf idf.py build
```

### Flash (on Linux)

```sh
docker run -it --rm -v path/to/your/source:/src -w /src --device /dev/ttyUSB0 akabe/esp-idf idf.py -p /dev/ttyUSB0 flash
```
