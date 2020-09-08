-- CREATE TABLES
CREATE TABLE comm_customers
(
    customer# NUMBER(4) PRIMARY KEY,
    firstname VARCHAR2(10),
    lastname VARCHAR2(10),
    phone NUMBER(10),
    email VARCHAR2(15),
    city VARCHAR2(10),
    province VARCHAR2(2),
    zip VARCHAR2(6),
    address VARCHAR2(20)
);

CREATE TABLE comm_products
(
    product# NUMBER(4) PRIMARY KEY,
    pcategory VARCHAR2(10),
    pname VARCHAR2(20),
    price NUMBER(4),
    colour VARCHAR2(8),
    psize VARCHAR2(3)
);

CREATE TABLE comm_carts
(
    cart# NUMBER(2) PRIMARY KEY,
    customer# NUMBER(4),
    CONSTRAINT FK_CUSTOMER# FOREIGN KEY(cusotomer#) REFERENCES comm_customers(customer#)
);

CREATE TABLE comm_shippinginfo
(
    transaction# NUMBER(2) PRIMARY KEY,
    cart# NUMBER(3),
    product# NUMBER(4),
    city VARCHAR2(20),
    province VARCHAR2(2),
    zip VARCHAR2(6),
    address VARCHAR2(25),
    shipdate DATE,
    CONSTRAINT FK_ADDRESS_CART# FOREIGN KEY(cart#) REFERENCES comm_carts(cart#)
);

CREATE TABLE comm_cartitems
(
    cart# NUMBER(2),
    product# NUMBER(4),
    quantity NUMBER(2),
    price NUMBER(3),
    status VARCHAR2(20),
    orderdate DATE,
    CONSTRAINT FK_CART# FOREIGN KEY(cart#) REFERENCES comm_carts(cart#),
    CONSTRAINT FK_PRODUCT# FOREIGN KEY(product#) REFERENCES comm_products(product#),
    PRIMARY KEY(cart#, product#)
);

SELECT * FROM user_cons_columns 
WHERE table_name = 'COMM_CARTITEMS' ORDER BY table_name;



-- insert records into the tables
INSERT ALL
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR, PSIZE) VALUES(1001, 'Clothes', 'Tshirt', 23, 'BLACK', 'XL')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR, PSIZE) VALUES(1002, 'Clothes', 'Jeans', 47, 'BLUE', 'S')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR, PSIZE) VALUES(1003, 'Clothes', 'Coat', 250, 'BEIGE', 'M')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR, PSIZE) VALUES(1004, 'Clothes', 'Shorts', 30, 'BLUE', 'M')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR) VALUES(1005, 'Toy', 'Toy car', 50, 'RED')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR) VALUES(1006, 'Toy', 'Toy kitchen', 78, 'GRAY')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE, COLOUR) VALUES(1007, 'Toy', 'Doll', 45, 'PURPLE')
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE) VALUES(1008, 'Book', 'Happiness', 15)
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE) VALUES(1009, 'Book', 'Dream Boat', 20)
    INTO comm_products (PRODUCT#, PCATEGORY, PNAME, PRICE) VALUES(1010, 'Book', 'Cleaning', 18)
SELECT * FROM dual;

INSERT ALL
    INTO comm_customers (CUSTOMER#, FIRSTNAME, LASTNAME, PHONE, EMAIL, CITY, PROVINCE, ZIP, ADDRESS) VALUES(1000, 'Milli', 'Mohammed', 6472158647, 'moha@gmail.com', 'Toronto', 'ON', 'M6C4S8', '980 Robson St')
    INTO comm_customers (CUSTOMER#, FIRSTNAME, LASTNAME, PHONE, EMAIL, CITY, PROVINCE, ZIP, ADDRESS) VALUES(1001, 'Jared', 'Smith', 6475478516, 'smit@gmail.com', 'Vancouver', 'BC', 'A1CR4K', '1005 Cordova St')
    INTO comm_customers (CUSTOMER#, FIRSTNAME, LASTNAME, PHONE, EMAIL, CITY, PROVINCE, ZIP, ADDRESS) VALUES(1002, 'Thelma', 'Wiggins', 6475147569, 'wthe@office.com', 'Richmond', 'BC', 'M1R2C5', '822 Yonge St')
    INTO comm_customers (CUSTOMER#, FIRSTNAME, LASTNAME, PHONE, EMAIL, CITY, PROVINCE, ZIP, ADDRESS) VALUES(1003, 'Gregory', 'Askew', 6475241415, 'Gg@outlook.com', 'Montreal', 'QC', 'C3M4M2', '7 Boulevard Lafleche')
    INTO comm_customers (CUSTOMER#, FIRSTNAME, LASTNAME, PHONE, EMAIL, CITY, PROVINCE, ZIP, ADDRESS) VALUES(1004, 'Marc', 'Pooley', 6473775862, 'Marc@Yahoo.com', 'Coe Hill', 'ON', 'K0L1P0', '442 Reserve St')
SELECT * FROM dual;

INSERT ALL
    INTO comm_carts VALUES(01, 1000)
    INTO comm_carts VALUES(02, 1001)
    INTO comm_carts VALUES(03, 1002)
    INTO comm_carts VALUES(04, 1003)
    INTO comm_carts VALUES(05, 1004)
SELECT * FROM dual;

INSERT ALL
    INTO comm_cartitems (cart#, product#, quantity)
    VALUES(1, 1001, 2)
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate, shipdate)
    VALUES(1, 1005, 3, 'Checked out', '20-02-02', '20-02-20') -- took 18 days
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate, shipdate)
    VALUES(2, 1003, 1, 'Checked out', '19-01-20', '19-01-25') -- took 5 days
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate, shipdate)
    VALUES(2, 1008, 2, 'Checked out', '19-08-15', '19-08-17') -- took 2 days
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate, shipdate)
    VALUES(3, 1004, 1, 'Checked out', '20-05-03', '20-05-29') -- took more than 1 month
    INTO comm_cartitems (cart#, product#, quantity)
    VALUES(4, 1002, 2)
    INTO comm_cartitems (cart#, product#, quantity)
    VALUES(4, 1007, 3)
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate)
    VALUES(4, 1006, 1, 'Checked out', '19-07-23') -- not shipped yet
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate, shipdate)
    VALUES(5, 1009, 4, 'Checked out', '19-07-04', '19-07-20') -- took 16 days
    INTO comm_cartitems (cart#, product#, quantity, status, orderdate)
    VALUES(5, 1010, 3, 'Checked out', '20-06-28') -- not shipped yet
SELECT * FROM dual;

-- set price based on the quantity and the price of the product
UPDATE comm_cartitems c
SET price = (SELECT price FROM comm_products p WHERE c.product# = p.product#) * c.quantity;

INSERT ALL
    INTO comm_shippinginfo VALUES(01, 001, 1005, 'Toronto', 'ON', 'M6C4S8', '980 Robson St', 'STEP_3')
    INTO comm_shippinginfo VALUES(02, 002, 1003, 'Vancouver', 'BC', 'A1CM4K', '17 Cordova St', 'STEP_3')
    INTO comm_shippinginfo VALUES(03, 002, 1008, 'Richmond', 'BC', 'M1R2C5', '822 Yonge St', 'STEP_3')
    INTO comm_shippinginfo VALUES(04, 003, 1004, 'Victoria', 'BC', 'N1C2K5', '1050 Goulden St', 'STEP_3')
    INTO comm_shippinginfo VALUES(05, 004, 1006, 'Coe Hill', 'ON', 'K0L1P0', '442 Reserve St', 'STEP_2')
    INTO comm_shippinginfo VALUES(06, 005, 1009,  'Ottawa', 'BC', 'M1A4L0', '88 George St', 'STEP_3')
    INTO comm_shippinginfo VALUES(07, 005, 1010,  'Ottawa', 'BC', 'M1A4L0', '88 George St', 'STEP_2')
SELECT * FROM dual;

DELETE FROM comm_shippinginfo;





-- 1. What is the name of the products in the customer# 1000's shopping cart?
SELECT customer#, cart#, CONCAT(firstname, CONCAT(' ', lastname)) AS name, pname
FROM comm_customers
JOIN comm_carts USING(customer#)
JOIN comm_cartitems USING(cart#)
JOIN comm_products USING (product#)
WHERE customer# = 1000;

-- 2. Display customers' home address and shipping address
SELECT DISTINCT cus.customer#, cus.address home, s.address shipping
FROM comm_customers cus, comm_carts car, comm_shippinginfo s
WHERE 
    cus.customer# = car.customer# AND
    s.cart# = car.cart# 
ORDER BY cus.customer#;

-- 3. Count the number of the products in each cart
SELECT cart#, COUNT(product#) AS number_of_product
FROM comm_cartitems
GROUP BY cart#;

-- 4. Display cart# and the most expensive product which is more expensive than $100
SELECT cart#, MAX(price) max_price_product
FROM comm_cartitems
GROUP BY cart#
HAVING MAX(price) > 100;

-- 5. Single row function displaying the customer's name and cart number between 2 and 4
SELECT CONCAT('Cart ', CONCAT(cart#, CONCAT(' is ', CONCAT(firstname, '''s cart')))) 
AS "Cart INFO"
FROM comm_carts car
JOIN comm_customers cus ON car.customer# = cus.customer#
WHERE cart# BETWEEN 2 AND 4;

-- 6. list of products that are on the way
SELECT transaction#, product#,  shipstatus
FROM comm_shippinginfo
WHERE shipstatus LIKE '%_2';

-- 7. Products that are shipped within 7 days
SELECT pname, (shipdate - orderdate) || ' Days' time_taken
FROM comm_cartitems
JOIN comm_products USING(product#)
WHERE shipdate - orderdate < 8 AND
shipdate IS NOT NULL;

-- 8. Number of customer in same province
SELECT CONCAT(COUNT(customer#), CONCAT(' customer(s) are(is) living in ', province)) customer_info
FROM comm_customers
GROUP BY province;




