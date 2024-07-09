BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "guest" ALTER COLUMN "email" DROP NOT NULL;
ALTER TABLE "guest" ALTER COLUMN "rigNumber" DROP NOT NULL;

--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240708064600286', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240708064600286', "timestamp" = now();

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
