BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "reservation" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reservation" (
    "id" serial PRIMARY KEY,
    "checkInDate" timestamp without time zone NOT NULL,
    "checkOutDate" timestamp without time zone NOT NULL,
    "stayDay" timestamp without time zone NOT NULL,
    "note" text,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone,
    "guestId" integer NOT NULL,
    "rateType" text NOT NULL,
    "rateReason" text NOT NULL,
    "rate" double precision NOT NULL,
    "isCheckedIn" boolean NOT NULL,
    "isCanceled" boolean NOT NULL,
    "isNightShift" boolean NOT NULL,
    "roomId" integer NOT NULL,
    "_roomReservationsRoomId" integer
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_0"
    FOREIGN KEY("guestId")
    REFERENCES "guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_1"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "reservation"
    ADD CONSTRAINT "reservation_fk_2"
    FOREIGN KEY("_roomReservationsRoomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240704092151678', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240704092151678', "timestamp" = now();

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
