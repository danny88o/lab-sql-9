use sakila;
select * from payment
order by customer_id;

select c.customer_id as "Customer ID", ct.city as "City", rcat.name as "Most Rented Category",
count(distinct p.payment_id) as "Films Rented", sum(distinct p.amount) as "Total Money Spent",
dense_rank() over(partition by c.customer_id order by count(cat.category_id) desc) as "Delete", 
count(distinct frm.payment_id) as "Films rented May", count(distinct frj.payment_id) as "Films rented June"
from rental r
join customer c on c.customer_id = r.customer_id
join payment p on p.customer_id = c.customer_id 
join address ad on ad.address_id = c.address_id
join city ct on ct.city_id = ad.city_id
join inventory i on i.inventory_id = r.inventory_id
join film_category cat  on cat.film_id = i.film_id
join category rcat on rcat.category_id = cat.category_id
left join
	(select customer_id, payment_id, payment_date
    from payment
    where (date(payment_date) between date('2005-05-01') and date('2005-05-30'))
    order by customer_id asc
    ) as frm
    on frm.customer_id = c.customer_id 
left join
	(select customer_id, payment_id, payment_date
    from payment
    where (date(payment_date) between date('2005-06-01') and date('2005-06-30'))
    order by customer_id asc
    ) as frj
    on frj.customer_id = c.customer_id 
group by c.customer_id
order by c.customer_id;
-- ----------------------------------------------------------------------------------------------------------------

join
-- 3
	(
select customer_id, payment_id, payment_date
    from payment
    where (date(payment_date) between date('2005-07-01') and date('2005-07-30'))
    order by customer_id asc
    ) as frl
    on frl.customer_id = c.customer_id 


select customer_id, payment_id, payment_date
    from payment
    where (date(payment_date) between date('2005-06-01') and date('2005-06-30'))
    order by customer_id asc;


select c.customer_id as "Customer ID", concat(c.first_name, " ", c.last_name) as "Name", ct.city as "City", count(distinct p.payment_id) as "Films Rented",  
cat.category_id, sum(p.amount) as "Total Money Spent", convert(r.rental_date, date) as "Rental Date"
from customer c

left join payment p on p.customer_id = c.customer_id 

left join address ad on ad.address_id = c.address_id
left join city ct on ct.city_id = ad.city_id

left join rental r on r.customer_id = c.customer_id

join inventory i on i.inventory_id = r.inventory_id
left join 
	(
	SELECT category_id, film_id 
    FROM film_category
    GROUP BY film_id
    ORDER BY count(*) DESC
    LIMIT 1
    ) as  cat
  on cat.film_id = i.film_id 	

group by c.customer_id
order by c.customer_id;





select * from film_
category;

-- rank() over (partition by c.customer_id) as "rank"

select c.customer_id as "Customer ID", concat(c.first_name, " ", c.last_name) as "Name", count(p.rental_id) as "Films Rented", 
sum(p.amount) as "Total Money Spent"
from payment p
join customer c on c.customer_id = p.customer_id

group by c.customer_id
order by c.customer_id;

(SELECT fcg.category_id
            FROM film_category fcg
           WHERE fcg.film_id = i.film_id 
           ORDER BY t.amount DESC
           LIMIT 1
        ) AS `Amount`,
  (
  
  left join (
	SELECT category_id FROM film_category fcg
    WHERE fcg.film_id = i.film_id 
    GROUP BY category_id
    ORDER BY count(*) DESC
    LIMIT 1
  ) "Most Popular Category"
  
, count(distinct frl.payment_id) as "Films rented July", count(distinct fra.payment_id) as "Films rented August"


join
-- 4
	(
select customer_id, payment_id, payment_date
    from payment
    where (date(payment_date) between date('2005-06-01') and date('2005-06-30'))
    order by customer_id asc
    ) as fra
    on fra.customer_id = c.customer_id 