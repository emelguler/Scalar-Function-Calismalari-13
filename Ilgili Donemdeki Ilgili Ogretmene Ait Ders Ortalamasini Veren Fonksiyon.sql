USE [Okul]


--Ilgili Donemdeki Ilgili Ogretmene Ait Ders Ortalamasini Veren Fonksiyon:

ALTER function [dbo].[FN$IlgiliDonemdekiOgretmeneAitDersOrtalamasi]
 (
 @Donem_Id int,
 @Ogretmen_Id int,
 @Ders_Id int)

 returns char(2)
as
begin
      declare 

              @HarfNotu char(2),
	          @Ortalama tinyint,
			  @sonuc tinyint

	set @sonuc=	(select (sum(a.Ortalama)/count(*)) as 'not ortalaması'  from
	(select od.Ogretmen_Id,
	od.Donem_Id,
	   de.Id as Ders_Id,

	   ood.Vize*0.4+ood.Final*0.6 as Ortalama
	   from dbo.OgrenciOgretmenDers as ood 
	   inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
	   inner join dbo.Ogretmen as o on o.Id=od.Ogretmen_Id and o.Statu=1
	   inner join dbo.Donem as d on d.Id=od.Donem_Id and d.Statu=1
	   inner join dbo.Ders as de on de.Id=od.Ders_Id and de.Statu=1
	   where ood.Statu=1
	   and d.Id =@Donem_Id
       and od.Ogretmen_Id=@Ogretmen_Id
       and od.Ders_Id= @Ders_Id 
	   group by od.Ogretmen_Id,od.Donem_Id,de.Id,ood.Vize,ood.Final)
	   a

	   )
	



	return @sonuc
	end



--cagiralim:
select [dbo].FN$IlgiliDonemdekiOgretmeneAitDersOrtalamasi(1,6,8)




--where clause kontrolu:
select ( convert(int,round((sum(a.Ortalama)/count(*)),0))) as 'not ortalaması'  from
	(select od.Ogretmen_Id,
	od.Donem_Id,
	   de.Id as Ders_Id,

	   ood.Vize*0.4+ood.Final*0.6 as Ortalama
	   from dbo.OgrenciOgretmenDers as ood 
	   inner join dbo.OgretmenDers as od on od.Id=ood.OgretmenDers_Id and od.Statu=1
	   inner join dbo.Ogretmen as o on o.Id=od.Ogretmen_Id and o.Statu=1
	   inner join dbo.Donem as d on d.Id=od.Donem_Id and d.Statu=1
	   inner join dbo.Ders as de on de.Id=od.Ders_Id and de.Statu=1
	   where ood.Statu=1
	   and d.Id =1
       and od.Ogretmen_Id=6
       and od.Ders_Id= 8 
	   group by od.Ogretmen_Id,od.Donem_Id,de.Id,ood.Vize,ood.Final)
	   a