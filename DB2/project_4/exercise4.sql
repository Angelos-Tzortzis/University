-- 1. Συνδεθήκαμε στην MySQL του συστήματος μας.


-- 2. Έλεγχος εάν υπάρχει ΒΔ με την ονομασία personnel.
show databases;


-- 3. Επιλέγουμε την ΒΔ personnel για χρήση.
use personnel;
show tables;

-- Δημουργία πινάκων με βάση την εκφώνηση της εργασίας.
-- Διαγραφή των πινάκων της προηγούμενης εργασίας.
drop table if exists EMP;
drop table if exists DEPT;
drop table if exists JOB;

-- Δημιουργία πινάκων DEPT, JOB, EMP.
create table DEPT(
    DEPTNO numeric(2) not null,
    DNAME varchar(24),
    LOC char(23),
    primary key(DEPTNO)
);

create table JOB(
    JOBCODE numeric(3) not null,
    JOB_DESCR varchar(24),
    SAL numeric(10, 2),
    primary key(JOBCODE)
);

create table EMP(
    EMPNO numeric(4) not null,
    ENAME varchar(24),
    JOBNO numeric(3) not null,
    DEPTNO numeric(2) not null,
    COMM numeric(10, 2),
    primary key(EMPNO),
    foreign key(JOBNO) references JOB(JOBCODE),
    foreign key(DEPTNO) references DEPT(DEPTNO)
);

-- Εμφάνιση της δομής των πινάκων.
describe DEPT;
describe JOB;
describe EMP;

-- Εισαγωγή στοιχείων στους πίνακες.
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


-- 4. Δημιουργία του trigger με όνομα dept_update
--    που αφυπνίζεται από το γεγονός "BEFORE UPDATE ON"
delimiter //
create trigger dept_update
before update on DEPT
for each row
begin
set new.DNAME = upper(new.DNAME);
end;
//
delimiter ;

/* Δοκιμή */
update DEPT set DNAME = 'Operations' WHERE deptno = 70;
-- Εμφάνιση των στοιχείων του πίνακα DEPT ώστε να δούμε την επίδραση του trigger.
select * from DEPT;


-- 5. Προσθήκη στον πίνακα Department τη στήλη no_of_employees
--    (αριθμός υπαλλήλων που έχει το τμήμα).
alter table DEPT add (no_of_employees INT);
-- Εμφάνιση της δομής του πίνακα DEPT ώστε να δούμε την προσθήκη της νέας στήλης.
describe DEPT;


-- 6. Ενημέρωση στον πίνακα Department τη στήλη no_of_employees
--    (αριθμός υπαλλήλων που έχει το τμήμα).
update DEPT
set no_of_employees = (
    select count(*)
    from EMP
    where EMP.DEPTNO = DEPT.DEPTNO
);
-- Εμφάνιση των στοιχείων του πίνακα DEPT ώστε να δούμε την επίδραση της ενημέρωσης.
select * from DEPT;


-- 7. Δημιουργία του trigger με όνομα emp_insert
--    που αφυπνίζεται από το γεγονός "AFTER INSERT ON".
delimiter //
create trigger emp_insert
after insert on EMP
for each row
begin
update DEPT
set no_of_employees = ifnull(no_of_employees, 0) + 1
where DEPT.DEPTNO = new.DEPTNO;
end;
//
delimiter ;


-- 8. Δοκιμή του παραπάνω trigger.
insert into EMP(EMPNO, ENAME, JOBNO, DEPTNO, COMM) values(7985, 'CLARKE', 100, 70, NULL);
-- Εμφάνιση των στοιχείων των πίνακα DEPT και EMP ώστε να δούμε την επίδραση του trigger.
select * from EMP;
select * from DEPT;

-- 9. Επεξήγηση.
 
 
-- 10. Δημιουργία, δοκιμή και εξήγηση του trigger που αφυπνίζεται από το γεγονός AFTER DELETE ON.
delimiter //
create trigger emp_delete
after delete on EMP
for each row
begin
update DEPT
set no_of_employees = ifnull(no_of_employees, 0) - 1
where DEPT.DEPTNO = old.DEPTNO;
end;
//
delimiter ;

/* Δοκιμή */
delete from EMP where EMPNO = 7985;
-- Εμφάνιση των στοιχείων των πινάκων EMP και DEPT ώστε να δούμε την επίδραση του trigger.
select * from EMP;
select * from DEPT;


-- 11. Δημιουργία, δοκιμή και εξήγηση του trigger που αφυπνίζεται από το γεγονός AFTER DELETE ON.
delimiter //
create trigger emp_update
after update on EMP
for each row
begin
update DEPT
set no_of_employees = ifnull(no_of_employees, 0) - 1
where DEPT.DEPTNO = old.DEPTNO;
update DEPT
set no_of_employees = ifnull(no_of_employees, 0) + 1
where DEPT.DEPTNO = new.DEPTNO;
end;
//
delimiter ;

/* Δοκιμή */
update EMP set DEPTNO = 70 where EMPNO = 10;
-- Εμφάνιση των στοιχείων των πινάκων EMP και DEPT ώστε να δούμε την επίδραση του trigger.
select * from EMP;
select * from DEPT;


-- 12. Παρουσίαση πληροφοριών για τους Triggers.
describe Information_schema.Triggers;
select TRIGGER_NAME, EVENT_MANIPULATION, TRIGGER_SCHEMA
from Information_schema.Triggers
where TRIGGER_SCHEMA = 'personnel'
order by TRIGGER_NAME;


-- 13. Διαγραφή των triggers.
drop trigger dept_update;
drop trigger emp_insert;
drop trigger emp_delete;
drop trigger emp_update;

-- Εμφάνιση πληροφοριών για τους Triggers ώστε να δούμε ότι έγινε η διαγραφή.
describe Information_schema.Triggers;
select TRIGGER_NAME, EVENT_MANIPULATION, TRIGGER_SCHEMA
from Information_schema.Triggers
where TRIGGER_SCHEMA = 'personnel'
order by TRIGGER_NAME;
