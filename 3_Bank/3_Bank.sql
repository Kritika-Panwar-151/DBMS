create database bank;
use bank;
show tables;
create table branch(branch_name varchar(20),branch_city varchar(20),assets real,primary key(branch_name));
create table bank_account(accno int,branch_name varchar(20),balance real,primary key(accno));
create table bank_customer(customer_name varchar(20),customer_street varchar(20),customer_city varchar(20),
primary key(customer_name));
create table depositer(customer_name varchar(20),accno int,foreign key(customer_name) references
bank_customer(customer_name),foreign key(accno) references bank_account(accno));
create table loan(loan_number int,branch_name varchar(20),amount real,
foreign key(branch_name) references branch(branch_name),primary key(loan_number));
create table borrower(customer_name varchar(20),loan_number int,foreign key(customer_name) references
bank_customer(customer_name),foreign key(loan_number) references loan(loan_number));

insert into branch values
("SBI_Chamrajpet","Bangalore",50000),
("SBI_ResidencyRoad","Bangalore",10000),
("SBI_ShivajiRoad","Bombay",20000),
("SBI_ParlimentRoad","Delhi",10000),
("SBI_Jantarmantar","Delhi",20000);

insert into bank_account values
(1,"SBI_Chamrajpet",2000),
(2,"SBI_ResidencyRoad",5000),
(3,"SBI_ShivajiRoad",6000),
(4,"SBI_ParlimentRoad",9000),
(5,"SBI_Jantarmantar",8000),
(6,"SBI_ShivajiRoad",4000),
(8,"SBI_ResidencyRoad",4000),
(9,"SBI_ParlimentRoad",3000),
(10,"SBI_ResidencyRoad",5000),
(11,"SBI_Jantarmantar",2000);

insert into bank_customer values
("Avinash","Bull_Temple_Road","Bangalore"),
("Dinesh","Bannergatta_Road","Bangalore"),
("Mohan","NationalCollege_Road","Bangalore"),
("Nikil","Akbar_Road","Delhi"),
("Ravi","Prithviraj_Road","Delhi");

insert into depositer values
("Avinash",1),
("Dinesh",2),
("Nikil",4),
("Ravi",5),
("Avinash",8),
("Nikil",9),
("Dinesh",10),
("Nikil",11);

insert into loan values
(1,"SBI_Chamrajpet",1000),
(2,"SBI_ResidencyRoad",2000),
(3,"SBI_ShivajiRoad",3000),
(4,"SBI_ParlimentRoad",4000),
(5,"SBI_Jantarmantar",5000);

insert into borrower values
("Avinash",1),
("Dinesh",2),
("Mohan",3),
("Nikil",4),
("Ravi",5);

select * from branch;
select * from bank_account;
select * from bank_customer;
select * from depositer;
select * from loan;
select * from borrower;
desc loan;

insert into branch values("SBI_MantriMarg","Delhi",2000000);
insert into bank_account values(12,"SBI_MantriMarg",2000);
insert into depositer values("Nikil",12);



select d.customer_name from depositer d,bank_account ba,branch b where d.accno=ba.accno and
ba.branch_name=b.branch_name and b.branch_city="Delhi" group by d.customer_name having
count(distinct(b.branch_name))=(select count(branch_name) from branch where branch_city="Delhi");

select distinct customer_name from borrower where customer_name not in
(select customer_name from depositer);

select branch_name from branch where assets>all
(select assets from branch where branch_city="bangalore");

select customer_name from borrower b,loan l where b.loan_number=l.loan_number and l.branch_name in
(select branch_name from depositer d,bank_account ba where d.accno=ba.accno and
ba.branch_name in(select branch_name from branch where branch.branch_city="Bangalore"));

delete from bank_account where branch_name in
(select branch_name from branch where branch_city="Bombay");
select * from bank_account;

update bank_account set balance=balance*1.05;
select * from bank_account;

#Additional queries
select * from loan order by amount desc;

(select customer_name from depositer) union (select customer_name from borrower);

create view branch_total_loan(branch_name,total_loan) as select branch_name,sum(amount)
from loan group by branch_name;



select d.customer_name from depositer d ,bank_account b where d.accno=b.accno group by d.customer_name
having count(d.customer_name)=(select count(branch_name) from branch where branch_city='Delhi') ;

select distinct customer_name from borrower where customer_name not in
(select customer_name from depositer);

select customer_name from borrower b,loan l where b.loan_number=l.loan_number and l.branch_name in
(select branch_name from depositer d,bank_account ba where d.accno=ba.accno and
ba.branch_name in(select branch_name from branch where branch.branch_city="Bangalore"));

select branch_name from branch where assets>all
(select assets from branch where branch_city="bangalore");

delete from bank_account where branch_name in
(select branch_name from branch where branch_city="Bombay");
select * from bank_account;

update bank_account set balance=balance*1.05;
select * from bank_account;