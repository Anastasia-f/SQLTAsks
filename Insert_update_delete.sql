use shop
GO
-------------------------------------Insert
INSERT INTO Category(name, slug) 
Values
('Ноутбуки', 'notebooks'),
('Смартфоны', 'smartphones');

INSERT Notebook
Values
('Macbook Pro 14', 'macbook_pro_14', 'macboor-pro-14.jpg', '', 3178, '14 дюймов', 'IPS  (Liquid Retina XDR mini-LED)', '2.0 ГГц', '16 ГБ', '512 ГБ', 'Apple M1 Pro GPU (14 ядер)', '11 часов  (работы в интернете по беспроводной сети)', (Select id from Category Where slug='notebooks')),
('Macbook Air 13', 'macbook_air_13', 'macboor-air-13.jpg', '', 1454, '13 дюймов', 'IPS', '3.2 ГГц', '8 ГБ', '256 ГБ', 'Apple M1 GPU (7 ядер)', '15 часов - 18 часов', (Select id from Category Where slug='notebooks')),
('Macbook Pro 13', 'macbook_pro_13', 'macboor-pro-13.jpg', '', 1316, '13 дюймов', 'IPS', '3.2 ГГц', '8 ГБ', '256 ГБ', 'Apple M1 GPU (8 ядер)', '17 часов - 20 часов', (Select id from Category Where slug='notebooks'));

INSERT Smartphone
Values
('iPhone 11', 'iphone_11', 'iphone-11.jpg', '', 668, '6.1"', 'IPS', '828x1792', '3046 мАч', '4 ГБ', 0, null, '12 Мп', '12 Мп', (Select id from Category Where slug='smartphones')),
('iPhone 12', 'iphone_12', 'iphone-12.jpg', '', 927, '6.1"', 'OLED', '1170x2532', '2815 мАч', '4 ГБ', 0, null, '12 Мп', '12 Мп', (Select id from Category Where slug='smartphones')),
('iPhone 13', 'iphone_13', 'iphone-13.jpg', '', 1053, '6.1"', 'OLED', '1170x2532', '-', '4 ГБ', 0, null, '12 Мп', '12 Мп', (Select id from Category Where slug='smartphones'));

INSERT Users
Values
('polina_zorko', 'polina68422486', 'Полина', 'Зорко', 'polina.zorko@mail.ru', 0),
('admin', 'admin', 'admin', 'admin', 'admin@admin.com', 1);

INSERT Customer
Values
('+375291234567', 'Minsk', (Select id from Users Where email='polina.zorko@mail.ru'));

INSERT Cart
Values
((SELECT id from Customer WHERE id=(SELECT id from Users WHERE username='polina_zorko')), 0, 0, 0);

INSERT Product
Values
('Macbook Pro 14', (SELECT id from Notebook where slug='macbook_pro_14'), null),
('iPhone 13', null, (SELECT id from Smartphone where slug='iphone_13'));

INSERT Cartproduct
Values
(1, (SELECT price from Notebook where slug='macbook_pro_14'), 1, 1, 1, (SELECT id from Product where title='Macbook Pro 14')),
(1, (SELECT price from Smartphone where slug='iphone_13'), 1, 1, 1, (SELECT id from Product where title='iPhone 13'));

INSERT Cart_Products
Values
(1, 1),
(1, 2);

INSERT "Order"
Values
((SELECT Users.first_name FROM Customer LEFT JOIN Users ON user_id=Users.id), 
 (SELECT Users.last_name FROM Customer LEFT JOIN Users ON user_id=Users.id), 
 (SELECT phone FROM Customer), 
 (SELECT "address" FROM Customer), 
 'new',
 'self',
 'new order',   
 CAST('2021-11-28 13:30:55. 984014 +03:00' AS datetimeoffset(7)),
 CAST('2021-12-19' AS date),
 (SELECT TOP (1) id from Cart),
 (SELECT TOP (1) id from Customer));

-------------------------------------Update

UPDATE Smartphone
SET title = 'Apple ' + title;

UPDATE Notebook
SET processor_freq = '3.2 ГГц'
WHERE slug='macbook_pro_14';

UPDATE Notebook
SET "description"='Новый Macbook';

UPDATE Notebook
SET "description" = "description" + ' Pro 2020'
WHERE slug='macbook_pro_14';

UPDATE Notebook
SET "description" = "description" + ' 2020'
WHERE slug='macbook_air_13';

UPDATE Notebook
SET "description" = description + ' Pro 2019'
WHERE slug='macbook_pro_13';

UPDATE Smartphone
SET "description"='iPhone';

UPDATE Smartphone
SET "description" = "description" + ' 2021'
WHERE slug='iphone_13';

UPDATE Smartphone
SET "description" = "description" + ' 2020'
WHERE slug='iphone_12';

UPDATE Smartphone
SET "description" = "description" + ' 2020'
WHERE slug='iphone_11';

-------------------------------------Delete
INSERT Smartphone
VALUES
('Xiaomi mi9', 'xiaomi_mi_9', 'xiaomi-mi-9.jpg', '', 470, '6.39"', 'AMOLED', '1080x2340', '3300 мАч', '6 ГБ', 0, null, '48 Мп', '48 Мп', (Select id from Category Where slug='smartphones'));

DELETE Smartphone
WHERE slug='xiaomi_mi_9';

INSERT Users
Values
('tested_user', '1234567890', 'User', 'Tested', 'testedo@mail.ru', 0);

INSERT Customer
Values
('+375291234507', 'Minsk', (Select id from Users Where username='tested_user'));

DELETE Customer
WHERE user_id=(Select id from Users Where username='tested_user');

DELETE Users
WHERE username='tested_user';

INSERT Product
Values
('Xiaomi mi9', null, (SELECT id from Smartphone where slug='xiaomi_mi_9'));

INSERT Cartproduct
Values
(1, (SELECT price from Smartphone where slug='xiaomi_mi_9'), 1, 1, 1, (SELECT id from Product where title='Xiaomi mi9'));

DELETE Cartproduct
WHERE product_id=(SELECT id from Product where title='Xiaomi mi9');

DELETE Product 
WHERE smartphone_id=(SELECT id from Smartphone where slug='xiaomi_mi_9');

DELETE Changelog;