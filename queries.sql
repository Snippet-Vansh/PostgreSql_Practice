
CREATE TABLE products
(
    product_id integer NOT NULL DEFAULT nextval('products_product_id_seq'::regclass),
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    sku_code character(8) COLLATE pg_catalog."default" NOT NULL,
    price numeric(10,2),
    stock integer DEFAULT 0,
    is_available boolean DEFAULT true,
    category text COLLATE pg_catalog."default" NOT NULL,
    added_on date DEFAULT CURRENT_DATE,
    last_update timestamp without time zone DEFAULT now(),
    CONSTRAINT products_pkey PRIMARY KEY (product_id),
    CONSTRAINT products_sku_code_key UNIQUE (sku_code),
    CONSTRAINT products_price_check CHECK (price >= 0::numeric),
    CONSTRAINT products_stock_check CHECK (stock >= 0)
);





insert into products (name,sku_code,price,stock,is_available,category)
values ('Phone','r932135',999.9,50,TRUE,'Electronic'),
 ('Keyboard','Wt332135',399.9,50,TRUE,'Electronic'),
('Laptop','Wq332135',689.9,50,TRUE,'Electronic'),
('Speaker','We332135',499.9,50,TRUE,'Electronic'),
('Headset','Wr332135',199.9,50,TRUE,'Electronic');
insert into products (name,sku_code,price,stock,is_available,category)
values ('Keypad','RR332135',399.9,50,TRUE,'Electronic');

  clauses -:
  
select * from products where category = 'Electronic' ;
select name,price from products;
select category from products Group by category;
select category ,count(*) from products
Group by category 
Having count(*) > 1;

select * from products order by price DESC;
select * from products order by price ASC;
select * from products order by name;
select * from products limit 3;

select name as item_name,price as item_price from products;

select Distinct category from products

insert into products (name,sku_code,price,stock,is_available,category)
values ('T-Shirt','Fa332135',29.9,100,TRUE,'Fashion'),
('Jeans','Fb332135',49.9,80,TRUE,'Fashion'),
('Sneakers','Fc332135',89.9,60,TRUE,'Fashion'),

('Rice Bag','Ga332135',19.9,200,TRUE,'Grocery'),
('Milk','Gb332135',2.9,150,TRUE,'Grocery'),
('Coffee','Gc332135',9.9,75,TRUE,'Grocery');

select * from products;
select * from products where category = 'Fashion';
select * from products where category != 'Fashion';
 select * from products where price < 400;
 select * from products where price > 400;
 select * from products where price <40 and category = 'Fashion' ;
 select * from products where price Between 400 and 1000;
 select * from products where category = 'Grocery' or category = 'Fashion';
 select * from product where category in ('Fashion' , 'Electronic');

 select * from products where sku_code like ('W%');
 select * from products where sku_code like ('%21%');
 select * from products where sku_code like ('_r%');
 select * from products where category = 'Electronic';

     Aggregation -:
 select count(product_id) from products;
 select * from products;
select sum(price) from products;
select sum(price) from products where category = 'Fashion' or category = 'Grocery';
select max(price) from products;

select min(price,name) from the products where category = 'Fashion' or category = 'Electronic' 
category = 'Grocery';

SELECT  name, price
FROM products 
WHERE price = (
    SELECT MIN(price)
    FROM products 
  
);

select avg(price) from products where category in ('Fashion','Utensils','Grocery'); 

SELECT category, name, price
FROM products p1
WHERE price = (
    SELECT MAX(price)
    FROM products p2
    WHERE p1.category = p2.category
);

SELECT name, price
FROM products
ORDER BY price ASC
LIMIT 1;

SELECT name, stock
FROM products
WHERE is_available = TRUE
  AND stock > 50
  AND price != 299;

  SELECT DISTINCT UPPER(category)
FROM products
ORDER BY UPPER(category) DESC;