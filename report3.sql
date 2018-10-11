select totalfirst.prod as PRODUCT, totalfirst.total1 as Q1_TOTAL, totalsecond.total2 as Q2_TOTAL, totalthird.total3 as Q3_TOTAL, totalfourth.total4 as Q4_TOTAL
from 
(select prod, sum(quant) as total1 from sales where month between 1 and 3 group by prod) totalfirst
inner join
(select prod, sum(quant) as total2 from sales where month between 4 and 6 group by prod) totalsecond on totalsecond.prod = totalfirst.prod
inner join 
(select prod, sum(quant) as total3 from sales where month between 7 and 9 group by prod) totalthird on totalthird.prod = totalfirst.prod
inner join
(select prod, sum(quant) as total4 from sales where month between 10 and 12 group by prod) totalfourth on totalfourth.prod = totalfirst.prod