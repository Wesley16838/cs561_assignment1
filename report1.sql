select main1.cust, main1.max_q/*max*/, maxprod.prod, maxdate.month||'/'||maxdate.day||'/'||maxdate.year as MAX_DATE, maxdate.st, main2.min_q/*min*/, minprod.prod,mindate.month||'/'||mindate.day||'/'||mindate.year as MIN_DATE, mindate.st,main1.avg_q--Avg
from 
(select cust, max(quant) as max_q,avg(quant) as avg_q from sales group by cust) main1--max quantity
inner join
(select cust, min(quant) as min_q from sales group by cust) main2 on main2.cust = main1.cust --min quantity
inner join
(select prod, cust, quant from sales) maxprod on main1.max_q = maxprod.quant --max prod
inner join
(select prod, cust, quant from sales) minprod on main2.min_q = minprod.quant --min prod
inner join
(select prod, cust, quant, day, month, year, state as st from sales) maxdate on main1.max_q = maxdate.quant and maxprod.prod = maxdate.prod -- max date
inner join
(select prod, cust, quant, day, month, year, state as st from sales) mindate on main2.min_q = mindate.quant and minprod.prod = mindate.prod -- min date
;