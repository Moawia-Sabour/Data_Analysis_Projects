
----------------------- ITI Database ------------------------
-------------------------------------------------------------
--1.Retrieve number of students who have a value in their age. 
select * 
from [dbo].[Student]
where St_Age > 0


-------------------------------------------------------------
--2.Get all instructors Names without repetition
select Ins_Name 
from [dbo].[Instructor]


-------------------------------------------------------------
--3.Display student with the following Format (use isNull function)
select St_Id ,
ISNULL(Student.St_Fname, 'No FirstName') as StFirstName , 
ISNULL(Student.St_Lname, 'No lastName') as StLastName , 
ISNULL(Department.Dept_Name, 'No Department') as Dapt_Name 
from Student 
left join Department
on Department.Dept_Id = Student.Dept_Id 


-------------------------------------------------------------
--4.Display instructor Name and Department Name 
select Ins_Name , Dept_Name 
from Instructor
left join Department
on Department.Dept_Id = Instructor.Dept_Id


-------------------------------------------------------------
--5.Display student full name and the name of the course he is taking For only courses which have a grade  
select ISNULL(Student.St_Fname, 'No FirstName') as StFirstName , 
ISNULL(Student.St_Lname, 'No lastName') as StLastName ,
Crs_Name
from Student , Stud_Course 
left join Course
on St_Id = Stud_Course.St_Id and Stud_Course.Crs_Id = Course.Crs_Id and Grade >=0 


-------------------------------------------------------------
--6.Display number of courses for each topic name
select Top_Name , count(*) as TopicCounts
from Topic , Course 
where Topic.Top_Id = Course.Top_Id
group by Top_Name 


-------------------------------------------------------------
--Add Salary Values
UPDATE i
SET i.Salary = v.Salary
FROM Instructor i
JOIN (VALUES
    (1,20000),
    (2,7500),
    (3,18000),
    (4,35000),
    (5,33400),
    (6,21000),
    (7,7800),
    (8,14000),
    (9,31000),
    (10,35500),
    (11,26000),
    (12,9900),
    (13,18000),
    (14,13400),
    (15,33660)
) AS v(Ins_Id, Salary)
ON i.Ins_Id = v.Ins_Id
WHERE i.Salary IS NULL;
-------------------------------------------------------------
--7.Display max and min salary for instructors
select Ins_Name, Salary 
from Instructor
where Salary = (select max(Salary) from Instructor) 
or Salary = (select min(Salary) from Instructor)


-------------------------------------------------------------
--8.Display instructors who have salaries less than the average salary of all instructors.
select Ins_Name , Salary
from Instructor
where Salary < (select avg(Salary) from Instructor)


-------------------------------------------------------------
--9.Display the Department name that contains the instructor who receives the minimum salary.
select Dept_Name , Ins_Name , Salary
from Department , Instructor
where Department.Dept_Id = Instructor.Dept_Id
and Salary = (select min(Salary) from Instructor)


-------------------------------------------------------------
--10.Select max two salaries in instructor table.
select Top(2) Salary ,Ins_Name
from Instructor
order by salary desc


-------------------------------------------------------------
--11.Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function”
select coalesce(Salary , 'instructor bonus') as Salary , Ins_Name 
from Instructor


-------------------------------------------------------------
--12.Select Average Salary for instructors 
select avg(Salary) as Avg_Salary
from Instructor


-------------------------------------------------------------
--13.Select Student first name and the data of his supervisor
select St_Fname , Manager_hiredate
from Student 
left join Department
on Student.Dept_Id = Department.Dept_Id


-------------------------------------------------------------
--14.Write a query to select the highest two salaries in Each Department for instructors who have salaries.“using one of Ranking Functions”
select Dept_Id, Ins_Name, Salary
from (select Dept_Id , Ins_Name, Salary,
      DENSE_RANK() over (partition by Dept_Id order by Salary desc) as D_SortSalaries
      from Instructor
      where Salary IS NOT NULL
      ) as DepartmentMaxSalaries
where D_SortSalaries <= 2


-------------------------------------------------------------
--15.Write a query to select a random  student from each department.“using one of Ranking Functions”
select Dept_Id, St_Fname , St_Lname
from (select Dept_Id , St_Fname , St_Lname ,
     ROW_NUMBER() over (partition by Dept_Id order by newid()) as St_ordered
     from Student
     ) as Rondom_St
where St_ordered = 1
