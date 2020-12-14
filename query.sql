/* Вывести название вакансии, город, в котором опубликована вакансия (можно просто area_id),
   имя работодателя для первых 10 вакансий у которых не указана зарплата,
   сортировать по дате создания вакансии от новых к более старым.
 */
SELECT position_name, city, name
from vacancy v
         INNER JOIN employer e on e.id = v.employer_id
WHERE compensation_from is null
  and compensation_to is null
ORDER BY published
LIMIT 10;

/* Вывести среднюю максимальную зарплату в вакансиях,
   среднюю минимальную и среднюю среднюю (compensation_to - compensation_from) в одном запросе.
   Значения должны быть указаны до вычета налогов.
*/
SELECT avg(CASE
               WHEN compensation_gross IS TRUE
                   THEN compensation_to
               ELSE compensation_to / 0.87
    END)        AS avg_max,
       avg(CASE
               WHEN compensation_gross IS TRUE
                   THEN compensation_from
               ELSE compensation_from / 0.87
           END) AS avg_min,
       avg(CASE
               WHEN compensation_gross IS TRUE
                   THEN (compensation_to + compensation_from) / 2
               ELSE (compensation_to + compensation_from) / 0.87 / 2
           END) AS avg
FROM vacancy;

/* Вывести топ-5 компаний, получивших максимальное количество откликов на одну вакансию,
   в порядке убывания откликов. Если более 5 компаний получили одинаковое максимальное количество откликов,
   отсортировать по алфавиту и вывести только 5.
*/
WITH response_count AS (
    SELECT employer_id,
           max(response) AS max_response
    FROM (
             SELECT employer_id,
                    vacancy_id,
                    COUNT(1) AS response
             FROM response r
                      LEFT JOIN vacancy v on r.vacancy_id = v.id
             GROUP BY employer_id, vacancy_id
         ) AS inner_table
    GROUP BY employer_id
    ORDER BY max_response DESC
)
SELECT name
FROM response_count AS rc
         LEFT JOIN employer AS emp ON rc.employer_id = emp.id
ORDER BY max_response DESC, name
LIMIT 5;

/* Вывести медианное количество вакансий на компанию. Использовать percentile_cont.
*/
WITH vacancy_count AS (
    SELECT COUNT(*) AS n
    FROM vacancy v
    GROUP BY v.employer_id
)
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY vacancy_count.n) AS median
FROM vacancy_count;

/* Вывести минимальное и максимальное время от создания вакансии до первого отклика для каждого города.
*/
SELECT city,
       MIN(response.date - vacancy.published) AS min_time,
       MAX(response.date - vacancy.published) AS max_time
FROM response
         LEFT JOIN vacancy ON response.vacancy_id = vacancy.id
         LEFT JOIN employer ON vacancy.employer_id = employer.id
GROUP BY city;
