USE SkyTrack_Airline;

--  part 2 : SkyTrack Airline System — UPDATE and DELETE Tasks
-- UPDATE TASKS

-- UPDATE 1: Change one flight status from 'Scheduled' to 'Completed'
UPDATE Flight
SET    Status = 'Completed'
WHERE  FlightNumber = 'SK102';

-- Verify the update
SELECT FlightID, FlightNumber, Status
FROM   Flight
WHERE  FlightNumber = 'SK102';


-- UPDATE 2: Change one flight status from 'Delayed' to 'Cancelled'
UPDATE Flight
SET    Status = 'Cancelled'
WHERE  FlightNumber = 'SK103';

-- Verify the update
SELECT FlightID, FlightNumber, Status
FROM   Flight
WHERE  FlightNumber = 'SK103';


-- UPDATE 3: Increase all Economy class booking prices by 10%
UPDATE Booking
SET    Price = Price * 1.10
WHERE  Class = 'Economy';

-- Verify the update
SELECT BookingID, Class, Price
FROM   Booking
WHERE  Class = 'Economy';


-- UPDATE 4: Update one passenger's phone number
UPDATE Passenger
SET    Phone = '+96899887766'
WHERE  NationalID = 'OM1234567';

-- Verify the update
SELECT PassengerID, FullName, Phone
FROM   Passenger
WHERE  NationalID = 'OM1234567';


-- UPDATE 5: Move one crew member to a different role
-- (Moving Tariq Al-Rashidi from Flight Attendant to Engineer)
UPDATE CrewMember
SET    Role = 'Engineer'
WHERE  LicenseNumber = 'FA-OM-002';

-- Verify the update
SELECT CrewMemberID, FullName, Role
FROM   CrewMember
WHERE  LicenseNumber = 'FA-OM-002';


-- DELETE TASKS

-- DELETE 1: Delete one cancelled flight (SK106)
-- Step 1: Confirm the flight exists
SELECT FlightID, FlightNumber, Status
FROM   Flight
WHERE  FlightNumber = 'SK106' AND Status = 'Cancelled';

-- Step 2: Delete the flight
-- (Cascade will automatically remove related FlightCrew and Booking rows)
DELETE FROM Flight
WHERE  FlightNumber = 'SK106';

-- Step 3: Confirm deletion
SELECT FlightID, FlightNumber, Status
FROM   Flight
WHERE  FlightNumber = 'SK106';
-- Expected: 0 rows returned


-- DELETE 2: Delete one booking linked to a cancelled flight (SK105)
-- Step 1: Find bookings for SK105 (Cancelled)
SELECT b.BookingID, b.SeatNumber, b.Class, b.Price, f.FlightNumber, f.Status
FROM   Booking b
JOIN   Flight  f ON b.FlightID = f.FlightID
WHERE  f.FlightNumber = 'SK105' AND f.Status = 'Cancelled';

-- Step 2: Delete the booking (BookingID = 13 based on our insert data)
DELETE FROM Booking
WHERE  BookingID = 13;

-- Step 3: Confirm deletion
SELECT BookingID
FROM   Booking
WHERE  BookingID = 13;
-- Expected: 0 rows returned


-- DELETE 3: Try to delete a passenger who has existing bookings
-- Step 1: Confirm the passenger exists and has bookings
SELECT p.PassengerID, p.FullName, COUNT(b.BookingID) AS TotalBookings
FROM   Passenger p
JOIN   Booking   b ON p.PassengerID = b.PassengerID
WHERE  p.NationalID = 'OM1234567'
GROUP  BY p.PassengerID, p.FullName;

-- Step 2: Attempt to delete the passenger
DELETE FROM Passenger
WHERE  NationalID = 'OM1234567';
