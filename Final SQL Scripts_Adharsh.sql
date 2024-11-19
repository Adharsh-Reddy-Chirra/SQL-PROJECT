TO ACHIEVE GOOD OUTCOMES, PLEASE RUN THE INCLUDED SQL QUERIES IN THE BELOW SUGGESTED ORDER:


TABLE CREATION:

CREATE TABLE prod_category (
    category_name VARCHAR(50) NOT NULL,
    categ_descript VARCHAR(30),
    PRIMARY KEY (category_name)
);

CREATE TABLE products (
    product_id DECIMAL(10) NOT NULL,
    category_name VARCHAR(50) NOT NULL,
    prod_name VARCHAR(30) NOT NULL,
    prod_descript VARCHAR(30),
    price DECIMAL(10) NOT NULL,
    quantity DECIMAL(10) NOT NULL,
    PRIMARY KEY (product_id),
    FOREIGN KEY (category_name) REFERENCES prod_category(category_name)
);

CREATE TABLE person (
    person_id DECIMAL(10) NOT NULL,
    username VARCHAR(50) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    email VARCHAR(30),
    address VARCHAR(30),
    PRIMARY KEY (person_id)
);

CREATE TABLE seller (
    person_id DECIMAL(10) NOT NULL,
    brand_name VARCHAR(30),
    rating DECIMAL(10),
    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE buyer (
    person_id DECIMAL(10) NOT NULL,
    subscription VARCHAR(30),
    PRIMARY KEY (person_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE inventory (
    person_id DECIMAL(10) NOT NULL,
    product_id DECIMAL(10) NOT NULL,
    product_count DECIMAL(10),
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipping (
    shipping_id DECIMAL(10) NOT NULL,
    status VARCHAR(30) NOT NULL,
    service_provider VARCHAR(30),
    PRIMARY KEY (shipping_id)
);

CREATE TABLE orders (
    order_id DECIMAL(10) NOT NULL,
    person_id DECIMAL(10) NOT NULL,
    shipping_id DECIMAL(10) NOT NULL,
    order_status VARCHAR(30),
    PRIMARY KEY (order_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping(shipping_id),
    FOREIGN KEY (person_id) REFERENCES buyer(person_id)
);

CREATE TABLE returns (
    return_id DECIMAL(10) NOT NULL,
    person_id DECIMAL(10) NOT NULL,
    product_id DECIMAL(10) NOT NULL,
    reason VARCHAR(30),
    status VARCHAR(30),
    PRIMARY KEY (return_id),
    FOREIGN KEY (person_id) REFERENCES buyer(person_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE customer_service (
    service_id DECIMAL(10) NOT NULL,
    person_id DECIMAL(10) NOT NULL,
    serv_type VARCHAR(30),
    discript VARCHAR(200) NOT NULL,
    status VARCHAR(30),
    PRIMARY KEY (service_id),
    FOREIGN KEY (person_id) REFERENCES buyer(person_id)
);
 
CREATE TABLE orders_list (
    order_id DECIMAL(10) NOT NULL,
    product_id DECIMAL(10) NOT NULL,
    quantity DECIMAL(10),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);






STORED PROCEDURES:

CREATE OR REPLACE PROCEDURE ADD_person(
    person_id_arg IN DECIMAL,
    phone_arg IN VARCHAR,
    email_arg IN VARCHAR,
    address_arg IN VARCHAR,
    firstname_arg IN VARCHAR,
    lastname_arg IN VARCHAR)
IS
BEGIN
    INSERT INTO person
        (person_id, phone, email, address, username)
    VALUES
        (person_id_arg, phone_arg, email_arg, address_arg, firstname_arg || ' ' || lastname_arg);
END;
/
CREATE OR REPLACE PROCEDURE ADD_seller(
    person_id IN DECIMAL,
    brand_name IN VARCHAR,
    rating IN DECIMAL)
IS
BEGIN
    INSERT INTO seller
        (person_id, brand_name, rating)
    VALUES
        (person_id, brand_name, rating);
END;

create or replace PROCEDURE ADD_inventory(
    person_id_ARG IN DECIMAL,
    product_id_arg IN decimal,
    product_count_arg IN decimal)
IS
BEGIN
    INSERT INTO inventory
        (person_id, product_id, product_count)
    VALUES
        (person_id_ARG, product_id_arg, product_count_arg);
END;

create or replace PROCEDURE ADD_buyer(
    person_id_arg DECIMAL,
    subscription_arg VARCHAR)
IS
BEGIN
    INSERT INTO buyer
        (person_id, subscription)
    VALUES
        (person_id_arg, subscription_arg);
END;

create or replace PROCEDURE ADD_customer_service(
    service_id_arg DECIMAL,
    person_id_arg DECIMAL,
    serv_type_arg VARCHAR,
    discript_arg VARCHAR,
    status_arg VARCHAR)
IS
BEGIN
    INSERT INTO customer_service
        (service_id, person_id, serv_type, discript, status)
    VALUES
        (service_id_arg, person_id_arg, serv_type_arg, discript_arg, status_arg);
END;

create or replace PROCEDURE ADD_SHIPPING(
    shipping_id_arg DECIMAL,
    status_arg VARCHAR,
    service_provider_arg VARCHAR)
IS
BEGIN
    INSERT INTO shipping
        (shipping_id, status, service_provider)
    VALUES
        (shipping_id_arg, status_arg, service_provider_arg);
END;

create or replace PROCEDURE ADD_orders_list(
    order_id_arg DECIMAL,
    product_id_arg DECIMAL,
    quantity_arg decimal)
IS
BEGIN
    INSERT INTO orders_list
        (order_id, product_id, quantity)
    VALUES
        (order_id_arg, product_id_arg, quantity_arg);
END;

CREATE OR REPLACE PROCEDURE ADD_PRODUCTS(
    product_id_ARG IN DECIMAL,
    category_name_arg IN VARCHAR,
    prod_name_arg IN VARCHAR,
    prod_descript_ARG IN VARCHAR,
    price_ARG IN DECIMAL,
    quantity_ARG IN DECIMAL)
IS
BEGIN
    INSERT INTO products
        (product_id, category_name, prod_name, prod_descript, price, quantity)
    VALUES
        (product_id_ARG, category_name_arg, prod_name_arg, prod_descript_ARG, price_ARG, quantity_ARG);
END;
/





INSERTING VALUES:

BEGIN
    ADD_CATEGORY('Electronics', 'related to electronics');
END;
/
BEGIN
    ADD_CATEGORY('Computers', 'gadgets related to computers');
END;
/
BEGIN
    ADD_CATEGORY('Furniture', 'related to comfort');
END;
/

BEGIN
    ADD_PRODUCTS(1, 'Computers', 'acer', 'nitro 5', 600, 10);
END;
/

BEGIN
    ADD_PRODUCTS(2, 'Electronics', 'mouse', 'gaming mouse', 20, 15);
END;
/

BEGIN
    ADD_PRODUCTS(3, 'Electronics', 'cable', 'ethernet cable', 15, 20);
END;
/

BEGIN
    ADD_PRODUCTS(4, 'Electronics', 'cpu', 'with high-end processor', 500, 5);
END;
/

BEGIN
    ADD_PRODUCTS(5, 'Computers', 'hp', '2gb ram', 20, 12);
END;
/

BEGIN
    ADD_PRODUCTS(6, 'Furniture', 'table', 'glossy finish', 25, 8);
END;
/

BEGIN
    ADD_PRODUCTS(7, 'Furniture', 'closet', 'mobile closet', 30, 5);
END;
/

BEGIN
    ADD_PRODUCTS(8, 'Electronics', 'self-driving video camera', 'follows a subject', 180, 3);
END;
/

BEGIN
    ADD_PRODUCTS(9, 'Computers', 'holographic keyboard', 'tracks virtual key presses', 30, 6);
END;
/
BEGIN
    UPDATE prod_category SET categ_descript = 'related to electronics' WHERE category_name = 'Electronics';
    UPDATE prod_category SET categ_descript = 'gadgets related to computers' WHERE category_name = 'Computers';
    UPDATE prod_category SET categ_descript = 'related to comfort' WHERE category_name = 'Furniture';
END;
/

BEGIN
    ADD_person(1, '7745197610', 'AChirra@clarku.edu', '600 main st', 'Adharsh');
END;
/
BEGIN
    ADD_person(2, '7749945426', 'PWyner@clarku.edu', '600 main st', 'Peter', 'Wyner');
END;
/
BEGIN
    ADD_person(3, '7749945326', 'RJulia@clarku.edu', '600 main st', 'Julia', 'Roberts');
END;
/
BEGIN
    ADD_person(4, '7749946326', 'RAlex@clarku.edu', '340 main st', 'Alex', 'Roberts');
END;
/
BEGIN
    ADD_person(5, '7749946316', 'RKatie@clarku.edu', '345 main st', 'Katie', 'Roberts');
END;
/
BEGIN
    ADD_person(6, '7749946315', 'Rjhon@clarku.edu', '15 main st', 'Jhon', 'Roberts');
END;
/
BEGIN
    ADD_person(7, '7749946338', 'jmaverick@clarku.edu', '10 main st', 'Maverick', 'J');
END;
/
BEGIN
    ADD_person(8, '7749946356', 'ctom@clarku.edu', '36 main st', 'Tom', 'Cruise');
END;
/
BEGIN
    ADD_person(9, '7749946389', 'mtobey@clarku.edu', '79 gem st', 'Tobey', 'Maguire');
END;
/
BEGIN
    ADD_person(10, '7749946320', 'jdwayne@clarku.edu', '10 gem st', 'Dwayne', 'Johnson');
END;
/

BEGIN
    ADD_seller(1, 'Adharsh', 5);
END;
/

BEGIN
    ADD_seller(2, 'PW', 5);
END;
/

BEGIN
    ADD_seller(3, 'RJ', 4);
END;
/

BEGIN
    ADD_buyer(1, 'prime');
END;
/

BEGIN
    ADD_buyer(2, 'prime');
END;
/

BEGIN
    ADD_buyer(3, 'prime');
END;
/

BEGIN
    ADD_buyer(4, '');
END;
/

BEGIN
    ADD_buyer(5, '');
END;
/

BEGIN
    ADD_buyer(6, '');
END;
/

BEGIN
    ADD_buyer(7, 'prime');
END;
/

BEGIN
    ADD_buyer(8, 'prime');
END;
/

BEGIN
    ADD_buyer(9, '');
END;
/

BEGIN
    ADD_buyer(10, 'prime');
END;
/

BEGIN
    ADD_inventory(1, 9, 7);
END;
/
BEGIN
    ADD_inventory(2, 5, 6);
END;
/
BEGIN
    ADD_inventory(1, 8, 5);
END;
/

BEGIN
    ADD_SHIPPING(0, 'not shipped', '');
END;
/

BEGIN
    ADD_SHIPPING(1, 'shipping confirmed', 'DHL');
END;
/

BEGIN
    ADD_SHIPPING(2, 'shipping confirmed', 'UPS');
END;
/

BEGIN
    ADD_SHIPPING(3, 'in process', 'DHL');
END;
/


BEGIN
    ADD_orders(1, 1, 0, 'order confirmed');
END;
/
BEGIN
    ADD_orders(2, 4, 2, 'shipped');
END;
/
BEGIN
    ADD_orders(3, 2, 0, 'order confirmed');
END;
/
BEGIN
    ADD_orders(4, 6, 3, 'shipping');
END;
/
BEGIN
    ADD_orders(5, 3, 2, 'shipping');
END;
/
BEGIN
    ADD_orders(6, 5, 3, 'shipping');
END;
/
BEGIN
    ADD_orders(7, 10, 0, 'order confirmed');
END;
/
BEGIN
    ADD_orders(8, 7, 0, 'order confirmed');
END;
/
BEGIN
    ADD_orders(9, 9, 1, 'shipping');
END;
/
BEGIN
    ADD_orders(10, 8, 2, 'shipping');
END;
/


BEGIN
    ADD_orders_list(1, 8, 1);
END;
/
BEGIN
    ADD_orders_list(2, 2, 1);
END;
/

BEGIN
    ADD_orders_list(2, 5, 2);
END;
/
BEGIN
    ADD_orders_list(2, 1, 5);
END;
/
BEGIN
    ADD_orders_list(3, 9, 3);
END;
/
BEGIN
    ADD_orders_list(4, 9, 1);
END;
/
BEGIN
    ADD_orders_list(5, 2, 1);
END;
/
BEGIN
    ADD_orders_list(5, 9, 2);
END;
/
BEGIN
    ADD_orders_list(6, 2, 1);
END;
/
BEGIN
    ADD_orders_list(6, 8, 2);
END;
/
BEGIN
    ADD_orders_list(7, 3, 1);
END;
/
BEGIN
    ADD_orders_list(8, 4, 3);
END;
/
BEGIN
    ADD_orders_list(8, 6, 1);
END;
/

BEGIN
    ADD_orders_list(9, 5, 7);
END;
/
BEGIN
    ADD_orders_list(10, 7, 1);
END;
/
BEGIN
    ADD_returns(1, 1, 5, 'poor performance', 'approved');
END;
/
BEGIN
    ADD_returns(2, 3, 4, 'defective product', 'pending');
END;
/
BEGIN
    ADD_returns(3, 5, 2, 'wrong item received', 'approved');
END;
/


BEGIN
    ADD_customer_service(1, 2, 'missing items', 'mouse pad missing in the package delivered', 'waiting for approval');
END;
/
BEGIN
    ADD_customer_service(2, 3, 'damaged product', 'product arrived with visible damages', 'in process');
END;
/
BEGIN
    ADD_customer_service(3, 5, 'return request', 'customer wants to return the product', 'approved');
END;
/
BEGIN
    ADD_customer_service(4, 7, 'refund request', 'customer requests a refund for the order', 'pending');
END;
/





UPDATED VALUES INSERTING:

CREATE OR REPLACE PROCEDURE update_person(
    person_id_arg IN DECIMAL,
    firstname_arg IN VARCHAR,
    lastname_arg IN VARCHAR)
IS
BEGIN
    UPDATE person
    SET firstname = firstname_arg,
        lastname = lastname_arg
    WHERE person_id = person_id_arg;
END;
/

BEGIN
    update_person(1, 'Adharsh', 'Chirra');
END;
/
BEGIN
    update_person(2, 'Peter', 'Wyner');
END;
/
BEGIN
    update_person(3, 'Julia', 'Roberts');
END;
/
BEGIN
    update_person(4, 'Alex', 'Roberts');
END;
/
BEGIN
    update_person(5, 'Katie', 'Roberts');
END;
/
BEGIN
    update_person(6, 'Jhon', 'Roberts');
END;
/
BEGIN
    update_person(7, 'Maverick', 'J');
END;
/
BEGIN
    update_person(8, 'Tom', 'Cruise');
END;
/
BEGIN
    update_person(9, 'Tobey', 'Maguire');
END;
/
BEGIN
    update_person(10, 'Dwayne', 'Johnson');
END;
/






Aspect-1:
Get those 'Computers' or 'Electronics' goods that cost less than thirty.


SELECT * FROM PRODUCTS
WHERE PRICE < 30 AND (CATEGORY_NAME='Computers' or CATEGORY_NAME='Electronics');



Aspect-2:
When the number of products in the inventory is <=  to  11, retrieve the names of those products.


SELECT prod_name FROM products
JOIN inventory ON products.product_id = inventory.product_id AND inventory.product_count <= 11;



Aspect-3:
Using the person table, extract last names & the number of occurrences. Sort by last name and remove entries with a count higher than three.


SELECT LASTNAME, COUNT(*) FROM PERSON
GROUP BY LASTNAME
HAVING COUNT(*) > 3;



Aspect-4:
Getting the address, first and last names, & person ID for purchases containing three or more goods.


SELECT orders.person_id, person.firstname, person.lastname, person.address
FROM orders
INNER JOIN person ON orders.person_id = person.person_id
WHERE order_id IN (
    SELECT order_id FROM orders_list
    WHERE product_id IN (
        SELECT product_id FROM orders_list
        GROUP BY product_id
        HAVING COUNT(*) >= 3
    )
);



Aspect-5:
Obtain shipping details about orders placed by customers with Prime Membership.


SELECT shipping_id, status, service_provider FROM shipping
WHERE shipping_id IN (
    SELECT shipping_id FROM orders
    WHERE person_id IN (
        SELECT person_id FROM buyer
        WHERE subscription = 'prime'
    )
);




INDEX CREATION:

CREATE INDEX idx_username ON person(username);

