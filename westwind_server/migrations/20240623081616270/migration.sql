BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "room_guest" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_guest" (
    "id" serial PRIMARY KEY,
    "roomId" integer NOT NULL,
    "stayDate" timestamp without time zone NOT NULL,
    "guestId" integer NOT NULL,
    "rateType" text NOT NULL,
    "rateReason" text NOT NULL,
    "rate" double precision NOT NULL,
    "reservationId" integer NOT NULL,
    "roomStatus" text NOT NULL,
    "checkInDate" timestamp without time zone NOT NULL,
    "checkOutDate" timestamp without time zone NOT NULL,
    "updateDate" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "room_guest_index_idx" ON "room_guest" USING btree ("roomId", "guestId");

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
    "roomGuestId" integer NOT NULL,
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

-- Indexes
CREATE INDEX "room_transaction_unique_idx" ON "room_transaction" USING btree ("guestId", "transactionDay");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_guest"
    ADD CONSTRAINT "room_guest_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_guest"
    ADD CONSTRAINT "room_guest_fk_1"
    FOREIGN KEY("guestId")
    REFERENCES "guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_guest"
    ADD CONSTRAINT "room_guest_fk_2"
    FOREIGN KEY("reservationId")
    REFERENCES "reservation"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

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
ALTER TABLE ONLY "room_transaction"
    ADD CONSTRAINT "room_transaction_fk_2"
    FOREIGN KEY("roomGuestId")
    REFERENCES "room_guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240623081616270', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240623081616270', "timestamp" = now();

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
