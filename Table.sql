create database DentaCare
go
use DentaCare
go

create table CLINIC
(
	clinicID int IDENTITY(0, 1) not null primary key,
	clinicName varchar(50),
	clinicAddress nvarchar(100),
	city varchar(50),
	hotline char(11)
)

create table CLINICSCHEDULE
(
	clinicScheduleID int IDENTITY(0, 1) not null primary key,
	startTimeClinic time,
	endTimeClinic time,
	workingDay date,
	clinicID int,

	CONSTRAINT FK_clinicID1 foreign key(clinicID) references CLINIC(clinicID)
)

create table TimeSlot
(
	slotID int IDENTITY(0, 1) not null primary key,
	timePeriod varchar(20)
)

create table SlotDetail
(
	clinicScheduleID int IDENTITY(0, 1) not null,
	slotID int not null,

	PRIMARY KEY (clinicScheduleID, slotID), 

	CONSTRAINT FK_clinicScheduleID1 foreign key(clinicScheduleID) references CLINICSCHEDULE(clinicScheduleID),
	CONSTRAINT FK_slotID1 foreign key(slotID) references TimeSlot(slotID)
)

create table ROLE
(
	roleID int IDENTITY(0, 1) not null primary key,
	roleName varchar(50)
)

create table ACCOUNT
(
	accountID varchar(10) not null primary key,
	username varchar(40),
	password varchar(250),
	email varchar(30),
	fullName nvarchar(50),
	phone char(11),
	address nvarchar(250),
	dob date,
	gender bit,
	googleID varchar(100),
	googleName varchar(100),
	roleID int,

	CONSTRAINT FK_roleID1 foreign key(roleID) references ROLE(roleID)
)

create table DENTISTSCHEDULE
(
	accountID varchar(10) not null,
	clinicScheduleID int not null,

	PRIMARY KEY (accountID, clinicScheduleID), 

	CONSTRAINT FK_clinicScheduleID2 foreign key(clinicScheduleID) references CLINICSCHEDULE(clinicScheduleID),
	CONSTRAINT FK_accountID1 foreign key(accountID) references ACCOUNT(accountID)
)

create table MAJOR
(
	majorID varchar(3) not null primary key,
	majorName nvarchar(30),
	majorDescription nvarchar(250),
)

create table MAJORDETAIL
(
	majorID varchar(3) not null,
	accountID varchar(10) not null,

	PRIMARY KEY (majorID, accountID),

	CONSTRAINT FK_majorID1 foreign key(majorID) references MAJOR(majorID),
	CONSTRAINT FK_accountID2 foreign key(accountID) references ACCOUNT(accountID)
)

create table FEEDBACK
(
	feedbackID varchar(50) not null primary key,
	feedbackDay date,
	feedbackContent nvarchar(max),
	accountID varchar(10),
	clinicID int,

	CONSTRAINT FK_accountID3 foreign key(accountID) references ACCOUNT(accountID),
	CONSTRAINT FK_clinicID2 foreign key(clinicID) references CLINIC(clinicID)
)

create  table SERVICE
(
	serviceID int IDENTITY(0, 1) not null primary key,
	serviceName nvarchar(50),
	serviceType nvarchar(50),
	price money 
)

create table BOOKING
(
	bookingID varchar(10) not null primary key,
	createDay date,
	appointmentDay date,
	appointmentTime time,
	status int,
	serviceID int,
	slotID int,
	customerID varchar(10),
	dentistID varchar(10),
	
	CONSTRAINT FK_accountID4 foreign key(customerID) references ACCOUNT(accountID),
	CONSTRAINT FK_accountID5 foreign key(dentistID) references ACCOUNT(accountID),
	CONSTRAINT FK_serviceID1 foreign key(serviceID) references SERVICE(serviceID),
	CONSTRAINT FK_slotID2 foreign key(slotID) references TimeSlot(slotID)
)

create table MEDIICALRECORDS
(
	medicalRecordID varchar(10) not null primary key,
	results nvarchar(max),
	bookingID varchar(10),
	reExanime date,

	CONSTRAINT FK_bookingID1 foreign key(bookingID) references BOOKING(bookingID)
)