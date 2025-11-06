create database employee;
use employee;

drop table Incentives;
drop table Assigned;
drop table Employee;
drop table Dept;
drop table Project;

create table Project(Pno int primary key,Ploc varchar(20),Pname varchar(20));

create table Dept(Deptno int primary key,Dname varchar(20),Dloc varchar(20));

create table Employee(Empno int primary key,Ename varchar(20),
Mgr_No int,Hiredate date,sal int,Deptno int,foreign key(Deptno) references Dept(Deptno));

create table Assigned(Empno int,Pno int,Job_Role varchar(20),
foreign key(Empno) references Employee(Empno),foreign key(Pno) references Project(Pno),
primary key(Empno,Pno));

create table Incentives(Empno int,Incentive_Date date,Incentive_amount int,
foreign key(Empno) references Employee(Empno),primary key(Empno,Incentive_Date));

insert into Project values
(101,'Delhi','HireSys'),
(102,'Mumbai','Budget'),
(103,'Bangalore','AIDev'),
(104,'Chennai','Portal'),
(105,'Pune','Office');

insert into Dept values
(10,'HR','Delhi'),
(20,'Fin','Mumbai'),
(30,'IT','Bangalore'),
(40,'Sales','Chennai'),
(50,'Admin','Pune');

insert into Employee values
(1,'A',4,'2015-02-10',9000,30),
(2,'B',7,'2017-05-12',60000,30),
(3,'C',5,'2018-09-23',55000,20),
(4,'D',11,'2019-01-15',50000,10),
(5,'E',10,'2020-03-01',45000,30),
(6,'F',10,'2021-07-12',40000,20),
(7,'G',null,'2019-02-15',40000,10),
(8,'H',7,'2020-07-01',4500,30),
(9,'I',11,'2021-10-12',4000,20),
(10,'J',null,'2020-07-01',4500,30),
(11,'K',null,'2021-10-12',4000,20);



insert into assigned values
(1,101,'Lead'),
(2,103,'Dev'),
(3,102,'Analyst'),
(4,104,'HR'),
(5,103,'Test'),
(6,102,'Clerk');

insert into assigned values
(7,101,'Dev'),
(8,103,'Dev'),
(9,102,'HR'),
(10,104,'HR'),
(11,105,'HR');

insert into Incentives values
(2,'2019-01-12',5000),
(3,'2019-01-20',7000),
(4,'2019-01-25',6000),
(5,'2020-02-15',8000),
(6,'2021-04-10',4000);

select e.Empno from Employee e where exists(select e.Empno from Incentives i where e.Empno=i.Empno);

select Ename from Employee where Empno in
(select Mgr_no from Employee group by Mgr_no having count(Mgr_no)>=
(select max(count) as maxcount from 
(select count(Mgr_No) as count from Employee group by Mgr_no) as count_table));

select e1.Ename from Employee e1 where e1.sal>
(select avg(Sal) from Employee e2 where e1.Empno=e2.Mgr_no);

select e.Ename from Employee e,dept d where e.Deptno=d.Deptno and e.mgr_no is null;

select e1.Ename from Employee e1 where e1.mgr_no in
(select e2.empno from Employee e2,dept d where e2.Deptno=d.Deptno and e2.mgr_no is null);

select e.* from Employee e,Incentives i where e.Empno=i.Empno and i.incentive_amount=
(select max(incentive_amount) from Incentives where incentive_amount!=
(select max(incentive_amount) from Incentives));

select e1.ename from Employee e1 where e1.deptno=
(select e2.deptno from Employee e2 where e1.Mgr_no=e2.Empno);

select a.empno from Employee e,Project p,Assigned a where e.empno=a.empno 
and p.pno=a.pno and p.ploc in('Bangalore','Hyderabad','Pune');

select e.ename,e.empno,d.dname,a.job_role,d.dloc,p.ploc from Dept d,Employee e,Project p,Assigned a 
where e.empno=a.empno and e.deptno=d.deptno and a.pno=p.pno and p.ploc=d.dloc;

select e.* from Employee e,Incentives i where e.empno=i.empno and
e.sal+i.incentive_amount>=any(select sal from employee);

select e.empno from Employee e where not exists(select * from incentives i where
e.empno=i.empno);