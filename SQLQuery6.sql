INSERT INTO Inspection([CarNo],[InspectionDateTime],[numberFaults],[FaultsDescription],[StaffNo]) 
VALUES(1,'2020-11-15 15:03:23',8,'lacinia at, iaculis quis, pede.',1),

(2,'2013-09-15 22:56:51',10,'fermentum fermentum arcu. Vestibulum ante',3),
(3,'2012-08-12 03:44:18',4,'orci, in consequat enim diam',4),
(4,'2020-01-15 11:25:53',1,'enim. Sed nulla ante, iaculis',1),
(5,'2019-05-26 11:53:25',3,'lacus. Etiam bibendum fermentum metus.',3),
(4,'2021-01-26 13:52:05',3,'scelerisque sed, sapien. Nunc pulvinar',4),
(1,'2019-08-13 05:45:52',2,'arcu vel quam dignissim pharetra.',2),
(2,'2021-04-10 09:49:55',1,'ipsum dolor sit amet, consectetuer',4),
(4,'2020-04-08 09:14:20',6,'quam vel sapien imperdiet ornare.',1),
(2,'2020-10-04 14:17:13',1,'arcu. Sed eu nibh vulputate',3);


INSERT INTO Interview([ClientNo],[date],[StaffNo]) 
VALUES
(1,'2020-11-15 15:03:23',1),
(2,'2013-09-15 22:56:51',1),
(3,'2012-08-12 03:44:18',3),
(4,'2020-01-15 11:25:53',2),
(5,'2019-05-26 11:53:25',3)

INSERT INTO Lesson([StaffNo],[ClientNo],[dateOfLesson],[startTime], [endTime],[block], 
[carNo],[StartMilleage], [EndMileage],[fee])       
VALUES
(1, 1, '2020-11-15 15:03:23', '15:03:23', '17:03:23', 1, 4, 123, 127, 100),
(1, 2, '2013-01-15 15:03:23', '15:03:23', '17:03:23', 1, 2, 123, 127, 100),
(2, 4, '2019-11-15 15:03:23', '15:03:23', '17:03:23', 1, 3, 123, 127, 100),
(3, 3, '2012-11-15 15:03:23', '15:03:23', '17:03:23', 1, 1, 123, 127, 100),
(1, 1, '2018-11-15 15:03:23', '15:03:23', '17:03:23', 1, 1, 123, 127, 100)