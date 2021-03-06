GO_LDFLAGS = -ldflags "-s -w"
GO_VERSION = 1.14
GO_TESTPKGS:=$(shell go list ./... | grep -v cmd | grep -v examples)

all: nodes

go_deps:
	go mod download

clean:
	rm -rf bin

build_grpc: go_deps
	go build -o bin/avp $(GO_LDFLAGS) ./cmd/signal/grpc/main.go

test: go_deps
	go test \
		-timeout 60s \
		-coverprofile=cover.out -covermode=atomic \
		-v -race ${GO_TESTPKGS} 
