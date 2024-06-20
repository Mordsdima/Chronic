# Step 1: Build API

FROM alpine:latest as build

# install v

WORKDIR /build

RUN apk add --no-cache git build-base sqlite-dev && \ 
 git clone https://github.com/vlang/v

WORKDIR /build/v

RUN make

RUN rm -rf doc examples/ tutorials/ vc/ ./vlib/v/tests/ \
 ./vlib/v/slow_tests/ ./vlib/v/embed_file/tests/ \
 ./cmd/tools/vdoc/tests ./cmd/tools/vcreate/tests \
 ./cmd/tools/vvet/tests ./vlib/v/scanner/tests/ \
 ./vlib/v/fmt/tests ./vlib/v/checker/tests \
 ./vlib/v/gen/native/tests ./vlib/v/gen/wasm/tests \
 ./vlib/v/gen/js/tests ./vlib/v/eval/tests \
 ./vlib/v/gen/golang/tests ./vlib/v/parser/tests/ \
 ./vlib/toml/tests/ ./vlib/net/websocket/tests \
 ./vlib/x/vweb/tests ./vlib/vweb/tests ./vlib/v2/tests ./vlib/wasm/tests ./vlib/veb/tests

# now after v installation we should build API

WORKDIR /build/api

COPY . /build/api/

RUN /build/v/v -prod .

# Step 2: Run API!

FROM alpine:latest as runner

COPY --from=build /build/api .

VOLUME ["/data"]

# As API is already compiled with everything inside we just should install sqlite & run it (config will be little later)

# btw init also env
RUN apk add --no-cache sqlite-libs && \
    mkdir -p /data/data

ENTRYPOINT [ "./api" ]