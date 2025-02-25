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

-- 4. Δημιουργούμε την view με όνομα EMP_VIEW.
create view EMP_VIEW(e_ID, e_Name, e_Job, e_Dept, e_Comm)
as
select EMPNO, ENAME, JOBNO, DEPTNO, COMM from EMP;

-- 5. Εμφανίζουμε τα περιεχόμενα της view.
select * from EMP_VIEW;

-- 6. Δοκιμάζουμε δηλώσεις insert, update, delete στον πίνακα EMP και βλέπουμε
--    πως επηρεάζουν και την όψη EMP_VIEW.
insert into EMP(EMPNO, ENAME, JOBNO, DEPTNO, COMM) values (90, 'CLARKE', 100, 50, NULL);
update EMP set COMM = 450 where EMPNO = 10;
delete from EMP where EMPNO = 40;

select * from EMP;
select * from EMP_VIEW;

-- 7. Δοκιμάζουμε δηλώσεις insert, update, delete στην όψη EMP_VIEW και βλέπουμε
--    πως επηρεάζουν και τον πίνακα EMP.
insert into EMP_VIEW(e_ID, e_Name, e_Job, e_Dept, e_Comm) values (100, 'adams', 100, 60, NULL);
update EMP_VIEW set e_Job = 200 where e_ID = 100;
delete from EMP_VIEW where e_ID = 30;

select * from EMP;
select * from EMP_VIEW;

-- 8. Δημιουργούμε μία όψη που θα εμφανίζει τους υπαλλήλους του τμήματος SALES.
create view EMP_ON_SALES(e_ID, e_Name, e_Job, e_Dept, e_Comm) as
select EMPNO, ENAME, JOBNO, DEPTNO, COMM from EMP
where DEPTNO in (select DEPTNO from DEPT where DNAME = 'SALES');


-- Εμφανίζουμε τα αποτελέσματα των αλλαγών μας.
select * from EMP;
select * from EMP_ON_SALES;

-- 9. Πραγματοποιούμε εισαγωγή δεδομένων στον πίνακα EMP.
insert into EMP(EMPNO, ENAME, JOBNO, DEPTNO, COMM) values (110, 'NAVATHE', 100, 60, NULL);

-- 10. Εμφανίζουμε τα περιεχόμενα του πίνακα EMP.
select * from EMP;

-- 11. Εμφανίζουμε τα περιεχόμενα της όψης EMP_ON_SALES.
select * from EMP_ON_SALES;

-- 12. Πραγματοποιούμε εισαγωγή δεδομένων στην όψη EMP_ON_SALES.
insert into EMP_ON_SALES(e_ID, e_Name, e_Job, e_Dept, e_Comm) values (120, 'ELMASRI', 100, 60, NULL);

-- 13. Εμφανίζουμε τα περιεχόμενα του πίνακα EMP.
select * from EMP;

-- 14. Εμφανίζουμε τα περιεχόμενα της όψης EMP_ON_SALES.
select * from EMP_ON_SALES;

-- 15. Δημιουργούμε την παρακάτω όψη.
create view EMP_ON_SALES_S(e_ID, e_Name, e_Job, e_Dept, e_Comm)
as
select EMPNO, ENAME, JOBNO, DEPTNO, COMM from EMP
where DEPTNO in (select DEPTNO from DEPT where DNAME = 'SALES') with check option;

-- 16. Πραγματοποιούμε εισαγωγή δεδομένων στην όψη EMP_ON_SALES_S.
insert into EMP_ON_SALES_S(e_ID, e_Name, e_Job, e_Dept, e_Comm) values (130, 'DATE', 100, 60, NULL);

-- 17. Εμφανίζουμε τα περιεχόμενα του πίνακα EMP.
select * from EMP;

-- 18. Εμφανίζουμε τα περιεχόμενα της όψης EMP_ON_SALES_S.
select * from EMP_ON_SALES_S;

-- 19. Δημιουργούμε την παρακάτω όψη.
create view EMP_DISTINCT_NAMES(ENAME) as select distinct ENAME from EMP order by ENAME;

-- 20. Εκτελούμε την παρακάτω εντολή.
insert into EMP_DISTINCT_NAMES values ('GREEN');

-- 21. Δημιουργούμε τις παρακάτω όψεις ώστε να εξετάσουμε τον τύπο τους και τα περιεχόμενα τους.
create view GROUP_EMP(DEPT, COUNT_EMP, AVG_COMM) as select DEPTNO, count(*), avg(COMM) from EMP group by DEPTNO;

create view EMP_DEPT_VIEW(EMPNO, ENAME, JOBNO, DEPTNO, DNAME)
as select EMPNO, ENAME, JOBNO, EMP.DEPTNO, DNAME
from EMP inner join DEPT on EMP.DEPTNO=DEPT.DEPTNO;

create view new_EMP_DEPT_VIEW(EMPNO, ENAME, JOBNO, DEPTNO)
as select EMPNO, ENAME, JOBNO, EMP.DEPTNO
from EMP inner join DEPT on EMP.DEPTNO=DEPT.DEPTNO;

select * from GROUP_EMP;
select * from EMP_DEPT_VIEW;
select * from new_EMP_DEPT_VIEW;

-- 22. Εκτελούμε τις κατάλληλες εντολές ώστε να δείξουμε τον τύπο των παραπάνω όψεων.
insert into GROUP_EMP(DEPT, COUNT_EMP, AVG_COMM) values (50, 10, 200);
delete from EMP_DEPT_VIEW where EMPNO = 20;
insert into new_EMP_DEPT_VIEW(EMPNO, ENAME, JOBNO, DEPTNO) values(210, 'GATES', 100, 50);

select * from EMP;