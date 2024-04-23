INSERT INTO Address (id, address, city)
VALUES (1, '123 Main St', 'Springfield'),
       (2, '456 Elm St', 'New York'),
       (3, '789 Oak St', 'Washington'),
       (4, '101 Pine St', 'Texas'),
       (5, '202 Maple St', 'California'),
       (6, '303 Cedar St', 'Florida'),
       (7, '404 Walnut St', 'Georgia'),
       (8, '505 Birch St', 'Hawaii'),
       (9, '606 Ash St', 'Idaho'),
       (10, '707 Spruce St', 'Illinois');

INSERT INTO Organisator (id, name, phone, email) 
VALUES (1, 'John Doe', '1234567890', 'sampleemail1@sample.com'),
       (2, 'Jane Doe', '1234567890', 'sampleemail2@sample.com'),
       (3, 'Jim Doe', '123456789', 'sampleemail3@sample.com'),
       (4, 'Jill Doe', '1234567890', 'sample4@smp.com'),
       (5, 'Jack Doe', '1234567890', 'smp5@smp.com');

INSERT INTO Sponsor (id, name, phone, email, level)
VALUES (1, 'Sponsor1', '1234567890', 'sample@smp1.com', 'Gold'),
       (2, 'Sponsor2', '1234567890', 'sfsdd@sdds.com', 'Silver'),
       (3, 'Sponsor3', '1234567890', 'ddasdds@sdfsad.com', 'Bronze'),
       (4, 'Sponsor4', '1234567890', 'sddasd@sdffas.com', 'Platinum'),
       (5, 'Sponsor5', '1234567890', 'fsdafsdafs@sdfa.com', 'Diamond');

INSERT INTO Event (eventid, name, city, startdate, findate, addressid, organisatorid, sponsorid, visitorcount, ticketssold)
VALUES (1, 'Event1', 'Springfield', '2020-01-01', '2020-01-02', 1, 1, 1, 100, 50),
       (2, 'Event2', 'New York', '2020-01-01', '2020-01-02', 2, 2, 2, 200, 100),
       (3, 'Event3', 'Washington', '2020-01-01', '2020-01-02', 3, 3, 3, 300, 150),
       (4, 'Event4', 'Texas', '2020-01-01', '2020-01-02', 4, 4, 4, 400, 200),
       (5, 'Event5', 'California', '2020-01-01', '2020-01-02', 5, 5, 5, 500, 250),
       (6, 'Event6', 'Florida', '2020-01-01', '2020-01-02', 6, 1, 1, 600, 300),
       (7, 'Event7', 'Georgia', '2020-01-01', '2020-01-02', 7, 2, 2, 700, 350),
       (8, 'Event8', 'Hawaii', '2020-01-01', '2020-01-02', 8, 3, 3, 800, 400),
       (9, 'Event9', 'Idaho', '2020-01-01', '2020-01-02', 9, 4, 4, 900, 450),
       (10, 'Event10', 'Illinois', '2020-01-01', '2020-01-02', 10, 5, 5, 1000, 500);