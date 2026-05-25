--  Part 1: Populating all tables with realistic data

USE SkyTrack_Airline;


-- Airports (5 from different countries)
INSERT INTO Airport (IATACode, Name, City, Country) VALUES
('MCT', 'Muscat International Airport',         'Muscat',       'Oman'),
('DXB', 'Dubai International Airport',           'Dubai',        'United Arab Emirates'),
('LHR', 'Heathrow Airport',                      'London',       'United Kingdom'),
('JFK', 'John F. Kennedy International Airport', 'New York',     'United States'),
('CDG', 'Charles de Gaulle Airport',             'Paris',        'France'),
('SIN', 'Changi Airport',                        'Singapore',    'Singapore'),
('CAI', 'Cairo International Airport',           'Cairo',        'Egypt');


-- Aircraft (5 with different models and manufacturers)
INSERT INTO Aircraft (RegistrationNumber, Model, Manufacturer, Capacity, YearOfManufacture) VALUES
('A4O-AA', 'Boeing 737-800',   'Boeing',   162, 2015),
('A4O-BB', 'Airbus A320',      'Airbus',   180, 2018),
('A4O-CC', 'Boeing 777-300ER', 'Boeing',   396, 2012),
('A4O-DD', 'Airbus A380',      'Airbus',   555, 2019),
('A4O-EE', 'Embraer E195',     'Embraer',  124, 2020),
('A4O-FF', 'Boeing 787-9',     'Boeing',   296, 2021);

-- Flights (8+ covering all four statuses)
INSERT INTO Flight (FlightNumber, DepartureDateTime, ArrivalDateTime, Status, AircraftID, OriginAirportID, DestinationAirportID) VALUES
-- Scheduled
('SK101', '2025-08-10 06:00', '2025-08-10 07:30', 'Scheduled',  1, 1, 2),   -- MCT -> DXB
('SK102', '2025-08-11 14:00', '2025-08-11 20:00', 'Scheduled',  2, 2, 3),   -- DXB -> LHR
-- Delayed
('SK103', '2025-08-12 08:30', '2025-08-12 22:00', 'Delayed',    3, 1, 4),   -- MCT -> JFK
('SK104', '2025-08-13 10:00', '2025-08-13 14:30', 'Delayed',    4, 3, 5),   -- LHR -> CDG
-- Cancelled
('SK105', '2025-08-14 05:00', '2025-08-14 13:00', 'Cancelled',  5, 2, 6),   -- DXB -> SIN
('SK106', '2025-08-15 09:00', '2025-08-15 13:00', 'Cancelled',  1, 5, 7),   -- CDG -> CAI
-- Completed
('SK107', '2025-08-01 07:00', '2025-08-01 09:00', 'Completed',  2, 1, 2),   -- MCT -> DXB
('SK108', '2025-08-02 12:00', '2025-08-02 18:30', 'Completed',  6, 4, 1),   -- JFK -> MCT
('SK109', '2025-08-03 15:00', '2025-08-04 05:00', 'Completed',  3, 3, 6),   -- LHR -> SIN
('SK110', '2025-08-05 09:00', '2025-08-05 13:00', 'Completed',  4, 7, 2);   -- CAI -> DXB


-- Passengers (8 from different nationalities)
INSERT INTO Passenger (NationalID, FullName, Email, Phone, Nationality, DateOfBirth) VALUES
('OM1234567', 'Ahmed Al-Balushi',  'ahmed.balushi@email.com',  '+96891234567', 'Omani',       '1985-03-15'),
('AE9876543', 'Sara Al-Maktoum',  'sara.maktoum@email.com',   '+97150987654', 'Emirati',     '1992-07-22'),
('GB1122334', 'James Harrison',   'james.harrison@email.com', '+447911223344','British',      '1978-11-08'),
('US5566778', 'Emily Chen',       'emily.chen@email.com',     '+12125566778', 'American',    '1995-04-30'),
('FR3344556', 'Pierre Dubois',    'pierre.dubois@email.com',  '+33601234567', 'French',      '1988-09-12'),
('SG7788990', 'Li Wei',           'li.wei@email.com',         '+6591234567',  'Singaporean', '2000-01-25'),
('EG2233445', 'Fatima Hassan',    'fatima.hassan@email.com',  '+20101234567', 'Egyptian',    '1990-06-18'),
('IN4455667', 'Raj Patel',        'raj.patel@email.com',      '+919876543210','Indian',       '1983-12-03');

-- Crew Members (6 covering all four roles)
INSERT INTO CrewMember (FullName, Role, LicenseNumber) VALUES
('Captain Khalid Al-Harthi', 'Pilot',            'PIL-OM-001'),
('Captain Nora Al-Farsi',    'Pilot',             'PIL-OM-002'),
('First Officer Ali Zahra',  'Co-Pilot',          'COP-OM-001'),
('First Officer Dana Salem', 'Co-Pilot',          'COP-OM-002'),
('Maria Santos',             'Flight Attendant',  'FA-OM-001'),
('Tariq Al-Rashidi',         'Flight Attendant',  'FA-OM-002'),
('Eng. Saeed Al-Habsi',      'Engineer',          'ENG-OM-001'),
('Eng. Layla Nasser',        'Engineer',          'ENG-OM-002');

-- FlightCrew 

INSERT INTO FlightCrew (FlightID, CrewMemberID) VALUES
-- SK101
(1, 1), (1, 3), (1, 5),
-- SK102
(2, 2), (2, 4), (2, 6),
-- SK103
(3, 1), (3, 4), (3, 5), (3, 7),
-- SK104
(4, 2), (4, 3), (4, 6), (4, 8),
-- SK105
(5, 1), (5, 3), (5, 5),
-- SK106
(6, 2), (6, 4), (6, 6),
-- SK107
(7, 1), (7, 3), (7, 5), (7, 7),
-- SK108
(8, 2), (8, 4), (8, 6), (8, 8),
-- SK109
(9, 1), (9, 4), (9, 5),
-- SK110
(10, 2),(10, 3),(10, 6);

-- Bookings (10+ across different flights, classes, passengers)
INSERT INTO Booking (PassengerID, FlightID, SeatNumber, Class, Price, BookingDate) VALUES
-- Economy
(1, 1,  '22A', 'Economy',  120.00, '2025-07-01'),
(2, 2,  '15B', 'Economy',  310.00, '2025-07-02'),
(3, 3,  '30C', 'Economy',  650.00, '2025-07-03'),
(4, 7,  '18A', 'Economy',   95.00, '2025-07-15'),
(5, 8,  '25D', 'Economy',  780.00, '2025-07-16'),
-- Business
(6, 1,  '5A',  'Business', 450.00, '2025-07-04'),
(7, 4,  '3B',  'Business', 390.00, '2025-07-05'),
(8, 9,  '4C',  'Business', 870.00, '2025-07-17'),
(1, 10, '6A',  'Business', 340.00, '2025-07-20'),
-- First
(2, 3,  '1A',  'First',   1200.00, '2025-07-06'),
(3, 8,  '1B',  'First',   1500.00, '2025-07-18'),
(4, 9,  '2A',  'First',   1800.00, '2025-07-19'),
-- Cancelled flight bookings (for DELETE practice)
(5, 5,  '10A', 'Economy',  520.00, '2025-07-10'),
(6, 6,  '8B',  'Business', 680.00, '2025-07-11');
