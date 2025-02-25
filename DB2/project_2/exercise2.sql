-- 1. Συνδεθήκαμε στην MySQL του συστήματος μας.
-- 2. Ελέγχουμε αν υπάρχει ήδη η ΒΔ με την ονομασία personnel.
--    Αν υπάρχει την διαγράφουμε και την δημιουργούμε εκ νέου.
show databases;
drop database if exists personnel;
create database personnel;

-- 3. Επιλογή της personnel για χρήση.
use personnel;

-- 4. Εμφανίζουμε τους πίνακες του personnel.
show tables;
-- Διαγράφουμε τους πίνακες εάν υπάρχουν, στην συγκεκριμένη περίπτωση
-- δεν υπάρχουν αφου δημιουργήσαμε την ΒΔ εκ νέου.
-- drop table ... ;

-- 5. Δημιουργία των πινάκων DEPT, JOB, EMP χωρίς την προσθήκη κλειδιών.
-- Λαμβάνονται υπόψιν τα δεδομένα από τον πίνακα 1.
create table DEPT(
  DEPTNO numeric(2),
  DNAME varchar(24),
  LOC char(23)
);
create table JOB(
  JOBCODE numeric(3),
  JOB_DESCR varchar(24),
  SAL numeric(10, 2)
);
create table EMP(
	EMPNO numeric(4),
	ENAME varchar(24),
	JOBNO numeric(3),
	DEPTNO numeric(2),
	COMM numeric(10, 2)
);

-- Εμφάνιση της δομής των πινάκων.
describe DEPT;
describe JOB;
describe EMP;

-- 6. Εισάγοντα στους πίνακες τα δέδομένα όπως τα περιεχόμενα τους στην εικόνα 1.
insert into DEPT (DEPTNO, DNAME, LOC) values
	(50, 'SALES', 'ATHENS'),
	(60, 'ACCOUNTING', 'ATHENS'),
	(70, 'PAYROLL', 'VOLOS');

insert into JOB (JOBCODE, JOB_DESCR, SAL) values
	(100, 'SALESMAN', 2000),
	(200, 'ANALYST', 2000),
	(300, 'DBA', 3000);

insert into EMP (EMPNO, ENAME, JOBNO, DEPTNO, COMM) values
	(10, 'CODD', 100, 50, NULL),
	(20, 'NAVATHE', 200, 50, 450),
	(30, 'ELMASRI', 300, 60, NULL),
	(40, 'DATE', 100, 50, NULL);

-- Εμφανίζουμε τα περιεχόμεαν των πινάκων ώστε να βεβαιωθουμε ότι
-- εισάγαμε τις σωστές τιμές.
select * from DEPT;
select * from JOB;
select * from EMP;

-- 7. Προσθέτουμε στον πίνακα EMP τη στήλη HIREDATE με τύπο δεδομένων DATE.
alter table EMP add HIREDATE date;
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα EMP.
describe EMP;

-- 8. Ενημερώνουμε με τιμές την στήλη HIREDATE του πίνακα EMP λαμβάνοντας
-- υπόψιν πως οι ημερομηνίες πρόσληψης των υπαλλήλων είναι:
-- CODD 10-Ιαν-2001, NAVATHE 25-Φεβ-1999, ELMASRI 17-Μαρ-2000 και DATE 7-Ιουν-1989.
-- Ενημερώνουμε με βάση το ID και όχι το επίθετο καθώς θα μπορούσε να υπάρχουν υπάλληλοι
-- με το ίδιο επίθετο.
update EMP set HIREDATE = '2001-01-10' where EMPNO = 10;
update EMP set HIREDATE = '1999-02-25' where EMPNO = 20;
update EMP set HIREDATE = '2000-03-17' where EMPNO = 30;
update EMP set HIREDATE = '1989-06-07' where EMPNO = 40;

-- Εμφανίζουμε τα περιεχόμενα του πίνακα EMP ώστε να βεβαιωθούμε ότι
-- ενημερώσαμε τις σωστές τιμές.
select * from EMP;

-- 9. Ορίζουμε τύπο δεδομένων varchar(30) στην στήλη JOB_DESCR του πίνακα JOB.
alter table JOB modify JOB_DESCR varchar(30);
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα JOB.
describe JOB;

-- 10. Καταργούμε τη στήλη LOC του πίνακα DEPT.
alter table DEPT drop LOC;
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα DEPT.
describe DEPT;

-- 11. Μετονομασία της στήλης DNAME σε DEPT_NAME στον πίνακα DEPT.
--     Ορίζουμε και τύπο δεδομένων varchar(25) στη στήλη DEPT_NAME.
--     Να γίνουν οι αλλαγές με μία μόνο δήλωση.
alter table DEPT change DNAME DEPT_NAME varchar(25);
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα DEPT.
describe DEPT;

-- 12. Προσθέτουμε τον περιορισμό πρωτεύοντος κλειδιού (PRIMARY KEY)
--     με όνομα pk_DEPTNO στον πίνακα DEPT.
alter table DEPT add constraint pk_DEPTNO primary key (DEPTNO);
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα DEPT.
describe DEPT;

-- 13. Καταργούμε τον περιορισμό πρωτεύοντος κλειδιού (PRIMARY KEY) στον πίνακα DEPT.
alter table DEPT drop primary key;
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα DEPT.
describe DEPT;
-- Σύνταξη της create table εντολής για την δημιουργία του πίνακα DEPT.
show create table DEPT;

-- 14. Προσθέτουμε τον περιορισμό πρωτεύοντος κλειδιού (PRIMARY KEY) και
--     περιορισμούς ξένου κλειδιών (FOREIGN KEY) σε όλους τους πίνακες.
alter table DEPT add constraint pk_DEPTNO primary key (DEPTNO);
alter table JOB add constraint pk_JOBCODE primary key (JOBCODE);
alter table EMP add constraint pk_EMPNO primary key (EMPNO);
alter table EMP add constraint fk_JOBNO foreign key (JOBNO) references JOB(JOBCODE);
alter table EMP add constraint fk_DEPTNO foreign key (DEPTNO) references DEPT(DEPTNO);
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή των πινάκων.
describe DEPT;
describe JOB;
describe EMP;

-- 15. Καταργούμε τους περιορισμούς ξένου κλειδιού (FOREIGN KEY) στον πίνακα EMP.
alter table EMP drop foreign key fk_JOBNO;
alter table EMP drop foreign key fk_DEPTNO;
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του πίνακα EMP.
describe EMP;
-- Σύνταξη της create table εντολής για την δημιουργία του πίνακα EMP.
show create table EMP;

-- 16. Προσθέτουμε περιορισμό προεπιλεγμένης τιμής (DEFAULT) στον πίνακα DEPT,
--     θέτοντας προεπιλεγμένη τιμή 'DEVELOPMENT' στη στήλη DNAME (τώρα λέγεται DEPT_NAME).
alter table DEPT alter DEPT_NAME set default 'DEVELOPMENT';
-- Δείχνουμε την επιδραση του περιορισμού.
insert into EMP (EMPNO, ENAME, JOBNO, DEPTNO, COMM) values (50, 'CODD', 100, 50, NULL); -- Στο παράδειγμα της εργασίας υπάρχει ήδη υπάλληλος με κωδικό 10 οπότε το αλλάζουμε σε 50.
insert into DEPT (DEPTNO) values (10), (20);
insert into DEPT values (30, 'SALES');
select * from EMP;
select * from DEPT;

-- 17. Εμφανίζουμε την λίστα περιορισμών της ΒΔ personnel.
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_SCHEMA = 'personnel';

-- 18. Δημιουργία του πίνακα PROJECT με στήλες P_ID και P_NAME.
--     Λαμβάνονται υπόψιν οι τύποι δεδομένων από τον πίνακα 1.
--     Ορίζουμε πρωτεύων κλειδιού (PRIMARY KEY) και θέτουμε τον
--     περιορισμό AUTO_INCREMENT για την στήλη P_ID.
create table PROJECT(
	P_ID int not null auto_increment,
	P_NAME varchar(255),
	primary key(P_ID)
) engine=InnoDB default charset=utf8;
-- Ελέγχουμε το αποτέλεσμα εμφανίζοντας την δομή του PROJECT.
describe PROJECT;

-- 19. Εκτελούμε εντολή καταχώρησης εγγραφής ώστε να φανεί η λειτουργία των περιορισμών.
insert into PROJECT (P_NAME) values
	('FRONTEND'),
	('BACKEND'),
	('DATABASE');
-- Εμφανίζουμε τα περιεχόμενα του PROJECT.
select * from PROJECT;

-- 20. Επαναλαμβάνουμε το βήμα 19 ορίζοντας ώς αρχική τιμή
--     για το auto_increment το 200.
alter table PROJECT auto_increment = 200;
insert into PROJECT (P_NAME) values
	('SALES PROJECTION'),
	('ANNUAL ANALYTICS');
-- Εμφανίζουμε τα περιεχόμενα του PROJECT.
select * from PROJECT;
