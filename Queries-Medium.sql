USE SkyTrack_Airline;

-- Q1

SELECT
    f.FlightNumber,
    origin.Name  AS OriginAirport,
    dest.Name    AS DestinationAirport,
    f.Status
FROM   Flight   f
JOIN   Airport  origin ON f.OriginAirportID      = origin.AirportID
JOIN   Airport  dest   ON f.DestinationAirportID = dest.AirportID
ORDER  BY f.FlightNumber;


-- Q2

SELECT
    b.BookingID,
    p.FullName      AS PassengerName,
    f.FlightNumber,
    b.SeatNumber,
    b.Class,
    b.Price,
    b.BookingDate
FROM   Booking   b
JOIN   Passenger p ON b.PassengerID = p.PassengerID
JOIN   Flight    f ON b.FlightID    = f.FlightID
ORDER  BY b.BookingID;


-- Q3

SELECT
    cm.FullName,
    cm.Role,
    cm.LicenseNumber
FROM   CrewMember  cm
JOIN   FlightCrew  fc ON cm.CrewMemberID = fc.CrewMemberID
JOIN   Flight      f  ON fc.FlightID     = f.FlightID
WHERE  f.FlightNumber = 'SK101'
ORDER  BY cm.Role, cm.FullName;


-- Q4

SELECT
    f.FlightNumber,
    f.DepartureDateTime,
    f.ArrivalDateTime,
    a.Model             AS AircraftModel,
    a.Manufacturer,
    a.RegistrationNumber
FROM   Flight    f
JOIN   Aircraft  a ON f.AircraftID = a.AircraftID
WHERE  f.Status = 'Completed'
ORDER  BY f.DepartureDateTime;


-- Q5

SELECT
    p.FullName,
    p.Nationality,
    COUNT(b.BookingID) AS TotalBookings
FROM   Passenger p
JOIN   Booking   b ON p.PassengerID = b.PassengerID
GROUP  BY p.PassengerID, p.FullName, p.Nationality
ORDER  BY TotalBookings DESC, p.FullName;


-- Q6

SELECT
    Class,
    COUNT(*)               AS NumberOfBookings,
    SUM(Price)             AS TotalRevenue,
    AVG(Price)             AS AveragePrice
FROM   Booking
GROUP  BY Class
ORDER  BY TotalRevenue DESC;


-- Q7:

SELECT
    a.RegistrationNumber,
    a.Model,
    a.Manufacturer,
    COUNT(f.FlightID) AS TotalFlights
FROM   Aircraft  a
LEFT   JOIN Flight f ON a.AircraftID = f.AircraftID
GROUP  BY a.AircraftID, a.RegistrationNumber, a.Model, a.Manufacturer
ORDER  BY TotalFlights DESC;


-- Q8

SELECT
    f.FlightNumber,
    f.Status,
    COUNT(b.BookingID) AS TotalBookings
FROM   Flight   f
JOIN   Booking  b ON f.FlightID = b.FlightID
GROUP  BY f.FlightID, f.FlightNumber, f.Status
HAVING COUNT(b.BookingID) > 1
ORDER  BY TotalBookings DESC;


-- Q9

SELECT
    p.FullName          AS PassengerName,
    f.FlightNumber,
    origin.Name         AS OriginAirport,
    dest.Name           AS DestinationAirport,
    b.SeatNumber,
    b.Class,
    b.Price,
    b.BookingDate
FROM   Booking   b
JOIN   Passenger p      ON b.PassengerID          = p.PassengerID
JOIN   Flight    f      ON b.FlightID             = f.FlightID
JOIN   Airport   origin ON f.OriginAirportID      = origin.AirportID
JOIN   Airport   dest   ON f.DestinationAirportID = dest.AirportID
ORDER  BY f.FlightNumber, b.Class;
