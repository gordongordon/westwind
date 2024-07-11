BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "room_guest" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_guest" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "stayDay" timestamp without time zone NOT NULL,
    "guestId" bigint NOT NULL,
    "rateType" text NOT NULL,
    "rateReason" text NOT NULL,
    "rate" double precision NOT NULL,
    "reservationId" bigint NOT NULL,
    "roomStatus" text NOT NULL,
    "checkInDate" timestamp without time zone NOT NULL,
    "checkOutDate" timestamp without time zone NOT NULL,
    "updateDate" timestamp without time zone,
    "isCheckOut" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_guest_index_idx" ON "room_guest" USING btree ("roomId", "guestId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "room_transaction" DROP COLUMN "tax3";
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
    VALUES ('westwind', '20240711154047755', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240711154047755', "timestamp" = now();

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
