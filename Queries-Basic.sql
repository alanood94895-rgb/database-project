USE SkyTrack_Airline;

--  Part 3: Basic Section
-- Q1
SELECT
    FlightNumber,
    DepartureDateTime,
    ArrivalDateTime,
    Status
FROM   Flight
ORDER  BY DepartureDateTime ASC;

-- Q2
SELECT
    PassengerID,
    FullName,
    Email,
    Nationality,
    DateOfBirth
FROM   Passenger
ORDER  BY FullName ASC;


-- Q3
SELECT
    RegistrationNumber,
    Model,
    Manufacturer,
    Capacity,
    YearOfManufacture
FROM   Aircraft
ORDER  BY Capacity DESC;


-- Q4

SELECT DISTINCT Class
FROM   Booking
ORDER  BY Class;


-- Q5

SELECT
    FlightNumber,
    DepartureDateTime,
    ArrivalDateTime,
    Status
FROM   Flight
WHERE  Status IN ('Delayed', 'Cancelled')
ORDER  BY DepartureDateTime ASC;


-- Q6

SELECT
    PassengerID,
    FullName,
    Email,
    Phone,
    Nationality
FROM   Passenger
WHERE  Nationality = 'Omani';


-- Q7

SELECT
    AirportID,
    IATACode,
    Name,
    City,
    Country
FROM   Airport
ORDER  BY Country ASC, Name ASC;
