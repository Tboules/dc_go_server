run: build
	@./bin/dc_server

build:
	@go build -o bin/dc_server cmd/dc_server/main.go
