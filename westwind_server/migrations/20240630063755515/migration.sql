BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "room" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room" (
    "id" serial PRIMARY KEY,
    "roomNumber" text NOT NULL,
    "roomType" text NOT NULL,
    "roomStatus" text NOT NULL,
    "isAvailable" boolean NOT NULL,
    "isSmoke" boolean NOT NULL,
    "bedType" text NOT NULL,
    "numOfBeds" integer NOT NULL,
    "isNewAC" boolean NOT NULL,
    "isNewBed" boolean NOT NULL,
    "numOfMicrowave" integer NOT NULL,
    "isNewRefergrator" boolean NOT NULL,
    "isBigRefergrator" boolean NOT NULL,
    "isBigTV" boolean NOT NULL,
    "isNewTV" boolean NOT NULL,
    "numOfTableLamp" integer NOT NULL,
    "isNewTableLamp" boolean NOT NULL,
    "numOfStandLamp" integer NOT NULL,
    "isNewStandLamp" boolean NOT NULL,
    "note" text
);


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240630063755515', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240630063755515', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240115074239642', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074239642', "timestamp" = now();


COMMIT;
