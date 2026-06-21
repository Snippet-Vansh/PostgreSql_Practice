select name,price, 
case when price > 100 then 'Expensive'
     when price  between 500 and 660 then 'Moderate'
	  else 'Cheap'
	  end as price_tag
	  from products;

select * from products;

alter table products
add column price_tag text;

update products 
set price_tag =
case when price > 1000 then 'Expensive'
     when price  between 500 and 660 then 'Moderate'
	  else 'Cheap'
	end;
