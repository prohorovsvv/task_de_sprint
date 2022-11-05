-- Создание таблиц

-- 1. Таблица отделов
CREATE TABLE IF NOT EXISTS department(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    department_head TEXT,
    amount INTEGER);

-- 2. Таблица с сотрудниками
CREATE TABLE IF NOT EXISTS employee(
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    start_date DATE NOT NULL,
    job_title TEXT NOT NULL,
    level TEXT NOT NULL,
    salary INTEGER NOT NULL,
    id_department INTEGER REFERENCES department (id),
    access boolean DEFAULT FALSE);
    

-- 3. Таблица оценки сотрудника
CREATE TABLE IF NOT EXISTS grade(
    id_employee INTEGER REFERENCES employee (id),
    quarter TEXT,
    rezult TEXT);
    

-- Заполнение таблиц

-- Добавление отделов
INSERT INTO department (title,department_head,amount) VALUES 
    ('IT', 'Иванов Иван Иванович', 4),
    ('HR', 'Румянцева Марина Анатольевна', 6),
    ('Sales', 'Стребков Алексей Михайлович', 9)

-- Добавление сотрудникво
INSERT INTO employee (full_name, date_of_birth,start_date,job_title,level,salary, id_department,access) VALUES
('Иванов Степан Петрович', '1986-09-23', '2020-08-23', 'Разработчик', 'middle', 80000, 1, True)
('Степанюк Александ Игоревич', '1985-03-25', '2022-04-22', 'Аналитик', 'junior', 30000, 1, False),
('Базякина Ирина Михайловна', '1990-04-16', '2020-08-23', 'Рекрутер', 'lead', 90000, 2, True),
('Жиров Максим Николаевич', '1991-11-27', '2021-10-23', 'Менеджер', 'middle', 100000, 3, True),
('Миронов Алексей Сергеевич', '1990-04-20', '2019-06-23', 'Старший менеджер', 'senior', 110000, 3, True);


-- Добавление оценок
INSERT INTO grade (id_employee,quarter,rezult) VALUES
    (1,'I','B'),
    (1,'II','C'),
    (1,'III','E'),
    (1,'IV','D'),
    (2,'I','A'),
    (2,'II','C'),
    (2,'III','D'),
    (2,'IV','E'),
    (3,'I','A'),
    (3,'II','C'),
    (3,'III','D'),
    (3,'IV','E')
    (4,'I','B'),
    (4,'II','C'),
    (4,'III','E'),
    (4,'IV','D'),
    (5,'I','B'),
    (5,'II','C'),
    (5,'III','E'),
    (5,'IV','D');

 --Добаление нового отдела и сотрудников
INSERT INTO department (title,department_head,amount) VALUES ('Интеллектуального анализа данных', 'Дмитриев Петр Алексеевич', 3);

INSERT INTO employee (full_name, date_of_birth,start_date,job_title,level,salary, id_department,access) VALUES
('Васильев Дмитрий Олегович', '1986-09-23', '2022-08-27', 'ML engineer', 'middle', 90000, 4, True),
('Громов Артем Евгеньевич', '1991-02-21', '2022-08-27', 'Data engineer', 'junior', 50000, 4, False);

INSERT INTO grade (id_employee,quarter) VALUES
    (6,'I'),
    (6,'II'),
    (6,'III'),
    (6,'IV'),
    (7,'I'),
    (7,'II'),
    (7,'III'),
    (7,'IV');

-- Теперь пришла пора анализировать наши данные – напишите запросы для получения следующей информации:

-- Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
select id, full_name, CURRENT_DATE-start_date as experience
from employee;

-- Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
select id, full_name, CURRENT_DATE-start_date as experience
from employee
limit 3;

-- Уникальный номер сотрудников - Разработчик
select id
from employee
where job_title = 'Разработчик';

-- Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E - таких сотрудников нет
select id_employee
from (select id_employee, rezult , quarter
    from grade
    where quarter = 'I') as I_q
where rezult in ('D','E')

-- Выведите самую высокую зарплату в компании.
select max(salary)
from employee

-- * Выведите название самого крупного отдела
select title
from department
where amount = (select max(amount) from department)

-- * Выведите номера сотрудников от самых опытных до вновь прибывших
select id
from employee
order by CURRENT_DATE-start_date desc

-- * Рассчитайте среднюю зарплату для каждого уровня сотрудников

select level, avg(salary) as avg_salary
from employee
group by level
