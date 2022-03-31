use shop

SELECT id,
	   owner_id,
	   total_products,
	   in_order,
       for_anonymous_user
FROM Cart;

SELECT Cart.id,
	   Users.first_name,
	   total_products,
	   in_order,
       for_anonymous_user
FROM Cart 
	LEFT JOIN Customer
		ON owner_id=Customer.id 
	LEFT JOIN Users 
		ON Customer.user_id=Users.id;

SELECT Cart.id as 'Id Корзины',
      Product.title as 'Товар в корзине',
	  Users.first_name as 'Покупатель'
FROM Cart_Products 
	INNER JOIN Cart 
		ON Cart_Products.cart_id=Cart.id 
	LEFT JOIN Customer
		ON owner_id=Customer.id
	LEFT JOIN Users 
		ON Customer.user_id=Users.id
	INNER JOIN Cartproduct 
		ON Cart_Products.cartproduct_id=Cartproduct.id 
	LEFT JOIN Product
		ON Cartproduct.product_id=Product.id;

SELECT id,
	   qty,
	   total_price,
	   cart_id,
	   object_id,
	   product_id
FROM Cartproduct;

SELECT Cartproduct.id,
	   qty,
	   total_price,
	   cart_id,
	   object_id,
	   Product.title
FROM Cartproduct 
	LEFT JOIN Product 
		ON product_id=Product.id;

SELECT id, 
	   "name",
	   slug
FROM Category;

SELECT id, 
       phone,
	   "address",
	   user_id
FROM Customer;

SELECT Customer.id, 
       phone,
	   "address",
	   Users.first_name,
	   Users.last_name
FROM Customer 
	LEFT JOIN Users 
		ON user_id=Users.id;

SELECT Notebook.id, 
	   Category."name" as category,
       title, 
	   Notebook.slug,
	   "image", 
	   "description",
	   price,
	   diagonal,
	   display_type,
	   processor_freq,
	   ram,
	   rom,
	   video,
	   time_without_charge
FROM Notebook 
	LEFT JOIN Category
		ON category_id=Category.id;

SELECT Smartphone.id, 
	   Category."name" as category,
       title, 
	   Smartphone.slug,
	   "image", 
	   "description",
	   price,
	   diagonal,
	   display_type,
	   resolution,
       accum_volume,
       ram,
	   sd,
	   ISNULL(sd_volume_max, 'Not supported'),
       main_cam_mp,
       frontal_cam_mp
FROM Smartphone 
	LEFT JOIN Category 
		ON category_id=Category.id;

SELECT Product.id,
	   Product.title, 
	   ISNULL(Notebook.title, '-') as notebook,
	   ISNULL(Smartphone.title, '-') as smartphone
FROM Product 
	LEFT JOIN Notebook
		ON notebook_id=Notebook.id 
	LEFT JOIN Smartphone 
		ON smartphone_id=Smartphone.id;

SELECT id,
	   username,
	   first_name,
	   last_name,
	   email,
	   is_superuser
FROM Users;

SELECT "Order".id, 
	   "Order".first_name,
	   "Order".last_name,
	   "Order".phone,
	   "Order"."address",
	   "status",
	   buying_type,
	   comment,
	  created_at,
	  order_date,
	  Cart.id,
	  Users.first_name + ' ' + Users.last_name as customer
FROM "Order" 
	LEFT JOIN Cart 
		ON Cart.id=cart_id
	LEFT JOIN Customer 
		ON Customer.id=customer_id
	LEFT JOIN Users
		ON Users.id=user_id;
