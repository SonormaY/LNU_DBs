CREATE Table Event(
  EventID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  CityID INT,
  StartDate DATE NOT NULL,
  FinDate DATE NOT NULL,
  AddressID INT,
  OrganisatorID INT NOT NULL,
  SponsorID INT,
  VisitorCount INT NOT NULL,
  TicketsSold INT NOT NULL,
  FOREIGN KEy (CityID) REFERENCES City(ID),
  FOREIGN KEY (AddressID) REFERENCES Address(ID),
  FOREIGN KEY (OrganisatorID) REFERENCES Organisator(ID),
  FOREIGN KEY (SponsorID) REFERENCES Sponsor(ID)
);

CREATE TABLE City(
  ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(20) NOT NULL
);

CREATE TABLE Address(
  ID INT PRIMARY KEY NOT NULL,
  Address VARCHAR(100) NOT NULL,
  CityID INT NOT NULL,
  FOREIGN KEY (CityID) REFERENCES City(ID)
);

CREATE TABLE Organisator(
  ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Contacts VARCHAR (100) NOT NULL
);

CREATE TABLE Sponsor(
  ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Contacts VARCHAR (100) NOT NULL,
  LevelID INT NOT NULL,
  FOREIGN KEY (LevelID) REFERENCES Level(ID)
);

CREATE TABLE Level(
  ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(20) NOT NULL
);
