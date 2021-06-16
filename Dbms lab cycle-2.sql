CREATE TABLE SAILORS(sid INT,sname VARCHAR(10),rating INT,age INT);
INSERT INTO SAILORS(sid,sname,rating,age) VALUES(22,'Dustin',7,45),
(29,'Brutas',1,33),
(31,'Lubber',8,55),
(32,'Andy',8,25),
(58,'Rusty',10,35),
(64,'Horatio',7,35),
(71,'Zorba',10,16),
(74,'Horatio',9,35),
(85,'Art',3,26),
(95,'Bob',3,64);
SELECT * FROM SAILORS;
CREATE TABLE BOATS(bid INT,bname VARCHAR(50),color VARCHAR(50));
DESCRIBE BOATS;
INSERT INTO BOATS(bid,bname,color) VALUES(101,'Interlake','Blue'), 
(102,'Interlake','Red'),
(103,'Clipper','Green'),
(104,'Marine','Red'); 
SELECT * FROM BOATS;
CREATE TABLE RESERVES(sid INT,bid INT,day DATE);
DESCRIBE RESERVES;
INSERT INTO RESERVES(sid,bid,day) VALUES(22,101,'98-10-10'),
(22,102,'98-10-10'),
(22,103,'98-8-10'),
(22,104,'98-7-10'),
(31,102,'98-10-11'),
(31,103,'98-6-11'),
(31,104,'98-12-11'),
(64,101,'98-5-9'),
(64,102,'98-8-9'),
(74,103,'98-8-9');
SELECT * FROM RESERVES;
SELECT sname,age FROM SAILORS;
SELECT * FROM SAILORS,RESERVES WHERE SAILORS.sid=RESERVES.sid AND bid=101;
SELECT sname  FROM SAILORS WHERE rating>7;
SELECT sname FROM SAILORS,RESERVES WHERE SAILORS.sid=RESERVES.sid AND bid=103; 
SELECT DISTINCT sname FROM SAILORS,BOATS,RESERVES WHERE color='red'AND SAILORS.sid=RESERVES.sid AND BOATS.bid=RESERVES.bid ORDER BY age;
SELECT DISTINCT sname FROM SAILORS,RESERVES,BOATS WHERE (color='red' or color='green') AND BOATS.bid=RESERVES.bid AND SAILORS.sid=RESERVES.sid; 
SELECT DISTINCT color FROM SAILORS,BOATS,RESERVES WHERE sname='Lubber' AND SAILORS.sid=RESERVES.sid AND BOATS.bid=RESERVES.bid;
SELECT DISTINCT sname FROM SAILORS,BOATS,RESERVES WHERE color='red' And SAILORS.sid=RESERVES.sid AND BOATS.bid=RESERVES.bid UNION SELECT DISTINCT sname FROM SAILORS,BOATS,RESERVES WHERE color='green' And SAILORS.sid=RESERVES.sid AND BOATS.bid=RESERVES.bid;
SELECT DISTINCT sname FROM SAILORS,RESERVES WHERE SAILORS.sid=RESERVES.sid;
SELECT sname,reserves.sid FROM RESERVES,SAILORS WHERE sailors.sid = reserves.sid GROUP BY DAY,reserves.sid,sname HAVING COUNT(DAY)>1 ;
SELECT sname,age FROM SAILORS WHERE age =(SELECT MIN(age) FROM sailors) ;
SELECT sname FROM SAILORS WHERE rating > (SELECT MAX(rating) FROM SAILORS WHERE sname = 'Horatio');
SELECT sname,sid FROM (SELECT sname,reserves.sid,COUNT(bid) AS id FROM RESERVES,SAILORS WHERE reserves.sid = sailors.sid GROUP BY reserves.SID,sname) a WHERE id =( SELECT COUNT(bid) FROM BOATS);
SELECT COUNT(c.sname) FROM (SELECT DISTINCT sname FROM Sailors) c;
SELECT AVG(age) FROM SAILORS;
SELECT rating,AVG(age) FROM SAILORS GROUP BY rating;
SELECT a.rating,b.mean FROM (SELECT COUNT(sname) AS num,rating FROM SAILORS GROUP BY rating HAVING COUNT(sname)>1) a, (SELECT rating,AVG(age) AS mean FROM SAILORS GROUP BY rating ) b WHERE a.rating = b.rating;
CREATE TABLE STUDENT_INFO(Sid  INT UNIQUE ,Stud_name   VARCHAR(20) NOT NULL,stude_score numeric(5,2) DEFAULT 20);
DESCRIBE STUDENT_INFO;
ALTER TABLE STUDENT_INFO ADD PRIMARY KEY (Sid); 
DESCRIBE STUDENT_INFO;
INSERT INTO STUDENT_INFO VALUES(1,'Aiden',198),(2,'Dona',123),(3,'Prajwell',190),(4,'Aiden',200);
SELECT * FROM STUDENT_INFO
UPDATE STUDENT_INFO SET Stude_score = Stude_score + 5 WHERE Stude_score > 150;
SELECT * FROM STUDENT_INFO;
CREATE TABLE worker(Worker_ID INT,first_name VARCHAR(15),last_name VARCHAR(15),salary NUMERIC(8),joining_date DATE,department VARCHAR (15));
DESCRIBE WORKER;
CREATE TABLE bonus( Worker_ID INT, bonus_date DATE, bonus_amount NUMERIC(6));
DESCRIBE BONUS;
ALTER TABLE worker ADD PRIMARY KEY (Worker_ID);
DESCRIBE WORKER;
ALTER TABLE bonus ADD CONSTRAINT fk_cod_csd FOREIGN KEY(Worker_ID) REFERENCES worker(Worker_ID) ON DELETE CASCADE ;
DESCRIBE BONUS;
INSERT INTO worker VALUES (1,'monika','arora',100000,'2014-02-20','hr'),
(2,'niharika','verma',80000,'2014-06-11','admin'),
(3,'vishal','singhal',300000,'2014-02-20','hr'),
(4,'amithabh','singh',500000,'2014-02-20','admin'),
(5,'vivek','bhati',500000,'2014-06-11','admin'),
(6,'vipul','diwan',200000,'2014-06-11','account'),
(7,'satich','kumar',75000,'2014-01-20','admin'),
(8,'Geetika','Chauhan',90000,'2014-04-11','admin');
SELECT * FROM WORKER;
INSERT INTO bonus VALUES (1,'2016-02-20',5000),
(2,'2016-06-11',3000),
(3,'2016-02-20',4000),
(1,'2016-02-20',4500),
(2,'2016-06-11',3500);
SELECT * FROM BONUS;
SELECT first_name AS worker_name FROM worker;
SELECT * FROM WORKER  ORDER BY first_name ASC ;
SELECT * FROM worker WHERE (first_name)!= 'vipul' AND (first_name) != 'satich';
SELECT *FROM worker WHERE department='admin';
SELECT *FROM WORKER WHERE SALARY BETWEEN 100000 AND 500000;
SELECT upper(first_name) FROM worker;
SELECT distinct department FROM worker; 
SELECT SUBSTR(first_name,  1, 3) AS small FROM worker;
SELECT rtrim(first_name) FROM worker;
SELECT ltrim(department) FROM worker;
SELECT distinct department, LENGTH(department) FROM worker ;
SELECT REPLACE(first_name, 'a', 'A') AS fname FROM worker;
SELECT first_name,last_name,department,salary,bonus_amount  FROM worker,bonus WHERE worker.worker_id = bonus.worker_id AND bonus_amount  > 4000 ;
DELETE from worker WHERE worker_id=7;
SELECT * FROM worker;
ALTER TABLE bonus DROP CONSTRAINT fk_cod_csd;
ALTER TABLE bonus ADD CONSTRAINT fk_cod_na FOREIGN KEY(Worker_ID) REFERENCES worker(Worker_ID) ON DELETE no action ;
DELETE from worker WHERE worker_id=8;
SELECT * FROM worker;
 CREATE TABLE customer(cust_id  INT PRIMARY KEY,cust_name VARCHAR(20) NOT NULL);
DESCRIBE CUSTOMER;
CREATE TABLE item (item_id INT PRIMARY KEY, item_name VARCHAR(25), price INT);
DESCRIBE ITEM;
CREATE TABLE sale(bill_no INT PRIMARY KEY,bill_date DATE NOT NULL,cust_id  INT NOT NULL,item_id  INT NOT NULL,qty_sold  NUMERIC(6,3) NOT NULL,FOREIGN KEY(item_id) REFERENCES item(item_id),FOREIGN KEY (cust_id) REFERENCES customer(cust_id));
DESCRIBE SALE;
INSERT INTO customer VALUES( 1, 'Rekha'),
( 2, 'Rani'),
( 3, 'Rocky'),
( 4, 'Xin' ),
( 5, 'Kim');
SELECT * FROM CUSTOMER;
INSERT INTO item VALUES ( 1, 'Rusk', 120),
( 2, 'Banana', 50),
( 3, 'Sanitizer', 60),
( 4, 'Cake', 420),
( 5, 'Laddu', 25);
SELECT * FROM ITEM;
INSERT INTO sale VALUES( 10,'2020-10-01',1,1,3),
( 11,'2020-10-01', 1,3,2),
( 12,'2020-10-01', 1,5,7),
( 13,'2018-10-01', 4,4,1),
( 14,'2018-10-11',4,2,2),
( 15,'2018-09-29',5,1,5),
( 16,'2019-12-25',3,1,5),
( 17,'1995-06-21',5,4,4),
( 18,'2002-04-01',4,5,5),
( 19,'2020-02-12',1,2,1);
SELECT * FROM SALE;
SELECT * FROM CUSTOMER,SALE,ITEM WHERE PRICE>200 AND SALE.ITEM_ID=ITEM.ITEM_ID AND SALE.CUST_ID=CUSTOMER.CUST_ID;
SELECT  C.cust_id,cust_name,SC.COUNT,SC.bill_date FROM CUSTOMER C,(SELECT COUNT(ITEM_ID) AS COUNT,bill_date,cust_id FROM SALE GROUP BY bill_date) SC WHERE C.cust_id=SC.cust_id;
SELECT cust_name,COUNT(item_id),bill_date FROM customer c,sale s WHERE c.cust_id = s.cust_id GROUP BY cust_name,bill_date HAVING extract(YEAR FROM bill_date) = 2018;
SELECT item_name FROM item,sale WHERE sale.item_id = item.item_id AND sale.cust_id   = 5;
SELECT item_name,S.bill_date FROM ITEM I,SALE S WHERE I.item_id=S.item_id AND S.bill_date=CURDATE();
SELECT item_name,qty_sold, price,(qty_sold * price) AS total_amount  FROM customer,item,sale WHERE cust_name  = 'Rekha' AND sale.item_id = item.item_id AND sale.cust_id = customer.cust_id


