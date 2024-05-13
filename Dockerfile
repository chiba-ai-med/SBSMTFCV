FROM koki/sbsmtfcv_component:latest

ADD src /src
ADD sbsmtfcv /
ADD Snakefile /

WORKDIR /

ENTRYPOINT ["/sbsmtfcv"]