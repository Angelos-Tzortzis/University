-- 1. Συνδεθήκαμε στην MySQL του συστήματος μας.
-- 2. Ελέγχουμε αν υπάρχει η ΒΔ personnel και αν όχι την δημιουργούμε.
show databases;
create database if not exists personnel;

-- 3. Επιλέγουμε την personnel για χρήση.
use personnel;

-- 4. Διαγραφή πινάκων που υπάρχουν στο personnel εάν υπήρχαν ήδη.
show tables;
drop table if exists EMP;
drop table if exists DEPT;
drop table if exists JOB;

-- 5. Δημιουργία πινάκων DEPT, JOB, EMP.
create table DEPT(
    DEPTNO int(2) not null,
    DNAME varchar(30),
    LOC varchar(30),
    primary key(DEPTNO)
);

create table JOB(
    JOBCODE int(3) not null,
    JOB_DESCR varchar(30),
    SAL float(7, 2),
    primary key(JOBCODE)
);

create table EMP(
    EMPNO int(2) not null,
    ENAME varchar(30),
    JOBNO int(3) not null,
    DEPTNO int(2) not null,
    COMM float(7, 2),
    primary key(EMPNO),
    foreign key(JOBNO) references JOB(JOBCODE),
    foreign key(DEPTNO) references DEPT(DEPTNO)
);

-- Εμφάνιση της δομής των πινάκων.
describe DEPT;
describe JOB;
describe EMP;

-- Εισαγωγή στοιχείων στους πίνακες.
insert into DEPT(DEPTNO, DNAME, LOC) values
    (50, 'ΠΩΛΗΣΕΙΣ', 'ΑΘΗΝΑ'),
    (60, 'ΛΟΓΙΣΤΗΡΙΟ', 'ΑΘΗΝΑ'),
    (70, 'ΜΙΣΘΟΔΟΣΙΑ', 'ΒΟΛΟΣ');
    
insert into JOB(JOBCODE, JOB_DESCR, SAL) values
    (100, 'ΠΩΛΗΤΗΣ', 2200),
    (200, 'ΑΝΑΛΥΤΗΣ', 2000),
    (300, 'ΧΕΙΡΙΣΤΗΣ', 1000);

insert into EMP(EMPNO, ENAME, JOBNO, DEPTNO, COMM) values
	(10, 'ΣΠΥΡΟΥ', 100, 50, 450),
    (20, 'ΧΡΗΣΤΟΥ', 200, 50, null),
    (30, 'ΝΙΚΟΥ', 300, 60, null),
    (40, 'ΣΠΥΡΟΥ', 200, 50, null);

-- Εμφάνιση των στοιχειών του πίνακα.
select * from DEPT;
select * from JOB;
select * from EMP;

-- 6. Εμφάνιση των στοιχείων (EMPNO, ENAME, JOB_DESCR, SAL, DEPTNO),
-- όσων εργάζονται ως πωλητές (ΠΩΛΗΤΗΣ).
select EMP.EMPNO, EMP.ENAME, JOB.JOB_DESCR, JOB.SAL, EMP.DEPTNO
from EMP join JOB on EMP.JOBNO = JOB.JOBCODE
where JOB_DESCR = 'ΠΩΛΗΤΗΣ';


-- 7. Εμφάνιση με μία εντολή:
-- (α) τον μέγιστο μισθό όλων των υπαλλήλων,
-- (β) τον ελάχιστο μισθό όλων των υπαλλήλων,
-- (γ) τον μέσο όρο μισθού όλων των υπαλλήλων,
-- (δ) το πλήθος τον υπαλλήλων που έχουν μισθό,
-- (ε) το πλήθος τον υπαλλήλων που έχουν προμήθεια και
-- (στ) πόσοι είναι συνολικά οι υπάλληλοι.
select
max(SAL),
min(SAL),
avg(SAL),
count(SAL),
count(COMM),
count(*)
from EMP join JOB on EMP.JOBNO = JOB.JOBCODE;


-- 8. Εμφάνιση με μία εντολή:
-- (α) τον μέγιστο μισθό και
-- (β) τον μέσο όρο μισθού όσων εργάζονται ώς αναλυτές.
select
max(SAL),
avg(SAL)
from EMP join JOB on EMP.JOBNO = JOB.JOBCODE
where JOB_DESCR = 'ΑΝΑΛΥΤΗΣ';


-- 9. Εμφάνιση των στοιχείων (EMPNO, NAME, JOB_DESCR, SAL, DEPT_NO)
-- όσων εργάζονται ως αναλυτές (ANALYST) και ο μισθός τους (SAL)
-- κυμαίνεται από 1000 ευρώ έως και 2500 ευρώ.
select EMP.EMPNO, EMP.ENAME, JOB.JOB_DESCR, JOB.SAL, EMP.DEPTNO
from EMP join JOB on EMP.JOBNO = JOB.JOBCODE
where JOB_DESCR = 'ΑΝΑΛΥΤΗΣ'
and JOB.SAL >= 1000
and JOB.SAL <= 2500;


-- 10. Εμφάνιση των στοιχείων (EMPNO, NAME, JOB_DESCR, SAL, DEPT_NO)
-- των υπαλλήλων που το ονοματεπώνυμό τους (ΝΑΜΕ) περιέχει το γράμμα Ρ.
select EMP.EMPNO, EMP.ENAME, JOB.JOB_DESCR, JOB.SAL, EMP.DEPTNO
from EMP join JOB on EMP.JOBNO = JOB.JOBCODE
where EMP.ENAME like '%Ρ%';


-- 11. Εμφάνιση των στοιχείων (EMPNO, NAME, JOB_DESCR, SAL, DEPT_NO)
-- των υπαλλήλων ταξινομημένα βάσει τμήματος (DEPT_NO) και μισθού (SAL).
select EMP.EMPNO, EMP.ENAME, JOB.JOB_DESCR, JOB.SAL, EMP.DEPTNO
from EMP join job on EMP.JOBNO = JOB.JOBCODE
order by EMP.DEPTNO, JOB.SAL;


-- 12. Εμφάνιση του μέσου όρου μισθού και το πλήθος των υπαλλήλων ανα τμήμα.
select DEPT.DEPTNO, DEPT.DNAME, avg(JOB.SAL), count(EMP.EMPNO)
from DEPT left join EMP on DEPT.DEPTNO = EMP.DEPTNO
left join JOB on EMP.JOBNO = JOB.JOBCODE
group by DEPT.DEPTNO, DEPT.DNAME;
