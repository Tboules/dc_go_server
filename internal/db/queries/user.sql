-- name: CreateUser :one
INSERT INTO "user" (
  name, email 
) VALUES (
  $1, $2
) RETURNING *;

-- name: GetUserByID :one
SELECT * FROM "user"
WHERE id = $1 LIMIT 1;

-- name: GetUsers :many
SELECT * FROM "user"
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateUser :exec
UPDATE "user"
  SET name = $2,
  email = $3,
  email_verified = $4,
  image = $5
WHERE id = $1;

-- name: DeleteUser :exec
DELETE FROM "user"
WHERE id = $1;