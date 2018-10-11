select minjanquant.cust, minjandate.prod, minjanquant.min_q_jan/*min quant in Jan*/ as JAN_MIN, minjandate.month||'/'||minjandate.day||'/'||minjandate.year as JAN_DATE, maxfebquant.max_q_feb/*max in Feb*/as FEB_MAX, maxfebdate.month||'/'||maxfebdate.day||'/'||maxfebdate.year as FEB_DATE, maxmarquant.max_q_mar/*max in March*/as MAR_MAX, maxmardate.month||'/'||maxmardate.day||'/'||maxmardate.year as MAR_DATE
from 
(select cust, min(quant) as min_q_jan from sales where month = 1 and year > 1999 group by cust) minjanquant 
inner join 
(select cust, max(quant) as max_q_feb from sales where month = 2 and year > 1999 group by cust) maxfebquant on maxfebquant.cust=minjanquant.cust
inner join
(select cust, max(quant) as max_q_mar from sales where month = 3 and year > 1999 group by cust) maxmarquant on maxmarquant.cust=minjanquant.cust
inner join
(select cust, prod, quant, month, day, year from sales where month = 1 and year > 1999) minjandate on minjandate.quant = minjanquant.min_q_jan
inner join
(select cust, prod, quant, month, day, year from sales where month = 2 and year > 1999) maxfebdate on maxfebdate.quant = maxfebquant.max_q_feb
inner join
(select cust, prod, quant, month, day, year from sales where month = 3 and year > 1999) maxmardate on maxmardate.quant = maxmarquant.max_q_mar
;

-- having year > 1999