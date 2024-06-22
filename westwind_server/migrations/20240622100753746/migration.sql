BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "room_transaction" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_transaction" (
    "id" serial PRIMARY KEY,
    "guestId" integer NOT NULL,
    "roomId" integer NOT NULL,
    "transactionDay" timestamp without time zone NOT NULL,
    "transactionType" text NOT NULL,
    "amount" double precision NOT NULL,
    "tax1" double precision NOT NULL,
    "tax2" double precision NOT NULL,
    "tax3" double precision NOT NULL,
    "total" double precision NOT NULL,
    "description" text NOT NULL,
    "itemType" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_transaction"
    ADD CONSTRAINT "room_transaction_fk_0"
    FOREIGN KEY("guestId")
    REFERENCES "guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_transaction"
    ADD CONSTRAINT "room_transaction_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240622100753746', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240622100753746', "timestamp" = now();

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
