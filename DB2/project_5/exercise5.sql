-- 1. Συνδεθήκαμε στην MySQL του συστήματος μας.


-- 2. Έλεγχος εάν υπάρχει ΒΔ με την ονομασία my_accounts.
show databases;


-- 3. Δημιουργία ΒΔ με την ονομασία my_accounts.
drop database if exists my_accounts;
create database my_accounts;
use my_accounts;

-- Δημιουργία πίνακα Accounts.
create table Accounts (
  acctID integer not null primary key,
  Balance integer not null
);

-- Εισαγωγή δεδομένων στον πίνακα Accounts.
insert into Accounts (acctID, Balance) values (101, 1000);
insert into Accounts (acctID, Balance) values (202, 2000);
insert into Accounts (acctID, Balance) values (303, 2500);
insert into Accounts (acctID, Balance) values (404, 3000);

-- Εμφάνιση πινάκων της ΒΔ.
show tables;
-- Εμφάνιση των περιεχομένων του πίνακα Accounts.
select * from Accounts;
-- Εμφάνιση της δομής του πίνακα Accounts.
describe Accounts;


-- 4. Εμφάνιση των περιεχομένων του πίνακα Accounts, προσθέτοντας αύξουσα
--    αύξουσα αρίθμηση στις εγγραφές του.
set @row_number = 0;
select (@row_number:=@row_number+1) as No, acctID, Balance from Accounts order by acctID;


-- 5. Η αύξουσα αρίθμηση που εμφανίστηκε στην στήλη με τίτλο No του βήματος 4, θα πρέπει να
--    υπάρχει και στον πίνακα Accounts; Αιτιολογήστε την απάντησή σας.
select * from Accounts;


-- 6.  Δημιουργία πίνακα Customers.
create table CUSTOMERS (
  CUSTNO integer not null primary key,
  CUST_NAME varchar(30)
);

-- Εισαγωγή δεδομένων στον πίνακα CUSTOMERS.
insert into CUSTOMERS (CUSTNO, CUST_NAME) values (10, "101");
insert into CUSTOMERS (CUSTNO, CUST_NAME) values (20, "202");

-- Εμφάνιση πινάκων της ΒΔ.
show tables;
-- Εμφάνιση των περιεχομένων του πίνακα Accounts.
select * from CUSTOMERS;
-- Εμφάνιση της δομής του πίνακα Accounts.
describe CUSTOMERS;


-- 7. Στον πίνακα Accounts προσθέτουμε στήλη με όνομα Custno, τύπο δεδομένων integer και την ορίζουμε
--    ως FK του πίνακα Accounts για τη σύνδεση των εγγραφών του με τις εγγραφές του πίνακα
--    CUSTOMERS. Ενημερώνουμε τα περιεχόμενα της στήλης Custno, ώστε ο λογαριασμός με
--    AcctID=202 να αντιστοιχεί στον κωδικό πελάτη 20 και όλοι οι υπόλοιποι λογαριασμοί να
--    αντιστοιχούν στον κωδικό πελάτη 10. Δείχνουμε το αποτέλεσμα εμφανίζοντας (α) τα
--    περιεχόμενα και (β) τη δομή του πίνακα Accounts.
alter table Accounts add Custno integer;
alter table Accounts add foreign key(Custno) references CUSTOMERS(CUSTNO);

update Accounts set Custno = 20 where acctID = 202;
update Accounts set Custno = 10 where acctID != 202;

-- α)
select * from Accounts;
-- β)
describe Accounts;


-- 8. Εκτέλεση και ερμήνευση των δηλώσεων SQL.
select CUSTNO, count(*), sum(Balance)
from Accounts
where CUSTNO not in (20)
group by CUSTNO;

-- Παραλλαγή με χρήση μεταβλητής.
set @CUSTNO = 20;
select CUSTNO, count(*), sum(Balance)
from Accounts
where CUSTNO not in (@CUSTNO)
group by CUSTNO;


-- 9. Εκτέλεση και ερμήνευση των δηλώσεων SQL.
select count(*), sum(Balance) from Accounts;

-- Παραλλαγή με χρήση μεταβλητής.
set @COUNT_acctID = 0, @SUM_acctID = 0, @AVG_acctID = 0;

select count(*), sum(Balance), avg(Balance)
into @COUNT_acctID, @SUM_acctID, @AVG_acctID
from Accounts;

select @COUNT_acctID, @SUM_acctID, @AVG_acctID, @MY_AVG := @SUM_acctID / @COUNT_acctID;


-- 10. Ορίζουμε και χρησιμοποιούμε τη συνάρτηση factorial που υπολογίζει το n!.
drop function if exists factorial;
delimiter !
create function factorial(N int)
returns int
deterministic
begin
declare F int default 1;
while N > 0 do
  set F = N * F;
  set N = N - 1;
end while;
return F;
end !
delimiter ;

-- Δοκιμές της λειτουργίας της συνάρτησης για Ν=4 και Ν=15.
select factorial(4);
select factorial(15);


-- 11. Ορίζουμε και χρησιμοποιούμε την διαδικασία my_procedure_Local_Variables για
--     υπολογισμούς με χρήση τοπικών μεταβλητών.
drop procedure if exists my_procedure_Local_Variables;
delimiter $$
create procedure my_procedure_Local_Variables()
begin
set @X = 25;
set @Y = 10;
select @X, @Y, @X*@Y;
end $$
delimiter ;
-- Κλήση της διαδικασίας
call my_procedure_Local_Variables();


-- 12. Ακολουθούμε τα ακόλουθα για τη δημιουργία μιας αποθηκευμένης διαδικασίας και χρήση
--     των commit/rollback.
-- Δοκιμές χρήσης της συνάρτησης MOD
SET @p_no=3;
SELECT MOD(@p_no, 2);
SET @p_no=8;
SELECT MOD(@p_no, 2);
-- Δημιουργία βάσης και πίνακα
DROP TABLE IF EXISTS myTrace;
CREATE TABLE myTrace (
  t_no INT,
  t_user CHAR(20),
  t_date DATE,
  t_time TIME,
  t_proc VARCHAR(16),
  t_what VARCHAR(30)
  );
-- Δημιουργία αποθηκευμένης διαδικασίας myProc
DROP PROCEDURE IF EXISTS myProc;
DELIMITER !
CREATE PROCEDURE myProc (
  IN p_no INT,
  IN p_in VARCHAR(30),
  OUT p_out VARCHAR(30)
)
LANGUAGE SQL
BEGIN
SET p_out=p_in;
INSERT INTO myTrace (t_no, t_user, t_date, t_time, t_proc, t_what)
VALUES (p_no, current_user, current_date, current_time, 'myProc', p_in);
IF (MOD(p_no, 2)=0) THEN
  COMMIT;
ELSE ROLLBACK;
END IF;
END !
DELIMITER ;
-- Κλήση της διαδικασίας
SET AUTOCOMMIT=0;
CALL myProc(1, 'hello1', @out);
CALL myProc(2, 'hello2', @out);
CALL myProc(3, 'hello3', @out);
CALL myProc(4, 'hello4', @out);
CALL myProc(5, 'hello5', @out);
CALL myProc(6, 'hello6', @out);
CALL myProc(7, 'hello7', @out);

SELECT * FROM myTrace;


-- 13. Στον πίνακα Accounts (Εικόνα 1) η μεταφορά χρημάτων από ένα λογαριασμό σε έναν άλλο
--     θα μπορούσε να υλοποιηθεί με δύο δηλώσεις UPDATE. Ακολουθεί παράδειγμα επίλυσης με
--     χρήση συναλλαγής (transaction). Η συναλλαγή αυτή χαρακτηρίζεται ως αναξιόπιστη, καθώς
--     δεν γίνεται έλεγχος σχετικά: (α) με την ύπαρξη του λογαριασμού στον οποίο μεταφέρονται
--     τα χρήματα και (β) την επάρκεια του λογαριασμού από τον οποίο μεταφέρονται τα χρήματα.
-- Δημιουργία πίνακα Accounts με 2 εγγραφές
DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (
  acctID INTEGER NOT NULL PRIMARY KEY,
  balance INTEGER NOT NULL-- ,
  -- CONSTRAINT unloanable_account CHECK (balance >= 0) Aφαίρεση αυτής της γραμμής για σωστή λειτουργία του procedure BankTransfer.
);
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
COMMIT;
SELECT * FROM accounts;
-- Συναλλαγή
START TRANSACTION;
UPDATE Accounts SET balance = balance - 100
WHERE acctId = 101;
UPDATE Accounts SET balance = balance + 100
WHERE acctId = 202;
COMMIT;
-- Αποτέλεσμα συναλλαγής
SELECT * FROM accounts;

-- 14. Ακολουθεί λύση του προβλήματος στο βήμα 15 με χρήση της procedure BankTransfer.
-- Δημιουργία procedure BankTrasfer
-- DELIMITER //
-- DROP PROCEDURE if exists BankTransfer //
-- CREATE PROCEDURE BankTransfer (
--   IN fromAcct INT,
--   IN toAcct INT,
--   IN amount INT,
--   OUT msg VARCHAR(100)
-- )
-- P1: BEGIN
--     DECLARE rows1 INT ;
--     DECLARE newbalance INT;
--     SELECT COUNT(*) INTO rows1 FROM Accounts WHERE acctID = fromAcct;
--     UPDATE Accounts SET balance = balance - amount WHERE acctID = fromAcct;
--     SELECT balance INTO newbalance FROM Accounts WHERE acctID = fromAcct;
--     IF rows1 = 0 THEN
--       ROLLBACK;
--       SET msg = CONCAT('rolled back because of missing account ', fromAcct);
--     ELSEIF newbalance < 0 THEN
--       ROLLBACK;
-- 	SET msg = CONCAT('rolled back because of negative balance of account ', fromAcct);
--     ELSE
--       SELECT COUNT(*) INTO rows1 FROM Accounts WHERE acctID = toAcct;
--       UPDATE Accounts SET balance = balance + amount WHERE acctID = toAcct;
--       IF rows1 = 0 THEN
--         ROLLBACK;
--         SET msg = CONCAT('rolled back because of missing account ', toAcct);
--       ELSE
--         COMMIT;
--         SET msg = 'committed';
--       END IF;
--     END IF;
-- END P1 //
-- DELIMITER ;

-- -- Δοκιμή μεταφοράς 100 από acctID=101 σε acctID=202
-- SET AUTOCOMMIT=0;
-- SET @out = ' ';
-- CALL BankTransfer (101, 202, 100, @out);
-- SELECT @OUT;
-- Select * from accounts;
-- COMMIT;
-- -- Δοκιμή μεταφοράς 100 από acctID=101 σε acctID=201 (ανύπαρκτος)
-- SET autocommit=0;
-- SET @out = ' ';
-- CALL BankTransfer (100, 201, 100, @out);
-- SELECT @OUT;
-- Select * from accounts;
-- COMMIT;
-- -- Δοκιμή μεταφοράς 100 από acctID=100 (ανύπαρκτος) σε acctID=201
-- SET autocommit=0;
-- SET @out = ' ';
-- CALL BankTransfer (100, 201, 100, @out);
-- SELECT @OUT;
-- select * from accounts;
-- -- Δοκιμή μεταφοράς 1500 από acctID=101 (ανεπαρκής) σε acctID=201
-- SET AUTOCOMMIT=0;
-- SET @out = ' ';
-- CALL BankTransfer (101, 201, 1500, @out);
-- SELECT @OUT;
-- Select * from accounts;
-- COMMIT;


-- 15. Ακολουθεί δεύτερη λύση του προβλήματος στο βήμα 15.
-- Δημιουργία πίνακα Accounts
DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (acctID INTEGER NOT NULL PRIMARY KEY, balance INTEGER NOT NULL);
INSERT INTO Accounts (acctID, balance) VALUES (101, 1000);
INSERT INTO Accounts (acctID, balance) VALUES (202, 2000);
COMMIT;
SELECT * FROM accounts;
-- Δημιουργία trigger Accounts_upd_trg για έλεγχο των updates
delimiter !
CREATE TRIGGER Accounts_upd_trg
BEFORE UPDATE ON Accounts
FOR EACH ROW
BEGIN
IF NEW.balance < 0 THEN
SIGNAL SQLSTATE '23513'
SET MESSAGE_TEXT = 'Negative balance not allowed';
END IF;
END; !
delimiter ;
-- Δημιουργία trigger Accounts_ins_trg για έλεγχο των inserts
delimiter !
CREATE TRIGGER Accounts_ins_trg
BEFORE INSERT ON Accounts
FOR EACH ROW
BEGIN
IF NEW.balance < 0 THEN
SIGNAL SQLSTATE '23513'
SET MESSAGE_TEXT = 'Negative balance not allowed';
END IF;
END; !
delimiter ;

// Δημιουργία procedure BankTransfer
DELIMITER !
CREATE PROCEDURE BankTransfer (IN fromAcct INT,
IN toAcct INT,
IN amount INT,
OUT msg VARCHAR(100))
LANGUAGE SQL MODIFIES SQL DATA
P1: BEGIN
DECLARE acct INT;
DECLARE balance_v INT;
DECLARE EXIT HANDLER FOR NOT FOUND
BEGIN ROLLBACK;
SET msg = CONCAT('missing account ', CAST(acct AS CHAR));
END;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN ROLLBACK;
SET msg = CONCAT('negative balance (?) in ', fromAcct);
END;
SET acct = fromAcct;
SELECT acctID INTO acct FROM Accounts WHERE acctID = fromAcct ;
UPDATE Accounts SET balance = balance - amount
WHERE acctID = fromAcct;
SET acct = toAcct;
SELECT acctID INTO acct FROM Accounts WHERE acctID = toAcct ;
UPDATE Accounts SET balance = balance + amount
WHERE acctID = toAcct;
SELECT balance INTO balance_v
FROM accounts
WHERE acctID = fromAcct;
IF balance_v < 0 THEN
ROLLBACK;
SET msg = CONCAT(' negative balance in ', fromAcct);
ELSE
COMMIT;
SET msg = 'committed';
END IF;
END P1 !
DELIMITER ;
CALL BankTransfer (101, 201, 100, @msg);
Select @msg;
CALL BankTransfer (100, 202, 100, @msg);
Select @msg;
CALL BankTransfer (101, 202, 100, @msg);
Select @msg;
CALL BankTransfer (101, 202, 2000, @msg);
Select @msg;
