BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "company" (
    "id" serial PRIMARY KEY,
    "name" text NOT NULL,
    "contactName" text NOT NULL,
    "phone" text NOT NULL,
    "email" text NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone,
    "byStaffId" integer NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "company_index_idx" ON "company" USING btree ("phone");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "guest" (
    "id" serial PRIMARY KEY,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "phone" text NOT NULL,
    "email" text NOT NULL,
    "isInHouse" boolean NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone,
    "rateType" text NOT NULL,
    "staffId" integer NOT NULL,
    "companyId" integer NOT NULL,
    "rigNumber" integer NOT NULL,
    "_roomTransactionGuestsRoomTransactionId" integer
);

-- Indexes
CREATE UNIQUE INDEX "guest_index_idx" ON "guest" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "guest_in_out_date" (
    "id" serial PRIMARY KEY,
    "roomNumber" text NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone,
    "guestId" integer NOT NULL,
    "inOutReason" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "guest_transaction" (
    "id" serial PRIMARY KEY,
    "roomId" integer NOT NULL,
    "stateDate" timestamp without time zone NOT NULL,
    "rateType" text NOT NULL,
    "rateReason" text NOT NULL,
    "rate" double precision NOT NULL,
    "roomStatus" text NOT NULL,
    "updateDate" timestamp without time zone,
    "roomGuestId" integer NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment" (
    "id" serial PRIMARY KEY,
    "guestId" integer NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateVoid" timestamp without time zone NOT NULL,
    "paymentAmount" double precision NOT NULL,
    "paymentType" text NOT NULL,
    "roomChargeType" text NOT NULL,
    "userId" integer NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "rate_table" (
    "id" serial PRIMARY KEY,
    "rateType" text NOT NULL,
    "rateReason" text NOT NULL,
    "rate" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reservation" (
    "id" serial PRIMARY KEY,
    "checkInDate" timestamp without time zone NOT NULL,
    "checkOutDate" timestamp without time zone NOT NULL,
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
    "isBigTV" boolean NOT NULL,
    "isNewAC" boolean NOT NULL,
    "isNewBed" boolean NOT NULL,
    "isBigRefergrator" boolean NOT NULL,
    "note" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_guest" (
    "id" serial PRIMARY KEY,
    "roomId" integer NOT NULL,
    "stateDate" timestamp without time zone NOT NULL,
    "guestId" integer NOT NULL,
    "rateType" text NOT NULL,
    "rateReason" text NOT NULL,
    "rate" double precision NOT NULL,
    "reservationId" integer NOT NULL,
    "roomStatus" text NOT NULL,
    "checkOutDate" timestamp without time zone NOT NULL,
    "updateDate" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "room_guest_index_idx" ON "room_guest" USING btree ("roomId", "guestId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_in_out_date" (
    "id" serial PRIMARY KEY,
    "checkInDate" timestamp without time zone,
    "checkOutDate" timestamp without time zone,
    "guestId" integer NOT NULL,
    "roomNumber" text NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_transaction" (
    "id" serial PRIMARY KEY,
    "roomNumber" text NOT NULL,
    "dateState" timestamp without time zone NOT NULL,
    "rateType" text NOT NULL,
    "rate" double precision NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "staff" (
    "id" serial PRIMARY KEY,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "phone" text NOT NULL,
    "email" text NOT NULL,
    "password" text NOT NULL,
    "timelogout" timestamp without time zone,
    "timelogin" timestamp without time zone NOT NULL,
    "permissionType" text NOT NULL,
    "dateCreate" timestamp without time zone NOT NULL,
    "dateUpdate" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "staff_index_idx" ON "staff" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_auth" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_create_request" (
    "id" serial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" serial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_reset" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_image" (
    "id" serial PRIMARY KEY,
    "userId" integer NOT NULL,
    "version" integer NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_info" (
    "id" serial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text NOT NULL,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "guest"
    ADD CONSTRAINT "guest_fk_0"
    FOREIGN KEY("companyId")
    REFERENCES "company"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "guest"
    ADD CONSTRAINT "guest_fk_1"
    FOREIGN KEY("_roomTransactionGuestsRoomTransactionId")
    REFERENCES "room_transaction"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "guest_in_out_date"
    ADD CONSTRAINT "guest_in_out_date_fk_0"
    FOREIGN KEY("guestId")
    REFERENCES "guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "guest_transaction"
    ADD CONSTRAINT "guest_transaction_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "room"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "guest_transaction"
    ADD CONSTRAINT "guest_transaction_fk_1"
    FOREIGN KEY("roomGuestId")
    REFERENCES "room_guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_0"
    FOREIGN KEY("guestId")
    REFERENCES "guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

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
ALTER TABLE ONLY "room_in_out_date"
    ADD CONSTRAINT "room_in_out_date_fk_0"
    FOREIGN KEY("guestId")
    REFERENCES "guest"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR westwind
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('westwind', '20240503231845695', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240503231845695', "timestamp" = now();

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
