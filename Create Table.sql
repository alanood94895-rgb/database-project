--  (Create Tables)
--  Task 3: Implementing the database with all required constraints

CREATE DATABASE SkyTrack_Airline;
USE SkyTrack_Airline;

CREATE TABLE Airport (
    AirportID   INT           IDENTITY(1,1) PRIMARY KEY,
    IATACode    CHAR(3)       NOT NULL UNIQUE,
    Name        VARCHAR(150)  NOT NULL,
    City        VARCHAR(100)  NOT NULL,
    Country     VARCHAR(100)  NOT NULL
);

CREATE TABLE Aircraft (
    AircraftID           INT          IDENTITY(1,1) PRIMARY KEY,
    RegistrationNumber   VARCHAR(20)  NOT NULL UNIQUE,
    Model                VARCHAR(100) NOT NULL,
    Manufacturer         VARCHAR(100) NOT NULL,
    Capacity             INT          NOT NULL,
    YearOfManufacture    INT,
    CONSTRAINT chk_aircraft_capacity CHECK (Capacity > 0)
);


CREATE TABLE Flight (
    FlightID              INT          IDENTITY(1,1) PRIMARY KEY,
    FlightNumber          VARCHAR(10)  NOT NULL UNIQUE,
    DepartureDateTime     DATETIME     NOT NULL,
    ArrivalDateTime       DATETIME     NOT NULL,
    Status                VARCHAR(20)  NOT NULL DEFAULT 'Scheduled',
    AircraftID            INT          NOT NULL,
    OriginAirportID       INT          NOT NULL,
    DestinationAirportID  INT          NOT NULL,

    CONSTRAINT chk_flight_status
        CHECK (Status IN ('Scheduled','Delayed','Cancelled','Completed')),

    CONSTRAINT chk_flight_arrival_after_departure
        CHECK (ArrivalDateTime > DepartureDateTime),

    CONSTRAINT fk_flight_aircraft
        FOREIGN KEY (AircraftID)
        REFERENCES Aircraft(AircraftID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_flight_origin
        FOREIGN KEY (OriginAirportID)
        REFERENCES Airport(AirportID)
        ON DELETE NO ACTION ON UPDATE NO ACTION,

    CONSTRAINT fk_flight_destination
        FOREIGN KEY (DestinationAirportID)
        REFERENCES Airport(AirportID)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);



CREATE TABLE Passenger (
    PassengerID  INT          IDENTITY(1,1) PRIMARY KEY,
    NationalID   VARCHAR(30)  NOT NULL UNIQUE,
    FullName     VARCHAR(200) NOT NULL,
    Email        VARCHAR(200) NOT NULL UNIQUE,
    Phone        VARCHAR(30),
    Nationality  VARCHAR(100) NOT NULL,
    DateOfBirth  DATE         NOT NULL
);


CREATE TABLE Booking (
    BookingID    INT            IDENTITY(1,1) PRIMARY KEY,
    PassengerID  INT            NOT NULL,
    FlightID     INT            NOT NULL,
    SeatNumber   VARCHAR(10)    NOT NULL,
    Class        VARCHAR(20)    NOT NULL,
    Price        DECIMAL(10,2)  NOT NULL,
    BookingDate  DATE           NOT NULL DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT chk_booking_class
        CHECK (Class IN ('Economy','Business','First')),

    CONSTRAINT chk_booking_price
        CHECK (Price > 0),

    CONSTRAINT fk_booking_passenger
        FOREIGN KEY (PassengerID)
        REFERENCES Passenger(PassengerID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_booking_flight
        FOREIGN KEY (FlightID)
        REFERENCES Flight(FlightID)
        ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE CrewMember (
    CrewMemberID   INT          IDENTITY(1,1) PRIMARY KEY,
    FullName       VARCHAR(200) NOT NULL,
    Role           VARCHAR(30)  NOT NULL,
    LicenseNumber  VARCHAR(50)  NOT NULL UNIQUE,

    CONSTRAINT chk_crew_role
        CHECK (Role IN ('Pilot','Co-Pilot','Flight Attendant','Engineer'))
);



CREATE TABLE FlightCrew (
    FlightID      INT NOT NULL,
    CrewMemberID  INT NOT NULL,

    CONSTRAINT pk_flightcrew
        PRIMARY KEY (FlightID, CrewMemberID),

    CONSTRAINT fk_fc_flight
        FOREIGN KEY (FlightID)
        REFERENCES Flight(FlightID)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_fc_crew
        FOREIGN KEY (CrewMemberID)
        REFERENCES CrewMember(CrewMemberID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
