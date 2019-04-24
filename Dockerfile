FROM crystallang/crystal

WORKDIR /crystalFTP

ADD src/ ./src
ADD spec/ ./spec
ADD lib/ ./lib
COPY main.cr .
COPY shard.yml .

RUN shards install
RUN crystal build main.cr --release

CMD ["./main 8000 ."]

