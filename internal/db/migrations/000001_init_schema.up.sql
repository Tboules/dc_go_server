CREATE TYPE "desert_figure_type" AS ENUM (
  'writer',
  'subject'
);

CREATE TYPE "excerpt_type" AS ENUM (
  'story',
  'passage'
);

CREATE TABLE "user" (
  "id" bigserial PRIMARY KEY,
  "name" varchar(255) UNIQUE NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "email_verified" boolean DEFAULT false,
  "image" varchar
);

CREATE TABLE "desert_figure" (
  "id" bigserial PRIMARY KEY,
  "full_name" varchar(255) UNIQUE,
  "first_name" varchar(255),
  "last_name" varchar(255),
  "type" desert_figure_type NOT NULL,
  "date_of_birth" timestamp,
  "date_of_death" timestamp,
  "date_added" timestamptz NOT NULL DEFAULT (now()),
  "last_updated" timestamp,
  "created_by" bigint NOT NULL
);

CREATE TABLE "excerpt" (
  "id" bigserial PRIMARY KEY,
  "body" varchar NOT NULL,
  "type" excerpt_type NOT NULL DEFAULT 'passage',
  "reference_title" varchar,
  "reference_page" integer,
  "reference_url" varchar,
  "desert_figure" bigint NOT NULL,
  "date_added" timestamptz NOT NULL DEFAULT (now()),
  "last_updated" timestamp,
  "created_by" bigint NOT NULL
);

CREATE TABLE "tag" (
  "id" bigserial PRIMARY KEY,
  "name" varchar(255) UNIQUE NOT NULL,
  "date_added" timestamptz NOT NULL DEFAULT (now()),
  "created_by" bigint NOT NULL
);

CREATE TABLE "excerpt_tag" (
  "excerpt_id" bigint NOT NULL,
  "tag_id" bigint NOT NULL,
  PRIMARY KEY ("excerpt_id", "tag_id")
);

CREATE TABLE "icon" (
  "id" bigserial PRIMARY KEY,
  "url" varchar NOT NULL,
  "description" varchar,
  "created_by" bigint NOT NULL,
  "desert_figure" bigint NOT NULL,
  "date_added" timestamptz NOT NULL DEFAULT (now()),
  "last_updated" timestamp
);

CREATE INDEX ON "excerpt" ("created_by");

CREATE INDEX ON "excerpt" ("desert_figure");

CREATE INDEX ON "excerpt_tag" ("tag_id");

CREATE INDEX ON "icon" ("desert_figure");

ALTER TABLE "desert_figure" ADD FOREIGN KEY ("created_by") REFERENCES "user" ("id");

ALTER TABLE "excerpt" ADD FOREIGN KEY ("desert_figure") REFERENCES "desert_figure" ("id");

ALTER TABLE "excerpt" ADD FOREIGN KEY ("created_by") REFERENCES "user" ("id");

ALTER TABLE "tag" ADD FOREIGN KEY ("created_by") REFERENCES "user" ("id");

ALTER TABLE "excerpt_tag" ADD FOREIGN KEY ("excerpt_id") REFERENCES "excerpt" ("id");

ALTER TABLE "excerpt_tag" ADD FOREIGN KEY ("tag_id") REFERENCES "tag" ("id");

ALTER TABLE "icon" ADD FOREIGN KEY ("created_by") REFERENCES "user" ("id");

ALTER TABLE "icon" ADD FOREIGN KEY ("desert_figure") REFERENCES "desert_figure" ("id");