#BUILDER
FROM crystallang/crystal

WORKDIR /crystalFTP

ADD src/ ./src
ADD spec/ ./spec
ADD lib/ ./lib
COPY example.cr .
COPY shard.yml .

RUN shards install
RUN crystal build example.cr --release

CMD ["./example", "8000", "."]