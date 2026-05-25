USE SkyTrack_Airline;


-- Q1

SELECT
    f.FlightNumber,
    origin.Name          AS OriginAirport,
    dest.Name            AS DestinationAirport,
    a.Model              AS AircraftModel,
    COUNT(b.BookingID)   AS TotalPassengers
FROM   Flight    f
JOIN   Airport   origin ON f.OriginAirportID      = origin.AirportID
JOIN   Airport   dest   ON f.DestinationAirportID = dest.AirportID
JOIN   Aircraft  a      ON f.AircraftID           = a.AircraftID
LEFT   JOIN Booking b   ON f.FlightID             = b.FlightID
GROUP  BY f.FlightID, f.FlightNumber, origin.Name, dest.Name, a.Model
ORDER  BY TotalPassengers DESC, f.FlightNumber;


-- Q2

SELECT
    p.PassengerID,
    p.FullName,
    p.Email,
    p.Nationality
FROM   Passenger p
WHERE  p.PassengerID NOT IN (
    SELECT DISTINCT PassengerID
    FROM   Booking
);

-- Alternative using LEFT JOIN:
SELECT
    p.PassengerID,
    p.FullName,
    p.Email,
    p.Nationality
FROM   Passenger p
LEFT   JOIN Booking b ON p.PassengerID = b.PassengerID
WHERE  b.BookingID IS NULL;


-- Q3

SELECT
    f.FlightNumber,
    f.Status,
    SUM(b.Price)    AS TotalRevenue
FROM   Flight   f
JOIN   Booking  b ON f.FlightID = b.FlightID
GROUP  BY f.FlightID, f.FlightNumber, f.Status
HAVING SUM(b.Price) > 500
ORDER  BY TotalRevenue DESC;


-- Q4

SELECT
    cm.FullName,
    cm.Role,
    COUNT(fc.FlightID) AS TotalFlights
FROM   CrewMember  cm
JOIN   FlightCrew  fc ON cm.CrewMemberID = fc.CrewMemberID
GROUP  BY cm.CrewMemberID, cm.FullName, cm.Role
HAVING COUNT(fc.FlightID) > 1
ORDER  BY TotalFlights DESC, cm.FullName;


-- Q5

SELECT
    f.FlightNumber,
    f.Status,
    AVG(b.Price)              AS AvgFlightPrice,
    (SELECT AVG(Price) FROM Booking) AS OverallAvgPrice
FROM   Flight   f
JOIN   Booking  b ON f.FlightID = b.FlightID
GROUP  BY f.FlightID, f.FlightNumber, f.Status
HAVING AVG(b.Price) > (SELECT AVG(Price) FROM Booking)
ORDER  BY AvgFlightPrice DESC;


-- Q6

SELECT TOP 1
    f.FlightNumber,
    origin.Name        AS OriginAirport,
    dest.Name          AS DestinationAirport,
    COUNT(b.BookingID) AS TotalBookings
FROM   Flight    f
JOIN   Airport   origin ON f.OriginAirportID      = origin.AirportID
JOIN   Airport   dest   ON f.DestinationAirportID = dest.AirportID
JOIN   Booking   b      ON f.FlightID             = b.FlightID
GROUP  BY f.FlightID, f.FlightNumber, origin.Name, dest.Name
ORDER  BY TotalBookings DESC;


-- Q7

SELECT
    Class,
    SUM(Price)    AS TotalRevenue,
    COUNT(*)      AS NumberOfBookings,
    AVG(Price)    AS AveragePrice,
    MAX(Price)    AS HighestPrice,
    MIN(Price)    AS LowestPrice
FROM   Booking
GROUP  BY Class
ORDER  BY TotalRevenue DESC;


-- Q8

SELECT
    p.FullName       AS PassengerName,
    f.FlightNumber,
    f.Status,
    b.BookingDate,
    b.Class,
    b.Price
FROM   Booking   b
JOIN   Passenger p ON b.PassengerID = p.PassengerID
JOIN   Flight    f ON b.FlightID    = f.FlightID
WHERE  f.Status = 'Cancelled'
ORDER  BY f.FlightNumber, p.FullName;


-- Q9

SELECT
    f.FlightNumber,
    f.DepartureDateTime,
    COUNT(fc.CrewMemberID)  AS TotalCrew
FROM   Flight      f
JOIN   FlightCrew  fc ON f.FlightID      = fc.FlightID
JOIN   CrewMember  cm ON fc.CrewMemberID = cm.CrewMemberID
GROUP  BY f.FlightID, f.FlightNumber, f.DepartureDateTime
HAVING
    -- At least one Pilot
    SUM(CASE WHEN cm.Role = 'Pilot'            THEN 1 ELSE 0 END) >= 1
    AND
    -- At least one Flight Attendant
    SUM(CASE WHEN cm.Role = 'Flight Attendant' THEN 1 ELSE 0 END) >= 1
ORDER  BY f.DepartureDateTime;


-- Q10 

SELECT
    f.FlightNumber,
    origin.City                  AS OriginCity,
    dest.City                    AS DestinationCity,
    a.Model                      AS AircraftModel,
    a.Manufacturer               AS AircraftManufacturer,
    COUNT(DISTINCT b.BookingID)  AS TotalPassengers,
    COUNT(DISTINCT fc.CrewMemberID) AS TotalCrew,
    ISNULL(SUM(b.Price), 0)      AS TotalRevenue
FROM   Flight     f
JOIN   Airport    origin ON f.OriginAirportID      = origin.AirportID
JOIN   Airport    dest   ON f.DestinationAirportID = dest.AirportID
JOIN   Aircraft   a      ON f.AircraftID           = a.AircraftID
LEFT   JOIN Booking    b  ON f.FlightID            = b.FlightID
LEFT   JOIN FlightCrew fc ON f.FlightID            = fc.FlightID
GROUP  BY
    f.FlightID,
    f.FlightNumber,
    origin.City,
    dest.City,
    a.Model,
    a.Manufacturer
ORDER  BY TotalRevenue DESC;
