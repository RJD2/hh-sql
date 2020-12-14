CREATE TABLE employer
(
    id             serial primary key,
    name           text not null,
    about          text,
    city           integer not null
);

CREATE TABLE vacancy
(
    id                      serial primary key,
    employer_id             integer not null references employer (id),
    position_name           text not null,
    compensation_from       integer,
    compensation_to         integer,
    compensation_gross      boolean default false,
    published               date
);

CREATE TABLE resume
(
    id            serial primary key,
    first_name    text not null,
    middle_name   text not null,
    last_name     text not null,
    phone         text not null,
    email         text not null,
    experience    text,
    skills        text,
    city          integer not null
);

CREATE TABLE response
(
    id              serial primary key,
    vacancy_id      integer not null references vacancy (id),
    resume_id       integer not null references resume (id),
    date            date
);

INSERT INTO employer(name, about, city)
VALUES ('hh.ru', 'Охотники за головами', 1),
       ('Яндекс', 'Крупная, стремительная развивающаяся', 1),
       ('Рога и Копыта', 'Травоядные', 2),
       ('Google', 'Иностранная компания', 2),
       ('IBM', 'Бывшая империя зла', 4),
       ('Microsoft', 'Мелкомягкие', 2),
       ('Иванов и Ко', 'Иванов и компания', 3);

INSERT INTO vacancy (employer_id, position_name, compensation_from, compensation_to, compensation_gross, published)
VALUES (1, 'Разработчик', 100000, 300000, true, '10.12.2020'),
       (3, 'Тестировщик', 50000, 60000, true, '11.12.2020'),
       (2, 'Аналитик', 40000, 70000, false, '12.12.2020'),
       (4, 'Менеджер', 10000, 20000, true, '09.12.2020'),
       (6, 'Тиктолог', 150000, 170000, false, '10.12.2020'),
       (5, 'Оператор', 10000, 20000, true, '10.12.2020'),
       (1, 'Дизайнер', 35000, 60000, false, '09.12.2020'),
       (4, 'Фотограф', 10000, 20000, true, '11.12.2020'),
       (3, 'Верстальщик', 15000, 17000, false, '12.12.2020'),
       (7, 'Бухгалтер', 15000, 20000, false, '08.12.2020'),
       (5, 'Разработчик', null, null, false, '10.12.2020'),
       (2, 'Продюсер', null, null, false, '10.12.2020');

INSERT INTO resume (first_name, middle_name, last_name, phone, email, city)
VALUES ('Иван', 'Петрович', 'Иванов', '9181400656', 'true@true.ru', 1),
       ('Петр', 'Сидорович', 'Петров', '9181123456', 'true1@true.ru', 2),
       ('Сидор', 'Петровичич', 'Сидоров', '9181098765', 'true2@true.ru', 3),
       ('Павел', 'Петрович', 'Лебедев', '9181123123', 'true3@true.ru', 4),
       ('Любовь', 'Петровна', 'Иванова', '9181345345', 'true4@true.ru', 5),
       ('Галина', 'Петровна', 'Петрова', '9181223344', 'true5@true.ru', 4),
       ('Ирина', 'Петровна', 'Сидорова', '9181998877', 'true6@true.ru', 3),
       ('Геннадий', 'Петрович', 'Жуков', '9181567843', 'true7@true.ru', 2),
       ('Илья', 'Петрович', 'Бондарчук', '918123666', 'true8@true.ru', 1),
       ('Марк', 'Петрович', 'Захаров', '9181876876', 'true9@true.ru', 2),
       ('Семен', 'Петрович', 'Рублев', '9181456987', 'true10@true.ru', 3),
       ('Виталий', 'Петрович', 'Гоголь', '9181455655', 'true11@true.ru', 4);

INSERT INTO response (vacancy_id, resume_id, date)
VALUES (1, 1, '12.12.2020'),
       (1, 12, '12.12.2020'),
       (1, 3, '12.12.2020'),
       (1, 5, '12.12.2020'),
       (1, 11, '12.12.2020'),
       (2, 1, '12.12.2020'),
       (3, 10, '12.12.2020'),
       (4, 2, '12.12.2020'),
       (5, 3, '12.12.2020'),
       (5, 5, '12.12.2020'),
       (6, 1, '12.12.2020'),
       (7, 10, '12.12.2020'),
       (8, 7, '12.12.2020'),
       (9, 2, '12.12.2020'),
       (10, 3, '12.12.2020'),
       (5, 5, '12.12.2020'),
       (7, 6, '12.12.2020'),
       (3, 8, '12.12.2020');
