use shop

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

INSERT Changelog
Values
(CAST('2021-11-28 20:11:12. 375417 +03:00' AS datetimeoffset(7)), 'Order', 'update',
'{"id": 1, "phone": "+375292337741", "address": "Minsk", "comment": "First order", "last_name": "Зорко", "created_at": "2021-11-28T17:11:12.374406 +00:00", "first_name": "Полина", "order_date": "datetime.date(2021, 11, 30)"}',
'127.0.0.1', 1),
(CAST('2021-11-28 20:11:12. 379859 +03:00' AS datetimeoffset(7)), 'Cart', 'update', '{"in_order": true}', '127.0.0.1', 1),
(CAST('2021-11-28 20:11:12. 381686 +03:00' AS datetimeoffset(7)), 'Order', 'update', 
'{"id": 1, "cart": "<Cart: 1>", "phone": "+375292337741", "address": "Minsk", "comment": "First order", "last_name": "Зорко", "created_at": "2021-11-28T17:11:12. 380466 +00:00", "first_name": "Полина", "order_date": "datetime.date(2021, 11, 30)"}',
'127.0.0.1', 1),(CAST('2021-11-28 20:11:12. 4295 +03:00' AS datetimeoffset(7)), 'Cart', 'create', '{"id": 2}', '127.0.0.1', 1);SELECT Changelog.id,	   changed,	   model,	   "data",	   ipaddress,	   Users.first_name + ' ' + Users.last_name as 'user that create change'FROM Changelog LEFT JOIN Users ON Users.id=user_id;