Q1. Who is the senior most employee based on job tittle?

select*from employee
order by levels Desc
limit 1

Q2.Which countries have the most Invoices?

select count(*) as c ,billing_country
from invoice
group by billing_country
order by c desc

Q3.What are top three values of total invoice

select total from invoice
order by total desc
limit 3

Q4.Which city has the best customer? we would like to throw a promotional Music Festival in the
city we made the most money.write a query that returns one city that has the highest sum of 
invoice totals.Return both the city name &sum of all invoice totals

select billing_city,sum(total) as invoice_total
from invoice 
group by billing_city 
order by invoice_total desc
limit 1

Q5.Who is the best customer?The customer who has spent the most money wil be declared the best
customer.write a query that returns the person who has spent the most money.

select first_name,last_name,sum(total) as invoice_total
from customer inner join invoice on customer.customer_id=invoice.customer_id 
group by first_name,last_name
order by invoice_total desc
limit 1

Q6. Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
Return your list ordered alphabetically by email starting with A

select distinct first_name,last_name,email
from customer inner join invoice on customer.customer_id=invoice.customer_id
inner join invoice_line on invoice.invoice_id=invoice_line.invoice_id
inner join track on invoice_line.track_id=track.track_id
inner join genre on track.genre_id=genre.genre_id
where Genre.name like'Rock'
order by email

Q7.Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands

select artist.name,artist.artist_id,count(artist.artist_id)
from artist inner join album on artist.artist_id=album.artist_id
inner join track on album.album_id=track.album_id
inner join genre on track.genre_id=genre.genre_id
where genre.name like'Rock'
group by artist.name,artist.artist_id
order by count(artist.artist_id) desc
limit 10

Q8. Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.


select name,milliseconds
from track
where milliseconds>(select avg(milliseconds) from track)
order by milliseconds desc

Q9. Find how much amount spent by each customer on artist? write a query that returns customer 
name,artist name,total spent.


SELECT 
    customer.first_name,
    customer.last_name,
    (
        SELECT artist.name
        FROM 
            album AS a
            INNER JOIN artist ON a.artist_id = artist.artist_id
            INNER JOIN track ON a.album_id = track.album_id
            INNER JOIN invoice_line ON track.track_id = invoice_line.track_id
        GROUP BY 
            artist.artist_id, artist.name
        ORDER BY 
            SUM(invoice_line.unit_price * invoice_line.quantity) DESC
        LIMIT 1
    ) AS best_selling_artist_name,
    SUM(invoice_line.unit_price * invoice_line.quantity) AS amount
FROM 
    customer 
INNER JOIN 
    invoice ON customer.customer_id = invoice.customer_id
INNER JOIN 
    invoice_line ON invoice.invoice_id = invoice_line.invoice_id
INNER JOIN 
    track ON invoice_line.track_id = track.track_id
INNER JOIN 
    album ON track.album_id = album.album_id
GROUP BY 
    customer.first_name, customer.last_name, best_selling_artist_name
ORDER BY 
    amount DESC;



