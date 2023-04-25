postgres:
	docker run --name postgres -p 5555:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine
createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_banks

dropdb:
	docker exec -it postgres dropdb simple_banks

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5555/simple_banks?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5555/simple_banks?sslmode=disable" -verbose down

sqlc: 
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc