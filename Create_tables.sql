use shop;

CREATE TABLE Users
(
	id BIGINT PRIMARY KEY IDENTITY NOT NULL,
	username varchar(150) NOT NULL,
	pssword varchar(128) NOT NULL,
	first_name varchar(150) NOT NULL,
	last_name varchar(150) NOT NULL,
	email varchar(254) NOT NULL,
	is_superuser BIT NOT NULL
);

CREATE TABLE Customer
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	phone varchar(20) NULL, 
	"address" varchar(255) NULL,
	user_id BIGINT NOT NULL,
	FOREIGN KEY (user_id)  REFERENCES Users(id)
); 

CREATE TABLE Cart
 (
	id BIGINT NOT NULL PRIMARY KEY IDENTITY,
	owner_id BIGINT,
	total_products integer NOT NULL, 
	in_order BIT NOT NULL, 
	for_anonymous_user BIT NOT NULL
	FOREIGN KEY (owner_id)  REFERENCES Customer(id)
); 

CREATE TABLE Category
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY,
 	name varchar(255) NOT NULL, 
	slug varchar(50) NOT NULL UNIQUE
); 


CREATE TABLE Smartphone 
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	title varchar(255) NOT NULL, 
	slug varchar(50) NOT NULL UNIQUE, 
	"image" varchar(100) NOT NULL, 
	"description" varchar(255) NULL, 
	price numeric(9, 2) NOT NULL, 
	diagonal varchar(255) NOT NULL, 
	display_type varchar(255) NOT NULL,		
	resolution varchar(255) NOT NULL, 
	accum_volume varchar(255) NOT NULL,
	ram varchar(255) NOT NULL, 
	sd BIT NOT NULL, 
	sd_volume_max varchar(255) NULL, 
	main_cam_mp varchar(255) NOT NULL, 
	frontal_cam_mp varchar(255) NOT NULL, 
	category_id bigint NOT NULL,
	FOREIGN KEY (category_id)  REFERENCES Category(id)
); 

CREATE TABLE "Order"
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	first_name varchar(255) NOT NULL, 
	last_name varchar(255) NOT NULL, 
	phone varchar(20) NOT NULL, 
	"address" varchar(1024) NULL, 
	"status" varchar(100) NOT NULL, 
	buying_type varchar(100) NOT NULL, 
	comment varchar(254) NULL, 
	created_at datetimeoffset NOT NULL, 
	order_date date NOT NULL, 
	cart_id bigint NULL, 
	customer_id bigint NOT NULL,
	FOREIGN KEY (cart_id) REFERENCES Cart(id),
	FOREIGN KEY (customer_id)  REFERENCES Customer(id)
); 

CREATE TABLE Notebook 
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	title varchar(255) NOT NULL, 
	slug varchar(50) NOT NULL UNIQUE, 
	"image" varchar(100) NOT NULL, 
	"description" varchar(255) NULL, 
	price numeric(9, 2) NOT NULL, 
	diagonal varchar(255) NOT NULL, 
	display_type varchar(255) NOT NULL, 
	processor_freq varchar(255) NOT NULL, 
	ram varchar(255) NOT NULL, 
	rom varchar(255) NOT NULL, 
	video varchar(255) NOT NULL, 
	time_without_charge varchar(255) NOT NULL, 
	category_id bigint NOT NULL
	CONSTRAINT fk_product_to_category FOREIGN KEY (category_id)  REFERENCES Category(id),
); 

CREATE TABLE Changelog
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	changed datetimeoffset NOT NULL, 
	model varchar(255) NULL, 
	action_on_model varchar(50) NULL, 
	"data" varchar(255) NOT NULL, 
	ipaddress varchar(15) NULL, 
	user_id BIGINT NULL,
	FOREIGN KEY (user_id) REFERENCES Users(id)
); 

CREATE TABLE Product
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	title varchar(255) NOT NULL,
	notebook_id BIGINT NULL,
	smartphone_id BIGINT NULL,
	FOREIGN KEY (notebook_id) REFERENCES Notebook(id),
	FOREIGN KEY (smartphone_id) REFERENCES Smartphone(id)
);

CREATE TABLE Cartproduct
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	qty integer NOT NULL CHECK ("qty" >= 0),
	total_price numeric(9, 2) NOT NULL, 
	cart_id bigint NOT NULL, 
	user_id bigint NOT NULL,
	object_id integer NOT NULL CHECK (object_id >= 0), 
	product_id BIGINT,
	FOREIGN KEY (cart_id) REFERENCES Cart(id),
	FOREIGN KEY (user_id) REFERENCES Customer(id),
	FOREIGN KEY (product_id) REFERENCES Product(id)
); 


CREATE TABLE Cart_Products 
(
	id BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	cart_id BIGINT NOT NULL, 
	cartproduct_id BIGINT NOT NULL,
	FOREIGN KEY (cart_id) REFERENCES Cart(id),
	FOREIGN KEY (cartproduct_id) REFERENCES Cartproduct(id)
); 
