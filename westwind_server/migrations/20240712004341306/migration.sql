BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "room" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room" (
    "id" bigserial PRIMARY KEY,
    "roomNumber" text NOT NULL,
    "roomType" text NOT NULL,
    "roomStatus" text NOT NULL,
    "isAvailable" boolean NOT NULL,
    "isSmoke" boolean NOT NULL,
    "bedType" text NOT NULL,
    "numOfBeds" bigint NOT NULL,
    "isNewAC" boolean NOT NULL,
    "isNewBed" boolean NOT NULL,
    "numOfMicrowave" bigint NOT NULL,
    "isNewRefergrator" boolean NOT NULL,
    "isBigRefergrator" boolean NOT NULL,
    "isBigTV" boolean NOT NULL,
    "isNewTV" boolean NOT NULL,
    "numOfTableLamp" bigint NOT NULL,
    "isNewTableLamp" boolean NOT NULL,
    "numOfStandLamp" bigint NOT NULL,
    "isNewStandLamp" boolean NOT NULL,
    "note" text
);


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240712004341306', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240712004341306', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
