---- SOLVE CASE STUDY---

--1.What is the total amount each customer spent at the restaurant?
SELECT customer_id,SUM(price) as amount_spent FROM Sales a left join menu  m on a.product_id=m.product_id GROUP BY customer_id;
/* 1. Answer
customer A spent 76 amount money at the restaurant
customer B spent 74 amount money at the restaurant
customer C spent 36 amount money at the restaurant
*/

--2. How many days has each customer visited the restaurant?
SELECT customer_id,count(distinct(order_date)) as no_time_visit FROM SALES GROUP BY customer_id;
/* 2. Answer
customer A visited resturant no. of 4 times
customer B visited resturant no. of 6 times
customer C visited resturant no. of 2 times
*/

--3.What was the first item from the menu purchased by each customer?
SELECT customer_id, product_name, order_date FROM sales  S LEFT JOIN menu M  ON  S.product_id=M.product_id where order_date='2021-01-01' GROUP BY customer_id,product_name,order_date;

/* 3. Answer
customer first order of A was curry & sushi 
customer first order of B was curry
customer first order of ramen 
*/


---4.What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT top 1 product_name,count(product_name) as most_purchased   fROM sales S Left JOIN menu M ON M.product_id = S.product_id GROUP BY product_name ORDER BY most_purchased DESC; 

/* 4. Answer
Most purchase item is 'ramen' who 8 no. of times purchased by all customers
*/


---5.Which item was the most popular for each customer?
SELECT product_name,count(product_name) as no_of_times ,customer_id FROM SALES s LEFT JOIN MENU m on s.product_id = m.product_id GROUP BY customer_id,product_name ORDER BY no_of_times DESC;
/* 5. Answer
customer A most like item 'rament'
and customer B,C also like this item */


---6.Which item was purchased first by the customer after they became a member?
SELECT distinct menu.product_id,m.customer_id,product_name as first_time_purchased FROM sales s JOIN members m on s.customer_id=m.customer_id JOIN menu  on s.product_id=menu.product_id where m.customer_id='A' AND order_date > '2021-01-07';

/* 6.Answer
So first item 'ramen' purchased by A
*/

---7.Which item was purchased just before the customer became a member?
SELECT distinct menu.product_id,m.customer_id,product_name as first_purchased_item,order_date as purchased_date FROM sales s JOIN members m on s.customer_id=m.customer_id JOIN menu  on s.product_id=menu.product_id where m.customer_id ='A' /*=> THIS IS FIRST MEMBER */  AND order_date < join_date /* THIS IS FIRST MEMBERSHIP DATE*/;
/* 7.Answer for First member whoes 'A'
so, Before take membership 'A' purchased two item

itme_1="id=1,name=sushi,purchased_date=2021-01-01" 

item_2="id=2,name=curry,purchased_date=2021-01-01"
*/
 
SELECT distinct menu.product_id,m.customer_id,product_name as first_purchased_item,order_date as purchased_date  FROM sales s JOIN members m on s.customer_id=m.customer_id JOIN menu  on s.product_id=menu.product_id where m.customer_id ='B' /*=> THIS IS second MEMBER */  AND order_date < join_date /* THIS IS FIRST MEMBERSHIP DATE*/;
/* 7. Answer for second member whoes 'B'
So, Before take membership 'B' purchased two item 
item_1="id=1, name=sushi,purchased_date=2021-01-04"

item_2 ="id=2 ,name=curry, purchased_date= 2021-01-01, 2021-01-02"
*/

---8.What is the total items and amount spent for each member before they became a member?
---Customer A
SELECT  product_name,customer_id,sum(price) as spent_amount from Sales S JOIN menu M on S.product_id=M.product_id WHERE customer_id='A' AND order_date<'2021-01-07' GROUP BY product_name,customer_id
 /* 8. Answer
 Customer 'A' spent 15 amount on curry and 10 amount on sushi 
 */
 --- Customer B
SELECT  product_name,customer_id,sum(price) as spent_amount from Sales S JOIN menu M on S.product_id=M.product_id WHERE customer_id='B' AND order_date<'2021-01-09' GROUP BY product_name,customer_id
/* 8. Answer 
Customer B spen 30 amount on curry and 10 amount on sushi. */

----9.If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?10.
SELECT customer_id,
SUM(CASE
    WHEN product_name = 'sushi' THEN 20 * price
    ELSE 10 * price
END) total_points
FROM sales S
LEFT JOIN menu  M
  ON S.product_id = M.product_id
GROUP BY customer_id;

/* 9. Answer 
Total points for Customer A, B and C are 860, 940 and 360 respectively */


---10.In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
WITH cte_OfferValidity AS 
    (SELECT s.customer_id, m.join_date, s.order_date,
        DATEADD(DAY, 6, m.join_date) AS firstweek_ends, menu.product_name, menu.price
    FROM sales s
    LEFT JOIN members m
      ON s.customer_id = m.customer_id
    LEFT JOIN menu
        ON s.product_id = menu.product_id)
SELECT customer_id,
    SUM(CASE
            WHEN order_date BETWEEN join_date AND firstweek_ends THEN 20 * price 
            WHEN (order_date NOT BETWEEN join_date AND firstweek_ends) AND product_name = 'sushi' THEN 20 * price
            ELSE 10 * price
        END) points
FROM cte_OfferValidity
WHERE order_date < '2021-02-01' -- filter jan points only
GROUP BY customer_id;

/* 10.Answer 
Customer A and B has 1370 and 820 point respectively at end of the jan.
*/


