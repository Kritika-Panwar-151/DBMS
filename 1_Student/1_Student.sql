create database student;
use student;
create table student(stdid int,stdname varchar(20),dob date,doj date, fee int,gender char);
desc student;

insert into student values
(1,"Shareef",'2001-01-10','2001-10-05',10000,'M'),
(2,"Nadeem",'2019-11-3','2001-10-26',11000,'M');
select * from student;

alter table student add phone_no int;
alter table student rename column phone_no to student_no;
alter table student rename to student_info;
select * from student_info;

alter table student_info drop column gender;
delete from student_info where stdid=2;
select * from student_info;


create table product(
    productID int,productCode varchar(10),name varchar(50),quantity int,price decimal(10,2),
    primary key(productID)
);
insert into product values
(1001,"PEN","Pen Red",5000,1.23),
(1002,"PEN","Pen Blue",8000,1.25),
(1003,"PEN","Pen Black",2000,1.25),
(1004,"PEC","Pencil 2B",10000,0.48),
(1005,"PEC","Pencil 2H",8000,0.49),
(1006,"PEC","Pencil HB",0,9999999.99);
select *from product;

alter table product add column netprice decimal(5,3);
delete from product where productID=1001;
select * from product;