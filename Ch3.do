cd D:\data\statadata

********************************************************************************
************************ Chapter 3 *********************************************
********************************************************************************


***** C3 *****
use CEOSAL2,clear
reg lsalary lsales lmktval
* (1)由于要求模型对每个自变量的变化都具有常弹性，因此对变量取对数后进行回归，回归
*   得到的常弹性方程为 log(salary^hat) = 4.62 + 0.162 log(sales)  + 0.107 log(mktval).
*   样本观测数n = 177， R-squared = 0.299 .

sum profits if profits < 0
reg lsalary lsales lmktval profits
* (2)profits 不能以对数形式进入模型的原因在于：样本中有9个公司的利润为负值，如果采用对数形式，将会在模型中丢失这些数据.   
*   根据回归得到的模型 log(salary^hat) = 4.69 + 0.161 log(sales) + 0.0981 log(mktval) + 0.000036 profits . 
*   样本观测数n = 177， R-squared = 0.299 .
*   profits 的系数非常小，其系数的解释为：在sales 和 mktval 保持不变的条件下，如果profits增加  1000 百万，预测的薪水也仅增加3.6% . 
* 总的来说，这些变量仅解释了CEO薪水变异中的29.9% . 

reg lsalary lsales lmktval profits ceoten
* (3)加入变量ceoten后的模型为：
* log(salary^hat) = 4.56 + 0.162 log(sales) + 0.102 log(mktval) + 0.000029 profits + 0.012 ceoten .
* 样本观测数n=177， R-squared = 0.318 .
* 保持其他条件不变，延长一年CEO任期，估计的百分比回报是1.2% .

corr lmktval profits
* (4) 变量 log(mktval) 和 profits 之间的相关系数是0.7769 , 这是高度相关的.
* 这对OLS估计量的无偏性并无影响，但是会使他们的方差增大.


***** C10 *****
use HTV,clear
sum educ
tab educ
sum motheduc
sum fatheduc
* (1) educ的取值范围为从6到20， 最高学历是12年级的人占41.63% .
*  样本中平均的教育水平为13.0，母亲的平均教育水平为12.18，父亲的平均教育水平为12.45.
* 平均来说这些人比父母有更高的教育水平.

reg educ motheduc fatheduc
* (2)回归模型为 educ^hat = 6.96 + 0.304 motheduc + 0.190 fatheduc .
* 样本观测数 n = 1230, R-squared = 0.249 .
* 变量educ 24.9%的变化可以由父母的教育水平所解释.
* motheduc 的系数解释为：控制父亲的教育水平不变，母亲的教育水平每提升1年，孩子的教育水平将增加0.304年.

reg educ motheduc fatheduc abil
* (3)加入变量abil得到的回归模型为
* educ^hat = 8.45 + 0.189 motheduc + 0.111 fatheduc + 0.502 abil .
* n = 1230,R-squared = 0.428 .
* 加入变量abil后，解释能力从原来的24.9%增加到42.8%,提高幅度较大.
* 可以认为控制父母教育程度变量后，“认知能力”有助于解释教育程度的变化.

gen abil2 = abil^2
reg educ motheduc fatheduc abil abil2
* (4)加入变量abil^2后，估计得到的模型为
* educ^hat = 8.24 + 0.190 motheduc + 0.109 fatheduc + 0.401 abil + 0.051 abil^2 .
* 在上述回归方程中关于abil求偏导，令偏导等于0， 得到 abil* = -0.401/0.102 = -3.93.

sum abil if abil < -3.93
* (5)在1230个样本中，只有15个的能力小于-3.93， 占总样本的1.2% .
* 因此说明可以忽略这一部分能力低于-3.93的 ，即对于大部分人而言，abil和educ之间存在正向影响.

gen model_educ = 8.24 + 0.190 * 12.18 + 0.109 * 12.45 + 0.401*abil + 0.051*abil^2
twoway function y = 8.24 + 0.190 * 12.18 + 0.109 * 12.45 + 0.401*x + 0.051*x^2, range(-5 5)title("education model") , ytitle("educ") xtitle("abil")
* (6)如图所示.


