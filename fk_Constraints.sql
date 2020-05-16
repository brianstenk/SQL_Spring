ALTER TABLE Staff
   ADD CONSTRAINT FK_Staff_CarNo FOREIGN KEY (CarNo)
      REFERENCES Car(CarNo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;


ALTER TABLE Staff
   ADD CONSTRAINT FK_Staff_BranchNo FOREIGN KEY (BranchNo)
      REFERENCES Branch(BranchNo)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE Car
   ADD CONSTRAINT FK_Car_BranchNo FOREIGN KEY (BranchNo)
      REFERENCES Branch(BranchNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE Inspection
   ADD CONSTRAINT FK_Inspect_CarNo FOREIGN KEY (CarNo)
      REFERENCES Car(CarNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

ALTER TABLE Inspection
	ADD CONSTRAINT FK_Staff_Inspector FOREIGN KEY (StaffNo)
      REFERENCES Staff(StaffNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;
ALTER TABLE Inspection
	ADD CONSTRAINT FK_Staff_Inspector FOREIGN KEY (StaffNo)
      REFERENCES Staff(StaffNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;






ALTER TABLE dbo.Car
   ALTER COLUMN BranchNo int not null;
  
ALTER TABLE Lesson
	ADD CONSTRAINT FK_Staff_Instructor FOREIGN KEY (StaffNo)
      REFERENCES Staff(StaffNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;
ALTER TABLE Lesson
	ADD CONSTRAINT FK_Client_Lesson FOREIGN KEY (ClientNo)
      REFERENCES Client(ClientNo)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
;

ALTER TABLE Client
	ADD CONSTRAINT FK_Branch_Client FOREIGN KEY (BranchNo)
      REFERENCES Branch(BranchNo)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
;

ALTER TABLE dbo.Client
   ALTER COLUMN BranchNo int not null;

ALTER TABLE Client
	ADD CONSTRAINT FK_Staff_Client FOREIGN KEY (StaffNo)
      REFERENCES Staff(StaffNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE Client
	ADD CONSTRAINT FK_Staff_Client FOREIGN KEY (StaffNo)
      REFERENCES Staff(StaffNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;
ALTER TABLE Interview
	ADD CONSTRAINT FK_Interviewing_Staff FOREIGN KEY (StaffNo)
      REFERENCES Staff(StaffNo)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
;

ALTER TABLE Interview
	ADD CONSTRAINT FK_Interviewed_Client FOREIGN KEY (ClientNo)
      REFERENCES Client(ClientNo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE DrivingTest
	ADD CONSTRAINT FK_Tested_Client FOREIGN KEY (ClientNo)
      REFERENCES Client(ClientNo)
      ON DELETE NO ACTION
      ON UPDATE CASCADE
;

