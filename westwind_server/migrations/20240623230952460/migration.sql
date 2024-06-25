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
    "updateDate" timestamp without time zone,
    "isCheckOut" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_guest_index_idx" ON "room_guest" USING btree ("roomId", "guestId");

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
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240623230952460', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240623230952460', "timestamp" = now();

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
