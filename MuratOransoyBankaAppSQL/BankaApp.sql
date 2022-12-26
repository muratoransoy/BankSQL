create database bankApp
use bankApp
CREATE TABLE customer
   (
       custid INT PRIMARY KEY IDENTITY NOT NULL,
       fname VARCHAR(30),
       mname VARCHAR(30),
       ltname VARCHAR(30),
       city VARCHAR(15),
       mobileno VARCHAR(10),
       occupation VARCHAR(10),
       dob DATE
   );
   
   CREATE TABLE branch
   (
    bid INT PRIMARY KEY IDENTITY NOT NULL,
    bname VARCHAR(30),
    bcity VARCHAR(30)
   );

   CREATE TABLE account
   (
      acnumber INT PRIMARY KEY IDENTITY NOT NULL,
      custid  int,
      bid int,
      opening_balance INT,
      aod DATE,
      atype VARCHAR(10),
      astatus VARCHAR(10),
	  FOREIGN KEY (custid) REFERENCES customer(custid),
	  FOREIGN KEY (bid) REFERENCES branch(bid)
    );

	CREATE TABLE trandetails
    (   
     tnumber INT PRIMARY KEY IDENTITY NOT NULL,
     acnumber INT,
     dot DATE,
     medium_of_transaction VARCHAR(20),
     transaction_type VARCHAR(20),
     transaction_amount INT,    
	 FOREIGN KEY (acnumber) REFERENCES account(acnumber),
    );

	CREATE TABLE loan
   (
   
    custid INT,
    bid INT,
    loan_amount INT,
	 FOREIGN KEY(custid) REFERENCES  customer(custid),
    FOREIGN KEY(bid) REFERENCES  branch(bid)
   );

   drop table loan

INSERT INTO customer VALUES('Ramesh','Chandra','Sharma','Ýstanbul','9543198345','Hizmet','1976-12-06');
INSERT INTO customer VALUES('Avinash','Sunder','Minha','Ýstanbul','9876532109','Hizmet','1974-10-16');
INSERT INTO customer VALUES('Rahul',null,'Rastogi','Ýstanbul','9765178901','Öðrenci','1981-09-26');
INSERT INTO customer VALUES('Parul',null,'Gandhi','Çanakkale','9876532109','Ev Hanýmý','1976-11-03');
INSERT INTO customer VALUES('Naveen','Chandra','Aedekar','Edirne','8976523190','Hizmet','1976-09-19');
INSERT INTO customer VALUES('Chitresh',null,'Barwe','Edirne','7651298321','Öðrenci','1992-11-06');
INSERT INTO customer VALUES('Amit','Kumar','Borkar','Ýzmir','9875189761','Öðrenci','1981-09-06');
INSERT INTO customer VALUES('Nisha',null,'Damle','Edirne','7954198761','Hizmet','1975-12-03');
INSERT INTO customer VALUES('Abhishek',null,'Dutta','Çanakkale','9856198761','Hizmet','1973-05-22');
INSERT INTO customer  VALUES('Shankar',null,'Nair','Ýzmir','8765489076','Hizmet','1976-07-12');
INSERT INTO customer  VALUES('Murat',null,'Oransoy','Edirne','5428467654','Yazýlýmcý','2001-09-15');

select * from customer

INSERT INTO branch VALUES('Balat','Ýstanbul');
INSERT INTO branch VALUES('Delhi cantt','Ýstanbul');
INSERT INTO branch VALUES('Cihangir','Ýstanbul');
INSERT INTO branch VALUES('Barbaros','Çanakkale');
INSERT INTO branch VALUES('Cevatpaþa','Çanakkale');
INSERT INTO branch VALUES('Kepez','Çanakkale');
INSERT INTO branch VALUES('Dilaverbey ','Edirne');
INSERT INTO branch VALUES('Karaaðaç','Edirne');

select * from branch

INSERT INTO account VALUES(1,1,1000,'2012-12-15','Saving','Active');
INSERT INTO account VALUES(2,2,1000,'2012-06-12','Saving','Active');
INSERT INTO account VALUES(3,3,1000,'2012-05-17','Saving','Terminated');
INSERT INTO account VALUES(4,4,1000,'2013-01-27','Saving','Active');
INSERT INTO account VALUES(5,5,1000,'2012-12-17','Saving','Active');
INSERT INTO account VALUES(6,6,1000,'2010-08-12','Saving','Suspended');
INSERT INTO account VALUES(7,7,1000,'2012-10-02','Saving','Active');
INSERT INTO account VALUES(8,8,1000,'2009-11-09','Saving','Terminated');


select * from account

INSERT INTO trandetails VALUES(20,'2013-01-01','Cheque','Deposit',2000);
INSERT INTO trandetails VALUES(20,'2013-02-01','Cash','Withdrawal',1000);
INSERT INTO trandetails VALUES(21,'2013-01-01','Cash','Deposit',2000);
INSERT INTO trandetails VALUES(21,'2013-02-01','Cash','Deposit',3000);
INSERT INTO trandetails VALUES(26,'2013-01-11','Cash','Deposit',7000);
INSERT INTO trandetails VALUES(26,'2013-01-13','Cash','Deposit',9000);
INSERT INTO trandetails VALUES(23,'2013-03-13','Cash','Deposit',4000);
INSERT INTO trandetails VALUES(27,'2013-03-14','Cheque','Deposit',3000);
INSERT INTO trandetails VALUES(24,'2013-03-21','Cash','Withdrawal',9000);
INSERT INTO trandetails VALUES(25,'2013-03-22','Cash','Withdrawal',2000);
INSERT INTO trandetails VALUES(22,'2013-03-25','Cash','Withdrawal',7000);
INSERT INTO trandetails VALUES(27,'2013-03-26','Cash','Withdrawal',2000);

select * from trandetails

INSERT INTO loan VALUES(1,1,100000);
INSERT INTO loan VALUES(2,2,200000);
INSERT INTO loan VALUES(9,8,400000);
INSERT INTO loan VALUES(10,5,500000);
INSERT INTO loan VALUES(7,3,600000);
INSERT INTO loan VALUES(5,1,600000);

select * from loan

/*Müþteri numarasýný, adýný, müþterinin doðum tarihini görüntülemek için oluþturulan sorgu*/

select custid, fname, ltname,dob from customer

/*Hesap numarasýný , müþteri numarasýný , müþterinin adýný , soyadýný , hesap açýlýþ tarihini görüntülemek için bir sorgu*/

select account.acnumber, customer.custid, customer.fname, customer.ltname, account.aod from account inner join customer on account.custid = customer.custid;

/*Ýstanbul'dan gelen müþterilerin sayýsýný görüntülemek için bir sorgu*/

select count(city)[ Müþterilerin Sayýsýný] from customer where city='Ýstanbul'

/*Herhangi bir ayýn 15'inden sonra hesabý açýlan müþterinin müþteri numarasýný , müþteri adýný , hesap numarasýný gösteren bir sorgu*/

select account.custid, customer.fname, account.acnumber from account, customer where account.custid = customer.custid and day(aod) > 15;

/*Ýþ , hizmet veya eðitimle ilgilenmeyen kadýn müþterilerin adlarýný , þehirlerini ve hesap numaralarýný görüntülemek için bir sorgu*/
select distinct customer.fname, customer.city, account.acnumber from account, customer where account.custid = customer.custid
and not(occupation='business' or occupation='service' or occupation='student');

/*Þehir adýný ve o þehirdeki þube sayýsýný görüntülemek için bir sorgu*/

SELECT bcity, count(*) AS [Þube Sayýsý] FROM branch Group By bcity;

/*Hesabý Aktif olan müþteri için hesap id , müþteri adý , müþteri soyadýný görüntülemek için bir sorgu*/

select account.acnumber, customer.fname, customer.ltname from account, customer where account.custid = customer.custid and astatus = 'Active';

/*Kredi almýþ kiþiler için müþteri numarasý , müþteri adý , þube numarasý ve kredi tutarýný gösteren bir sorgu*/

SELECT customer.custid, customer.fname, branch.bid, loan.loan_amount FROM customer INNER JOIN loan ON loan.custid=customer.custid
INNER JOIN branch ON loan.bid=branch.bid;

/*Hesap durumunun sonlandýrýldýðý müþteri numarasýný , müþteri adýný , hesap numarasýný görüntülemek için bir sorgu*/

SELECT customer.custid, customer.fname, account.acnumber FROM account, customer WHERE account.custid = customer.custid
AND astatus ='Terminated'

/* Müþteri tablosundaki þehirleri sayýsý çoktan aza olacak þekilde Stored Procedure */

CREATE PROCEDURE MusteriSehir 
AS 
BEGIN 
SELECT city, COUNT(city) FROM dbo.customer 
GROUP BY city 
ORDER BY COUNT(city) DESC 
END

exec MusteriSehir

/*Ýsme göre hesap açýlýþ bilançosunu ve hesabýn tipini getiren poc*/

 go
 create proc bilancogetir
 (@getir nvarchar(20))
 as select a.opening_balance,a.atype from customer c inner join account a on
 a.custid=c.custid where fname=@getir
 go
 exec bilancogetir 'Rahul'

 /*Customer tablosundan Müþteri Silme Engeli Trigger*/

go
alter trigger CustomerSilmeEngeli
on customer
instead of delete
as
declare @silinenID int
select @silinenID=custid from deleted 
if @silinenID>0
begin
print 'Müþteri Silinemez'
end
else
begin
declare @silinecekId int
select @silinecekId=custid from deleted
delete customer where custid=@silinecekId
end
go
1

select * from customer
delete customer where custid=5

/*Customer Tablosuna kim müþteri eklediyse onu baþka bir tabloda tutan trigger*/

create table CustomerYedek (
Id int primary key identity ,
Custid int,
Eklenenfname nvarchar (20),
EklenenYazarlname nvarchar (20),
SilinenYazarfname nvarchar(20),
SilinenYazarlname nvarchar(20),
islemAd nvarchar(20),
tarih date,
Islemturu nvarchar (20))
go
create trigger customerInsert
on customer
after insert
as
begin
declare @customerID int, @eklenencustomerfname nvarchar(20),
@eklenencustomerlname nvarchar(20),
@islemAd nvarchar(20)
select @customerID=custid,@eklenencustomerfname=fname,@eklenencustomerlname=ltname,
@islemAd=(select SUSER_NAME()) from inserted
insert into CustomerYedek(Custid,Eklenenfname,EklenenYazarlname,
islemAd,tarih,Islemturu) values (@customerID,@eklenencustomerfname,
@eklenencustomerlname,@islemAd,GETDATE(),'Ekleme')

end
select *from customer
INSERT INTO customer  VALUES('fatma',null,'öztürk','çanakkale','5428467123','Yazýlýmcý','1993-09-15');
select*from CustomerYedek

/*borça göre  azdan çok'a doðru sýralama*/
create view borcagoregetir
as
select top 100 percent  custid,loan_amount from loan order by loan_amount desc

select *from borcagoregetir

/*istanbulun semtinde olan bankalarý ve bankalara olan borçlarý gösteren view*/

alter view Istanbullular
as
select b.bname,b.bcity,o.loan_amount
from branch b inner join loan o
on b.bid=o.bid
where b.bcity='Istanbul'

select* from Istanbullular

/*-------yas hesaplama-------*/

CREATE Function YasHesapla(@tarih Date)
Returns int
As
Begin
Declare @sonuc int
Set @sonuc = DATEDIFF(Year,@tarih,GETDATE())
Return @sonuc
End
Select dbo.YasHesapla ('09.15.2001')

/*customer ýd ye göre kimler parayla ne miktar iþlem yaptýðýný gösteren view */

CREATE Function YatýrýlanparaHesapla(@ID int)
Returns int
As
Begin
Declare @adet int
Select @adet = SUM(t.transaction_amount) From customer c
Inner Join account a On a.custid=c.custid
Inner Join trandetails t On t.acnumber = a.acnumber
Where c.custid=@ID
Group By c.custid
Return @adet
End
Select fname,ltname,dbo.YatýrýlanparaHesapla(custid) From customer

select * from trandetails

select * from account

select * from customer

/*-------------------*/


