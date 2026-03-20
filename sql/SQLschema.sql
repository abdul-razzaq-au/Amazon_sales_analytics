-- create transactions table
create table transactions (
			transaction_id varchar(50),
			customer_id varchar(50),
			product_id varchar(50),
			order_date date,
			order_year integer,
			original_price float,
			discount percentage float,
			discounted_price float,
			quantity integer,
			subtotal float,
			delivery_charge float,
			finaLamount float,
			payment_method varchar(50),
			delivery_type varchar(50),
			delivery_days integer,
			is_festivalsale boolean,
			festivaLname varchar(100)
			customer_rating float,
			return_status varchar(20),
);

CREATE INDEX idx_transactions_date ON transactions(order_date);
CREATE INDEX idx_transactions_customer ON transactions(customer_id);
CREATE INDEX idx_transactions_product ON transactions(product_id);

-- create products table
create table if not exists products (
			product_id VARCHAR(50),
			product_name text,
			category VARCHAR(100),
			subcategory VARCHAR(100),
			brand VARCHAR(100),
			base_price float,
			rating float,
			is_primeeligible boolean,
			launch_year integer,
			model VARCHAR(100),
			weight_kg float,	
);
CREATE INDEX idx_products_category ON products(category);

-- create customers table
create table if not exists customers (
            customer_id varchar(50) primary key,
            customer_city VARCHAR(100),
            customer_state VARCHAR(100),
            customer_tier VARCHAR(50),
            customer_spending_tier VARCHAR(50),
            customer_age_group VARCHAR(50),
            is_prime_member BOOLEAN
            );
CREATE INDEX idx_customers_city ON customers(customer_city);
CREATE INDEX idx_customers_segment ON customers(customer_segment);

-- create time dimension tabele
create table if not exists time_dimension (
			order_date date,
			order_month int,
			order_quarter int,
			order_year int
);

-- Load Data
-- in transactions table
COPY transactions
FROM 'D:\Guvi\Projects\Amazon India- A Decade of Sales Analytics\transactions.csv'
DELIMITER ','
CSV HEADER;

-- in products table
COPY products
FROM 'D:\Guvi\Projects\Amazon India- A Decade of Sales Analytics\products.csv'
DELIMITER ','
CSV HEADER;

-- in customers table
COPY customers
FROM 'D:\Guvi\Projects\Amazon India- A Decade of Sales Analytics\customers.csv'
DELIMITER ','
CSV HEADER;

-- in time dimension table
COPY time_dimension
FROM 'D:\Guvi\Projects\Amazon India- A Decade of Sales Analytics\time_dimension.csv'
DELIMITER ','
CSV HEADER;

-- foreign key implementation
ALTER TABLE transactions
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_date
FOREIGN KEY (order_date)
REFERENCES time_dimension(order_date);