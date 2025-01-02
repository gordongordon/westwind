BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "guest" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "guest" (
    "id" bigserial PRIMARY KEY,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "phone" text NOT NULL,
    "email" text,
    "isInHouse" boolean NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone,
    "rateType" text NOT NULL,
    "staffId" bigint NOT NULL,
    "companyId" bigint NOT NULL,
    "rigNumber" bigint,
    "accountBalance" double precision NOT NULL,
    "note" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "guest_index_idx" ON "guest" USING btree ("phone");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "system_time" (
    "id" bigserial PRIMARY KEY,
    "lastAuditDate" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "guest"
    ADD CONSTRAINT "guest_fk_0"
    FOREIGN KEY("companyId")
    REFERENCES "company"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20250102100016197', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250102100016197', "timestamp" = now();

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
