.PHONY: all test build clean

all: clean test build

.EXPORT_ALL_VARIABLES:
LOG_LEVEL=trace
NAME=agoracxp-auth-service
SERVER_PORT=9003
ENV=DEV
VERSION=1.0.5

build: 
	mkdir -p build
	go build -o build ./...

test:
	go test -v -coverprofile=tests/results/cover.out ./...

cleantest:
	go test -coverprofile=tests/results/cover.out ./...

cover:
	go tool cover -html=tests/results/cover.out -o tests/results/cover.html

clean:
	rm -rf build/*
	go clean ./...

container:
	podman build -t  quay.io/luigizuccarelli/golang-jwtauth-interface:1.16.3 .

push:
	podman push --authfile=/home/lzuccarelli/config.json quay.io/luigizuccarelli/golang-jwtauth-interface:1.16.3 
