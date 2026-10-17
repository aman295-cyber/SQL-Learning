create table products(
Product_ID serial primary key,
name varchar(50) not null,
sku_code char(8) unique not null check (char_length(sku_code)=8),
Price bigint default 0 check (Price <=99999999),
Stock_Quality int check(Stock_Quality >=0),
Is_available boolean default TRUE,
Category text not null,
Added_On Date default current_date,
Last_update Timestamp default now()
);

insert into products(name,sku_code,Price,Stock_Quality,Is_available,Category)
values
('Wireless Mouse', 'WM123456', 699.99, 50, TRUE, 'Electronics'),
('Bluetooth Speaker', 'BS234567', 1499.00, 30, TRUE, 'Electronics'),
('Laptop Stand', 'LS345678', 799.50, 20, TRUE, 'Accessories'),
('USB-C Hub', 'UC456789', 1299.99, 15, TRUE, 'Accessories'),
('Notebook', 'NB567890', 99.99, 100, TRUE, 'Stationery'),
('Pen Set', 'PS678901', 199.00, 200, TRUE, 'Stationery'),
('Coffee Mug', 'CM789012', 299.00, 75, TRUE, 'Home & Kitchen'),
('LED Desk Lamp', 'DL890123', 899.00, 40, TRUE, 'Home & Kitchen'),
('Yoga Mat', 'YM901234', 499.00, 25, TRUE, 'Fitness'),
('Water Bottle', 'WB012345', 349.00, 60, TRUE, 'Fitness');


select * from products;
