CREATE DOMAIN CITY AS VARCHAR(20) NOT NULL;
CREATE DOMAIN LEVEL AS VARCHAR(20) NOT NULL;
CREATE DOMAIN EMAIL AS VARCHAR(100) NOT NULL;
CREATE DOMAIN PHONE AS VARCHAR(10) NOT NULL;
CREATE DOMAIN COUNT AS INT CHECK(VALUE > 0);

CREATE TABLE Address(
  ID INT PRIMARY KEY NOT NULL,
  Address VARCHAR(100) NOT NULL,
  CityID CITY NOT NULL
);

CREATE TABLE Organisator(
  ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Phone PHONE NOT NULL,
  Email EMAIL NOT NULL
);

CREATE TABLE Sponsor(
  ID INT PRIMARY KEY NOT NULL,
  Name VARCHAR(20) NOT NULL,
  Phone PHONE NOT NULL,
  Email EMAIL NOT NULL,
  Level LEVEL NOT NULL
);

CREATE Table Event(
  EventID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  City CITY,
  StartDate DATE NOT NULL,
  FinDate DATE NOT NULL,
  AddressID INT,
  OrganisatorID INT NOT NULL,
  SponsorID INT,
  VisitorCount COUNT NOT NULL,
  TicketsSold COUNT NOT NULL,
  FOREIGN KEY (AddressID) REFERENCES Address(ID),
  FOREIGN KEY (OrganisatorID) REFERENCES Organisator(ID),
  FOREIGN KEY (SponsorID) REFERENCES Sponsor(ID)
);