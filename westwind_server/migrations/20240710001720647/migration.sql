BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "serverpod_user_info" ALTER COLUMN "userName" DROP NOT NULL;

--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240710001720647', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240710001720647', "timestamp" = now();

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
