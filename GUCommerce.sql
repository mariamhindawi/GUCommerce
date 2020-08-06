--Creating Database



create database GUCommerce

--Creating Tables

create table Users(
username varchar(20),
[password] varchar(20),
first_name varchar(20),
last_name varchar(20),
email varchar(50),
constraint pk_Users primary key(username)
)

create table User_mobile_numbers(
mobile_number varchar(20),
username varchar(20),
constraint pk_User_mobile_numbers primary key(mobile_number,username),
constraint fk_User_mobile_numbers foreign key(username) references Users on delete cascade on update cascade
)

create table User_Addresses(
[address] varchar(100),
username varchar(20),
constraint pk_User_Addresses primary key(address,username),
constraint fk_User_Addresses foreign key(username) references Users on delete cascade on update cascade
)

create table Customer(
username varchar(20),
points int,
constraint pk_Customer primary key(username),
constraint fk_Customer foreign key(username) references Users on delete cascade on update cascade
)

create table Admins(
username varchar(20),
constraint pk_Admins primary key(username),
constraint fk_Admins foreign key(username) references Users on delete cascade on update cascade
)

create table Vendor(
username varchar(20),
activated bit,
company_name varchar(20),
bank_acc_no varchar(20),
admin_username varchar(20),
constraint pk_Vendor primary key(username),
constraint fk_Vendor_Users foreign key(username) references Users on delete cascade on update cascade,
constraint fk_Vendor_Admins foreign key(admin_username) references Admins on delete no action on update no action --set null,cascade
)

create table Delivery_Person(
username varchar(20),
is_activated bit,
constraint pk_Delivery_Person primary key(username),
constraint fk_Delivery_Person foreign key(username) references Users on delete cascade on update cascade
)

create table Credit_Card(
number varchar(20),
[expiry_date] datetime,
cvv_code varchar(4), --cvc?
constraint pk_Credit_Card primary key(number)
)

create table Delivery(
id int identity,
[type] varchar(20),
time_duration int,
fees decimal(5,3),
username varchar(20),
constraint pk_Delivery primary key(id),
constraint fk_Delivery foreign key(username) references Admins on delete set null on update cascade
)

create table Giftcard(
code varchar(10),
[expiry_date] datetime,
amount int,
username varchar(20),
constraint pk_Giftcard primary key(code),
constraint fk_Giftcard foreign key(username) references Admins on delete set null on update cascade
)

--Create after gift card
create table Orders(
order_no int identity,
order_date datetime,
total_amount decimal(10,2),
cash_amount decimal(10,2),
credit_amount decimal(10,2),
payment_type varchar(20),
order_status varchar(20),
remaining_days int,
time_limit datetime,
Gift_Card_code_used varchar(10),
customer_name varchar(20),
delivery_id int,
creditCard_number varchar(20),
constraint pk_Orders primary key(order_no),
constraint fk_Orders_Customer foreign key(customer_name) references Customer on delete cascade on update cascade,
constraint fk_Orders_Delivery foreign key(delivery_id) references Delivery on delete no action on update no action, --set null,cascade
constraint fk_Orders_Credit_Card foreign key(creditCard_number) references Credit_Card on delete set null on update cascade,
constraint fk_Orders_Gift_Card foreign key(Gift_Card_code_used) references Giftcard on delete no action on update no action --set null,cascade
)

create table Product(
serial_no int identity,
product_name varchar(20),
category varchar(20),
product_description text,
price decimal(10,2),
final_price decimal(10,2),
color varchar(20),
available bit,
rate int,
vendor_username varchar(20),
customer_username varchar(20),
customer_order_id int,
constraint pk_Product primary key(serial_no),
constraint fk_Product_Vendor foreign key(vendor_username) references Vendor on delete cascade on update cascade,
constraint fk_Product_Orders foreign key(customer_order_id) references Orders on delete no action on update no action, --set null,cascade
constraint fk_Product_Customer foreign key(customer_username) references Customer on delete no action on update no action, --set null,cascade
)

create table CustomerAddstoCartProduct(
serial_no int,
customer_name varchar(20),
constraint pk_CustomerAddstoCartProduct primary key(serial_no,customer_name),
constraint fk_CustomerAddstoCartProduct_Product foreign key(serial_no) references Product on delete cascade on update cascade,
constraint fk_CustomerAddstoCartProduct_Customer foreign key(customer_name) references Customer on delete no action on update no action --cascade,cascade
)

create table Todays_Deals(
deal_id int identity,
deal_amount int,
expiry_date datetime,
admin_username varchar(20),
constraint pk_Todays_Deals Primary key(deal_id),
constraint fk_Todays_Deals foreign key(admin_username) references admins on delete set null on update cascade
)

create table Todays_Deals_Product(
deal_id int ,
serial_no int,
constraint pk_Todays_Deals_Product Primary key(deal_id,serial_no),
constraint fk_Todays_Deals_Product_Todays_Deal foreign key(deal_id) references Todays_Deals on delete cascade on update cascade,
constraint fk_Todays_Deals_Product_Product foreign key(serial_no) references Product on delete no action on update no action --cascade,cascade
)

create table Offer(
offer_id int identity,
offer_amount int,
expiry_date datetime,
constraint pk_Offer primary key(offer_id)
)

create table offersOnProduct(
offer_id int,
serial_no int,
constraint pk_offersOnProduct primary key(offer_id,serial_no),
constraint fk_offersOnProduct_Offer foreign key(offer_id) references Offer on delete cascade on update cascade,
constraint fk_offersOnProduct_Product foreign key(serial_no) references Product on delete cascade on update cascade
)

create table Customer_Question_Product(
serial_no int,
customer_name varchar(20),
question varchar(50),
answer text,
constraint pk_Customer_Question_Product primary key(serial_no,customer_name),
constraint fk_Customer_Question_Product_Product foreign key(serial_no) references Product on delete cascade on update cascade,
constraint fk_Customer_Question_Product_Customer foreign key(customer_name) references Customer on delete no action on update no action, --cascade,cascade
)

create table Wishlist(
username varchar(20),
name varchar(20),
constraint pk_Wishlist primary key(username,name),
constraint fk_Wishlist foreign key(username) references Customer on delete cascade on update cascade,
)

create table Wishlist_Products(
username varchar(20),
wish_name varchar(20),
serial_no int,
constraint pk_Wishlist_Products primary key(username,wish_name,serial_no),
constraint fk_Wishlist_Products_Wishlist foreign key(username,wish_name) references Wishlist on delete cascade on update cascade,
constraint fk_Wishlist_Products_Product foreign key(serial_no) references Product on delete no action on update no action --cascade,cascade
)

create table Admin_Customer_Giftcard(
code varchar(10),
customer_name varchar(20),
admin_username varchar(20),
remaining_points int,
constraint pk_Admin_Customer_Giftcard primary key(code,customer_name,admin_username),
constraint fk_Admin_Customer_Giftcard_Giftcard foreign key(code) references Giftcard on delete cascade on update cascade,
constraint fk_Admin_Customer_Giftcard_Customer foreign key(customer_name) references Customer on delete no action on update no action, --cascade,cascade
constraint fk_Admin_Customer_Giftcard_Admins foreign key(admin_username) references Admins on delete no action on update no action --cascade,cascade
)

create table Admin_Delivery_Order(
delivery_username varchar(20),
order_no int,
admin_username varchar(20),
delivery_window varchar(50),
constraint pk_Admin_Delivery_Order primary key(delivery_username,order_no),
constraint fk_Admin_Delivery_Order_Delivery_Person foreign key(delivery_username) references Delivery_Person on delete cascade on update cascade,
constraint fk_Admin_Delivery_Order_Orders foreign key(order_no) references Orders on delete no action on update no action, --cascade,cascade
constraint fk_Admin_Delivery_Order_Admins foreign key(admin_username) references Admins on delete no action on update no action --cascade,cascade
)

create table Customer_CreditCard(
customer_name varchar(20),
cc_number varchar(20),
constraint pk_Customer_CreditCard primary key(customer_name,cc_number),
constraint fk_Customer_CreditCard_Customer foreign key(customer_name) references customer on delete cascade on update cascade,
constraint fk_Customer_CreditCard_Credit_Card foreign key(cc_number) references Credit_Card on delete cascade on update cascade
)



--Creating Procedures

--Unregistered User

--a)
--customerRegister
go
create or alter proc customerRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar (20),
@password varchar(20),
@email varchar(50)
as

insert into Users (username,password,first_name,last_name,email)
values (@username,@password,@first_name,@last_name,@email);
insert into Customer values (@username,0);

--test
go
exec customerRegister 'ahmed.ashraf','ahmed','ashraf','pass123','ahmed@yahoo.com'


--checkUsername
go
create or alter proc checkUsername
@username varchar(20),
@flag bit output
as

if exists
(
select *
from Users
where username = @username
)
begin
set @flag = 1
end
else
begin
set @flag = 0
end


--vendorRegister
go
create proc vendorRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar (20),
@password varchar(20),
@email varchar(50),
@company_name  varchar(20),
@bank_acc_no varchar(20)
as

insert into Users (username,password,first_name,last_name,email) values(@username,@password,@first_name,@last_name,@email);
insert into Vendor(username,company_name,bank_acc_no) values (@username,@company_name,@bank_acc_no);

--test
go
exec vendorRegister 'eslam.mahmod','eslam','mahmod','pass1234','hopa@gmail.com','Market','132132513'


--Registered User

--a)userLogin
go
create proc userLogin
@username varchar(20),
@password varchar(20),
@success bit output,
@type int output
as

if exists
(select *
from Users
where username=@username and password=@password)
begin
set @success = 1
end
else
begin
set @success = 0
end

if (@success=1)
begin
if exists
(select *
from Customer
where username=@username)
begin
set @type = 0
end
else if exists
(select *
from Vendor
where username=@username)
begin
set @type = 1
end
else if exists
(select *
from Admins
where username=@username)
begin
set @type = 2
end
else if exists
(select *
from Delivery_Person
where username=@username)
begin
set @type = 3
end
else
begin
set @type = -1
end
end
else
begin
set @type = -1
end

--test
go
declare @success bit
declare @type int
exec userLogin 'ahmed.ashraf','pass',@success output,@type output
print @success
print @type


--b)addMobile
GO
CREATE PROC addMobile
@username VARCHAR(20),
@mobile_number VARCHAR(20)
AS

INSERT INTO User_mobile_numbers(mobile_number, username)
VALUES(@mobile_number, @username)


--test
go
exec addMobile 'ahmed.ashraf','01111211122'
exec addMobile 'ahmed.ashraf','0124262652'


--checkMobile
go
create or alter proc checkMobile
@username varchar(20),
@mobile_number varchar(20),
@flag bit output
as

if exists
(
select *
from User_mobile_numbers
where username = @username AND mobile_number = @mobile_number
)
begin
set @flag = 1
end
else
begin
set @flag = 0
end


--c)addAddress
go
create proc addAddress
@username varchar(20),
@address varchar(100)
as

insert into User_Addresses
values(@address,@username);

--test
go
exec addAddress 'ahmed.ashraf','nasr city'


--Customer

--a)showProducts
go
create proc showProducts
as

select product_name,product_description,price,final_price,color
from Product
where available = 1

--test
go
exec showProducts


--b)ShowProductsbyPrice
go
create or alter proc ShowProductsbyPrice
as

select serial_no, product_name, product_description, price, color
from Product
where available = 1
order by price asc


--test
go
exec ShowProductsbyPrice


--c)searchbyname
GO
CREATE PROC searchbyname
@text VARCHAR(20)
AS

SELECT product_name,product_description,price,final_price,color
FROM Product
WHERE product_name like '%' + @text + '%'
and available = 1

--test
go
exec searchbyname 'blue'


--d)AddQuestion
go
create proc AddQuestion
@serial int,
@customer varchar(20),
@Question varchar(50)
as

insert into Customer_Question_Product(serial_no,customer_name,question)
values(@serial,@customer,@question);

--test
go
exec AddQuestion 1,'ahmed.ashraf','size?'


--e)
--addToCart
go
create proc addToCart
@customername varchar(20),
@serial int
as

insert into CustomerAddstoCartProduct (serial_no,customer_name)
values (@serial,@customername);

--test
go
exec addToCart 'ahmed.ashraf',1
exec addToCart 'ahmed.ashraf',2


--checkInCart
go
create or alter proc checkInCart
@customername varchar(20),
@serial int,
@flag bit output
as

if exists
(
select *
from CustomerAddstoCartProduct
where customer_name=@customername and serial_no=@serial
)
begin
set @flag = 1
end
else
begin
set @flag = 0
end


--removefromCart
go
create proc removefromCart
@customername varchar(20),
@serial int
as

delete from CustomerAddstoCartProduct 
where serial_no=@serial and customer_name=@customername;

--test
go
exec removefromCart 'ahmed.ashraf',2


--f)createWishlist
go
create proc createWishlist
@customername varchar(20),
@name varchar(20)
as

insert into Wishlist
values (@customername,@name)

--test
go
exec createWishlist 'ahmed.ashraf','fashion'


--checkWishlist
go
create or alter proc checkWishlist
@customername varchar(20),
@wishlistname varchar(20),
@flag bit output
as

if exists
(
select *
from Wishlist
where username=@customername and name=@wishlistname
)
begin
set @flag = 1
end
else
begin
set @flag = 0
end


--g)
--AddtoWishlist
GO
CREATE PROC AddtoWishlist
@customername varchar(20), 
@wishlistname varchar(20), 
@serial int
AS

INSERT INTO Wishlist_Products(username, wish_name, serial_no)
VALUES(@customername, @wishlistname, @serial)

--test
go
exec AddtoWishlist 'ahmed.ashraf','fashion', 1
exec AddtoWishlist 'ahmed.ashraf','fashion', 2


--removefromWishlist
GO
CREATE PROC removefromWishlist 
@customername VARCHAR(20), 
@wishlistname VARCHAR(20), 
@serial INT
AS

DELETE FROM Wishlist_Products
WHERE username=@customername AND wish_name=@wishlistname AND serial_no=@serial

--test
go
exec removefromWishlist 'ahmed.ashraf','fashion', 1


--checkInWishlist
go
create or alter proc checkInWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int,
@flag bit output
as

if exists
(
select *
from Wishlist_Products
where username=@customername and serial_no=@serial and wish_name=@wishlistname
)
begin
set @flag = 1
end
else
begin
set @flag = 0
end



--h)showWishlistProduct
go
create proc showWishlistProduct
@customername varchar(20),
@name varchar(20)
as

select p.product_name, p.product_description, p.price, p.final_price, p.color
from Product p INNER JOIN Wishlist_Products wp
on p.serial_no=wp.serial_no
where wp.username=@customername and wp.wish_name=@name

--test
go
exec showWishlistProduct 'ahmed.ashraf' ,'fashion'


--i)viewMyCart
go
create proc viewMyCart
@customer varchar(20)
as

select p.product_name, p.product_description, p.price, p.final_price, p.color
from Product p Inner join CustomerAddstoCartProduct c on p.serial_no=c.serial_no
where c.customer_name = @customer

--test
go
exec viewMyCart 'ahmed.ashraf'


--j)
--calculatepriceOrder
go
create proc calculatepriceOrder
@customername varchar(20),
@sum decimal(10,2) output
as

set @sum =
(select sum(final_price)
from CustomerAddstoCartProduct c inner join Product p on c.serial_no = p.serial_no
where customer_name = @customername
)

--test
go
declare @sum decimal(10,2)
exec calculatepriceOrder 'ahmed.ashraf', @sum output
print @sum

--productsinorder
go
create proc productsinorder
@customername varchar(20),
@orderID int
as

update Product
set customer_username = @customername , customer_order_id = @orderID , available = 0
where serial_no in
(select c.serial_no
from CustomerAddstoCartProduct c
where c.customer_name = @customername
)

delete from CustomerAddstoCartProduct
where customer_name <> @customername and serial_no in
(select c.serial_no
from CustomerAddstoCartProduct c
where c.customer_name = @customername
)

exec viewMyCart @customername

--emptyCart
go
create proc emptyCart
@customername varchar(20)
as

delete from CustomerAddstoCartProduct
where customer_name = @customername

--test
go
exec emptyCart 'ahmed.ashraf'

--makeOrder
go
create proc makeOrder
@customername varchar(20)
as

declare @total decimal(10,2)
exec calculatepriceOrder @customername, @total output

insert into Orders (order_date,total_amount,customer_name,order_status)
values (CURRENT_TIMESTAMP,@total,@customername,'not processed')

declare @orderID int
set @orderID = (select SCOPE_IDENTITY())

exec productsinorder @customername,@orderID
exec emptyCart @customername

--test
go
exec makeOrder 'ahmed.ashraf'


--k)cancelOrder
GO
CREATE PROC cancelOrder
@orderid INT
AS

DECLARE @status varchar(20)
SELECT @status = order_status
FROM Orders
WHERE order_no = @orderid

IF (@status = 'not processed' OR @status = 'in process')
BEGIN

DECLARE @giftcardcode VARCHAR(10)
SELECT @giftcardcode = Gift_Card_code_used
FROM Orders
WHERE order_no = @orderid

DECLARE @total_amount DECIMAL(10,2)
SELECT @total_amount = total_amount
FROM Orders
WHERE order_no = @orderid

DECLARE @payment_type VARCHAR(20)
SELECT @payment_type = payment_type
FROM Orders
WHERE order_no = @orderid

DECLARE @customer_name VARCHAR(20)
SELECT @customer_name = customer_name
FROM Orders
WHERE order_no = @orderid

DECLARE @partial_amount DECIMAL(10,2)
IF (@payment_type = 'cash')
BEGIN
SELECT @partial_amount = cash_amount
FROM Orders
WHERE order_no = @orderid
END

ELSE
BEGIN
SELECT @partial_amount = credit_amount
FROM Orders
WHERE order_no = @orderid
END

DECLARE @points INT
SET @points = @total_amount - @partial_amount

IF EXISTS(
SELECT *
FROM Giftcard
WHERE code = @giftcardcode and expiry_date>CURRENT_TIMESTAMP
)
BEGIN
UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points + @points
WHERE customer_name = @customer_name

UPDATE Customer
SET points = points + @points
WHERE username = @customer_name
END

UPDATE Product
SET customer_username = null , customer_order_id = null ,rate = null, available = 1
WHERE customer_order_id = @orderid

DELETE FROM Admin_Delivery_Order
WHERE order_no = @orderid

DELETE FROM Orders
WHERE order_no = @orderid
END

ELSE
BEGIN
PRINT 'Cannot cancel order'
END

--test
go
exec cancelOrder 15


--l)returnProduct
go
create proc returnProduct
@serialno int,
@orderid int
as

declare @total_amount decimal(10,2)
select @total_amount = total_amount
from Orders
where order_no = @orderid

declare @price decimal(10,2)
select @price = final_price
from Product
where serial_no = @serialno and customer_order_id = @orderid

declare @paid decimal(10,2)
if ( (select payment_type from Orders where order_no = @orderid) = 'cash' )
begin
select @paid = cash_amount
from Orders
where order_no = @orderid
end
else
begin
select @paid = credit_amount
from Orders
where order_no = @orderid
end

declare @diff_in_points int
set @diff_in_points = @total_amount - @paid

if(@diff_in_points<0)
begin
set @diff_in_points = 0
end

else if(@diff_in_points>@price)
begin
set @diff_in_points = @price
end

declare @giftcard_code varchar(10)
select @giftcard_code = Gift_Card_code_used
from Orders
where order_no = @orderid

declare @customer_name varchar(20)
select @customer_name = customer_name
from Orders
where order_no = @orderid

if (@giftcard_code is not null)
begin

declare @expiry_date datetime
select @expiry_date = expiry_date
from Giftcard
where code = @giftcard_code

if (@expiry_date>CURRENT_TIMESTAMP)
begin

update Admin_Customer_Giftcard
set remaining_points = remaining_points + @diff_in_points
where code = @giftcard_code and customer_name = @customer_name

update Customer
set points = points + @diff_in_points
where username = @customer_name

end

end

update Orders
set total_amount = total_amount - @price
where order_no = @orderid

update Product
set customer_username = null , customer_order_id = null ,rate = null, available = 1
where serial_no = @serialno and customer_order_id = @orderid

--test
go
exec returnProduct 2,16


--m)ShowproductsIbought
go
create proc ShowproductsIbought
@customername varchar(20)
as 

select serial_no, product_name, category, product_description, price, final_price, color
from Product
where Product.customer_username=@customername

--test
go
exec ShowproductsIbought 'ahmed.ashraf'


--n)rate
go
create proc rate
@serialno int,
@rate int,
@customername varchar(20)
as

update Product
set rate = @rate
where serial_no = @serialno and customer_username = @customername

--test
go
exec rate 2,3,'ahmed.ashraf'


--o)SpecifyAmount
GO
CREATE PROC SpecifyAmount
@customername VARCHAR(20), 
@orderID INT, 
@cash DECIMAL(10,2), 
@credit DECIMAL(10,2)
AS

DECLARE @total_amount DECIMAL(10,2)
SELECT @total_amount = o.total_amount
FROM orders o
WHERE o.order_no=@orderid

IF (@cash IS NULL OR @cash = 0)
BEGIN

IF (@credit <> @total_amount)

BEGIN

UPDATE CUSTOMER 
SET points = points - (@total_amount - @credit)
WHERE username = @customername

UPDATE Admin_Customer_Giftcard 
SET remaining_points = remaining_points - (@total_amount - @credit)
where customer_name = @customername

UPDATE ORDERS
SET Gift_Card_code_used = (
SELECT a.code
FROM Admin_Customer_Giftcard a INNER JOIN Giftcard g ON a.code = g.code
WHERE a.customer_name = @customername AND g.expiry_date>CURRENT_TIMESTAMP
)
WHERE order_no =@orderid

END

UPDATE ORDERS
SET credit_amount =@credit , payment_type = 'credit'
WHERE order_no =@orderid

END

ELSE
BEGIN

IF (@cash <> @total_amount)

BEGIN

UPDATE CUSTOMER 
SET points = points -(@total_amount - @cash)
WHERE username = @customername

UPDATE Admin_Customer_Giftcard 
SET remaining_points = remaining_points - (@total_amount - @cash)
where customer_name = @customername

UPDATE ORDERS
SET Gift_Card_code_used = (
SELECT a.code
FROM Admin_Customer_Giftcard a INNER JOIN Giftcard g ON a.code = g.code
WHERE a.customer_name = @customername AND g.expiry_date>CURRENT_TIMESTAMP
)
WHERE order_no =@orderid

END

UPDATE ORDERS
SET cash_amount = @cash , payment_type = 'cash'
WHERE order_no =@orderid

END

--test
go
exec SpecifyAmount 'ahmed.ashraf', 7, null, 10
exec SpecifyAmount 'ahmed.ashraf', 7, 5, null


--p)AddCreditCard
go 
create proc AddCreditCard
@creditcardnumber varchar(20),
@expirydate date,
@cvv varchar(4),
@customername varchar(20)
as

insert into Credit_Card (number,expiry_date,cvv_code) values(@creditcardnumber,@expirydate,@cvv)
insert into Customer_CreditCard(customer_name,cc_number) values (@customername,@creditcardnumber)

--test
go
exec AddCreditCard '4444-5555-6666-8888', '10/19/2028', '232', 'ahmed.ashraf'


--checkCreditCard
go
create proc checkCreditCard
@creditcardnumber varchar(20),
@customername varchar(20),
@flag bit output
as

if exists
(
select *
from Customer_CreditCard
where customer_name=@customername and cc_number=@creditcardnumber
)
begin
set @flag = 1
end
else
begin
set @flag = 0
end

--q)ChooseCreditCard
go
create proc ChooseCreditCard
@creditcard varchar(20),
@orderid int
as

update Orders
set creditCard_number=@creditcard
where order_no=@orderid

--test
go
exec ChooseCreditCard '4444-5555-6666-8888', 3


--r)vewDeliveryTypes
go
create proc vewDeliveryTypes
as

select type,time_duration,fees
from Delivery

--test
go
exec vewDeliveryTypes


--s)specifydeliverytype
go
create proc specifydeliverytype
@orderID int,
@deliveryID int
as

declare @remainingdays int
select @remainingdays = time_duration
from Delivery
where id = @deliveryID

update Orders
set delivery_id = @deliveryID , remaining_days = @remainingdays
where order_no = @orderID

--test
go
exec specifydeliverytype 16, 1


--t)trackRemainingDays
go
create proc trackRemainingDays
@orderid int,
@customername varchar(20),
@days int OUTPUT
as

declare @delivery_id int
declare @order_date datetime
select @delivery_id = delivery_id , @order_date  = order_date
from Orders
where order_no = @orderid

declare @duration int
select @duration = time_duration
from Delivery
where id = @delivery_id

declare @time_limit datetime
set @time_limit = DATEADD(DAY, @duration, @order_date)

update Orders
set remaining_days = DATEDIFF(day, CURRENT_TIMESTAMP, @time_limit)
where customer_name=@customername AND order_no=@orderid

select @days=remaining_days
from Orders
where customer_name=@customername AND order_no=@orderid

--test
go
declare @result int
exec trackRemainingDays 16, 'ahmed.ashraf', @result output
print @result


--u)recommmend
go
create proc recommend
@customername varchar(20)
as

select serial_no, product_name, category, product_description, price, final_price, color
from Product
where serial_no in
(
select serial_no
from Product
where serial_no in
(
select top 3 p.serial_no
from Product p inner join Wishlist_Products w
on p.serial_no=w.serial_no
where p.category in 
(
select top 3 category
from CustomerAddstoCartProduct c inner join Product p on p.serial_no=c.serial_no
where c.customer_name=@customername
group by p.category
order by count(p.serial_no) DESC
)

group by p.serial_no
order by count(*) desc
)

union

select serial_no 
from Product
where serial_no in(
select top 3 serial_no 
from Wishlist_Products
where username in(
select top 3 c2.customer_name
from CustomerAddstoCartProduct c1 inner join CustomerAddstoCartProduct c2
on c1.serial_no=c2.serial_no
where c1.customer_name=@customername and c2.customer_name<>@customername
group by c2.customer_name
order by count(c2.serial_no) desc
)
group by serial_no
order by count(*) desc
)
)

--test
go
exec recommend 'ahmed.ashraf'


--Vendor

--a)postProduct
go
create proc postProduct
@vendorUsername varchar(20),
@product_name varchar(20),
@category varchar(20),
@product_description text,
@price decimal(10,2),
@color varchar(20)
as

insert into Product (product_name,category,product_description,price,final_price,vendor_username,color,available)
values (@product_name,@category,@product_description,@price,@price,@vendorUsername,@color,1)

--test
go
exec postProduct 'eslam.mahmod', 'pencil', 'stationary', 'HB0.7', 10, 'red'


--b)vendorviewProducts
go
create proc vendorviewProducts
@vendorname varchar(20)
as

select *
from Product
where vendor_username=@vendorname

--test
go
exec vendorviewProducts 'eslam.mahmod'


--c)EditProduct
GO 
CREATE PROC EditProduct
@vendorname VARCHAR(20), 
@serialnumber INT, 
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description TEXT, 
@price DECIMAL(10,2), 
@color VARCHAR(20)
AS

IF (@product_name IS NOT NULL)
UPDATE Product
SET product_name=@product_name
WHERE serial_no=@serialnumber AND vendor_username=@vendorname

IF (@category IS NOT NULL)
UPDATE Product
SET category=@category
WHERE serial_no=@serialnumber AND vendor_username=@vendorname

IF (@product_description IS NOT NULL)
UPDATE Product
SET product_description = @product_description
WHERE serial_no=@serialnumber AND vendor_username=@vendorname

IF (@price IS NOT NULL)
UPDATE Product
SET price = @price, final_price = @price
WHERE serial_no=@serialnumber AND vendor_username=@vendorname

IF (@color IS NOT NULL)
UPDATE Product
SET color=@color
WHERE serial_no=@serialnumber AND vendor_username=@vendorname

--test
go
exec EditProduct 'eslam.mahmod', 6, null, null, null, null, 'blue'


--d)deleteProduct
go
create proc deleteProduct
@vendorname varchar(20),
@serialnumber int
as

delete from Todays_Deals_Product
where serial_no=@serialnumber

delete from offersOnProduct
where serial_no=@serialnumber

delete from Customer_Question_Product
where serial_no=@serialnumber

delete from CustomerAddstoCartProduct
where serial_no=@serialnumber

delete from Wishlist_Products
where serial_no=@serialnumber

delete from Product
where vendor_username=@vendorname and serial_no=@serialnumber

--test
go
exec deleteProduct 'eslam.mahmod', 6


--e)viewQuestions
go
create proc viewQuestions
@vendorname varchar(20)
as

select q.*
from Customer_Question_Product q inner join Product p on q.serial_no = p.serial_no
where p.vendor_username = @vendorname

--test
go
exec viewQuestions 'hadeel.adel'


--f)answerQuestions
go
create proc answerQuestions
@vendorname varchar(20),
@serialno int,
@customername varchar(20),
@answer text
as

update Customer_Question_Product
set answer=@answer
where serial_no=@serialno AND customer_name=@customername

--test
go
exec answerQuestions 'hadeel.adel', 1, 'ahmed.ashraf', '40'


--g)
--addOffer
GO
CREATE PROC addOffer
@offeramount int, 
@expiry_date datetime
AS

INSERT INTO Offer(offer_amount, expiry_date)
VALUES (@offeramount, @expiry_date)

--test
go
exec addOffer 50, '11/10/2019'

--checkOfferonProduct
GO
CREATE PROC checkOfferonProduct
@serial INT, 
@activeoffer BIT OUTPUT
AS

IF EXISTS(SELECT offer_id
FROM offersOnProduct
WHERE serial_no =@serial)
SET @activeoffer = 'true'
ELSE
SET @activeoffer = 'false'

--checkandremoveExpiredoffer
GO
CREATE PROC checkandremoveExpiredoffer
@offerid INT
AS

DECLARE @date date
SELECT @date = expiry_date
FROM Offer 
WHERE offer_id =@offerid

IF (@date<CURRENT_TIMESTAMP)
BEGIN
UPDATE Product
SET final_price = price
WHERE serial_no IN (
SELECT serial_no
FROM offersOnProduct
WHERE offer_id = @offerid)

DELETE FROM offersOnProduct WHERE offer_id=@offerid
DELETE FROM Offer WHERE offer_id=@offerid 
END

--test
go
exec checkandremoveExpiredoffer 3

--applyOffer
GO
CREATE PROC applyOffer
@vendorname VARCHAR(20), 
@offerid INT, 
@serial INT
AS

DECLARE @vendor VARCHAR(20)
SELECT @vendor = vendor_username
FROM Product 
WHERE serial_no=@serial

DECLARE @CHECK BIT
EXEC checkOfferonProduct @serial , @CHECK OUTPUT

DECLARE @offeramount INT
SELECT @offeramount= offer_amount
FROM Offer
WHERE offer_id =@offerid

DECLARE @expiry_date DATETIME
SELECT @expiry_date = expiry_date
FROM Offer
WHERE offer_id = @offerid

IF (@vendor = @vendorname)
BEGIN

IF (@expiry_date>CURRENT_TIMESTAMP)
BEGIN
IF (@CHECK ='FALSE')
BEGIN

UPDATE Product
SET final_price = price -(price * (@offeramount/100.0))
WHERE serial_no=@serial

INSERT INTO offersOnProduct(offer_id,serial_no)
VALUES(@offerid, @serial)

END

ELSE
PRINT 'The product has an active offer'

END

ELSE
BEGIN
EXEC checkandremoveExpiredoffer @offerid
PRINT 'This offer has expired'

END

END
ELSE
BEGIN
PRINT 'This product belongs to another vendor'
END

--test
go
exec applyOffer 'hadeel.adel', 5, 1

--Admin

--a)activateVendors
go 
create proc activateVendors
@admin_username varchar(20),
@vendor_username varchar(20)
as

update Vendor
set activated=1 , admin_username=@admin_username
where username=@vendor_username

--test
go
exec activateVendors 'hana.aly', 'eslam.mahmod'


--b)inviteDeliveryPerson
go
create proc inviteDeliveryPerson
@delivery_username varchar(20),
@delivery_email varchar(50)
as

insert into Users (username,email)
values (@delivery_username,@delivery_email)

insert into Delivery_Person (username,is_activated)
values (@delivery_username,0)

--test
go
exec inviteDeliveryPerson 'mohamed.tamer', 'moha@gmail.com'


--c)reviewOrders
go
create proc reviewOrders
as

select *
from Orders

--test
go
exec reviewOrders


--d)updateOrderStatusInProcess
go
create proc updateOrderStatusInProcess
@order_no int
as

update Orders
set order_status='in process'
where order_no=@order_no

--test
go
exec updateOrderStatusInProcess 3


--e)addDelivery
go 
create proc addDelivery
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
as

insert into Delivery(type,time_duration,fees,username)
values (@delivery_type,@time_duration,@fees,@admin_username)

--test
go
exec addDelivery 'pick-up', 7, 10, 'hana.aly'


--f)assignOrdertoDelivery
go
create proc assignOrdertoDelivery
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
as

insert into Admin_Delivery_Order (delivery_username,order_no,admin_username)
values (@delivery_username,@order_no,@admin_username)

--test
go
exec assignOrdertoDelivery 'mohamed.tamer', 3, 'hana.aly'


--g)
--createTodaysDeal
GO
CREATE PROC createTodaysDeal
@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME
AS

INSERT INTO Todays_Deals (deal_amount , admin_username , expiry_date)
VALUES (@deal_amount,@admin_username,@expiry_date)

--test
go
exec createTodaysDeal 30, 'hana.aly', '2019/11/30'

--checkTodaysDealOnProduct
GO
CREATE PROC checkTodaysDealOnProduct
@serial_no INT,
@activedeal BIT OUTPUT
AS

IF EXISTS(SELECT deal_id
FROM Todays_Deals_Product
WHERE serial_no=@serial_no)
SET @activedeal = 'true'
ELSE
SET @activedeal = 'false'

--test
go
declare @result bit
exec checkTodaysDealOnProduct 2, @result output
print @result

--removeExpiredDeal
GO
CREATE PROC removeExpiredDeal
@deal_id INT
AS

DECLARE @date DATETIME
SELECT @date = expiry_date
FROM Todays_Deals 
WHERE deal_id =@deal_id

IF (@date<CURRENT_TIMESTAMP)
BEGIN

UPDATE Product
SET final_price = price
WHERE serial_no IN (
SELECT serial_no
FROM Todays_Deals_Product
WHERE deal_id = @deal_id)

DELETE FROM Todays_Deals WHERE deal_id = @deal_id
DELETE FROM Todays_Deals_Product WHERE deal_id = @deal_id
END

--test
go
exec removeExpiredDeal 25

--addTodaysDealOnProduct
GO
CREATE PROC addTodaysDealOnProduct
@deal_id INT, 
@serial_no INT
AS

DECLARE @check BIT
EXEC checkTodaysDealOnProduct @serial_no, @check OUTPUT

DECLARE @Damount INT
SELECT @Damount= deal_amount
FROM Todays_Deals
WHERE deal_id =@deal_id

DECLARE @expiry_date DATETIME
SELECT @expiry_date = expiry_date
FROM Todays_Deals
WHERE deal_id = @deal_id

IF (@expiry_date>CURRENT_TIMESTAMP)
BEGIN
IF (@CHECK ='FALSE')
BEGIN

UPDATE Product
SET final_price = price -(price * (@Damount/100.0))
WHERE serial_no = @serial_no

INSERT INTO Todays_Deals_Product (deal_id, serial_no)
VALUES(@deal_id , @serial_no)

END

ELSE
PRINT 'The product has an active deal'
END

ELSE
BEGIN
EXEC removeExpiredDeal @deal_id
PRINT 'This deal has expired'
END

--test
go
exec addTodaysDealOnProduct 25,2


--h)createGiftCard
go
create proc createGiftCard
@code varchar(10),
@expiry_date datetime,
@amount int,
@admin_username varchar(20)
as

insert into Giftcard
values(@code,@expiry_date,@amount,@admin_username)

--test
go
exec createGiftCard 'G101', '2019/12/30', 100, 'hana.aly'
exec createGiftCard 'G102', '2019/11/17', 70, 'hana.aly'


--i)
--removeExpiredGiftCard
go
create proc removeExpiredGiftCard
@code varchar(10)
as

declare @remaining_points int
select @remaining_points = remaining_points
from Admin_Customer_Giftcard

declare @expiry_date datetime
select @expiry_date = expiry_date
from Giftcard
where code = @code

if (@expiry_date<CURRENT_TIMESTAMP)
begin

update Customer
set points = points - @remaining_points
where username in (
select customer_name
from Admin_Customer_Giftcard
where code = @code
)

delete from Admin_Customer_Giftcard
where code = @code

delete from Giftcard
where code=@code

end

else if exists(
select *
from Giftcard
where code = @code
)
begin
print 'Giftcard is not expired'
end

else
begin
print 'Giftcard does not exist'
end

--test
go
exec removeExpiredGiftCard 'G101'
exec removeExpiredGiftCard 'G102'

--checkGiftCardOnCustomer
go
create proc checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard bit output
as

if exists(
select *
from Admin_Customer_Giftcard 
where code=@code)
begin
set @activeGiftCard=1
end
else
begin
set @activeGiftCard=0
end

--test
go
declare @result bit
exec checkGiftCardOnCustomer 'G101', @result output
print @result

declare @result bit
exec checkGiftCardOnCustomer 'G102', @result output
print @result

--giveGiftCardtoCustomer
go
create proc giveGiftCardtoCustomer
@code varchar(10),
@customer_name varchar(20),
@admin_username varchar(20)
as

declare @remaining_points int
select @remaining_points = amount
from Giftcard
where code = @code

declare @expiry_date datetime
select @expiry_date = expiry_date
from Giftcard
where code = @code

if (@expiry_date>CURRENT_TIMESTAMP)
begin

insert into Admin_Customer_Giftcard
values(@code,@customer_name,@admin_username,@remaining_points)

update Customer
set points = points + @remaining_points
where username = @customer_name

end
else

begin
exec removeExpiredGiftCard @code
print 'The giftcard is expired'
end

--test
go
exec giveGiftCardtoCustomer 'G101', 'ahmed.ashraf', 'hana.aly'
exec giveGiftCardtoCustomer 'G102', 'ahmed.ashraf', 'hana.aly'
exec giveGiftCardtoCustomer 'G103', 'ahmed.ashraf', 'hana.aly'


--Delivery Personnel

--a)acceptAdminInvitation
go
create proc acceptAdminInvitation
@delivery_username varchar(20)
as

update Delivery_Person
set is_activated = 1
where username = @delivery_username

--test
go
exec acceptAdminInvitation 'mohamed.tamer'


--b)deliveryPersonUpdateInfo
go
create proc deliveryPersonUpdateInfo
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
as

update Users
set first_name = @first_name , last_name = @last_name , password = @password , email = @email
where username = @username

--test
go
exec deliveryPersonUpdateInfo 'mohamed.tamer', 'mohamed', 'tamer', 'pass16', 'mohamed.tamer@guc.edu.eg' 


--c)viewmyorders
go
create proc viewmyorders
@deliveryperson varchar(20)
as

select *
from Orders o
where o.order_no in (
select a.order_no
from Admin_Delivery_Order a
where a.delivery_username = @deliveryperson)

--test
go
exec viewmyorders 'mohamed.tamer'


--d)specifyDeliveryWindow
go 
create proc specifyDeliveryWindow
@delivery_username varchar(20),
@order_no int,
@delivery_window varchar(50)
as

update Admin_Delivery_Order
set delivery_window = @delivery_window
where delivery_username = @delivery_username and order_no = @order_no

--test
go
exec specifyDeliveryWindow 'mohamed.tamer', 3, 'Today between 10 am and 3 pm'


--e)updateOrderStatusOutforDelivery
go
create proc updateOrderStatusOutforDelivery
@order_no int
as

update Orders
set order_status = 'Out for delivery'
where order_no = @order_no

--test
go
exec updateOrderStatusOutforDelivery 3


--f)updateOrderStatusDelivered
go
create proc updateOrderStatusDelivered
@order_no int
as

update Orders
set order_status = 'Delivered'
where order_no = @order_no

--test
go
exec updateOrderStatusDelivered 3



go
create proc count_has_bought
@customer_name varchar(20),
@category varchar(20),
@result int output
as

select @result = count(*)
from Product p
where p.customer_username = @customer_name and p.category = @category

