FROM crystallang/crystal

WORKDIR /crystalFTP

ADD src/ ./src
ADD spec/ ./spec
ADD lib/ ./lib

RUN crystal build src/crystalFTP.cr

CMD ["./crystalFTP"]

