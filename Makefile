run: build
	@./bin/dc_server

build:
	@go build -o bin/dc_server cmd/dc_server/main.go

postgres:
	docker run --name pg_dock -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it pg_dock createdb --username=root --owner=root desert_collections

deletedb:
	docker exec -it pg_dock dropdb desert_collections

migrateup:
	migrate -path internal/db/migrations -database "postgresql://root:secret@localhost:5432/desert_collections?sslmode=disable" -verbose up

migratedown:
	migrate -path internal/db/migrations -database "postgresql://root:secret@localhost:5432/desert_collections?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: run build postgres createdb deletedb migrateup migratedown sqlc