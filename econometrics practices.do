cd D:\data\statadata


bcuse bwght, clear //C1C2
sum if male==0 //妇女数量
sum if male==0&cigs>0 //抽烟妇女数量
sum cigs
tabulate cigs 
tabulate if cigs>0
keep if fatheduc!=. //删除缺省值
sum fatheduc //样本fatheduc平均数
gen avinc=faminc*1000 //用美元计算
sum avinc //报告平均收入和方差

bcuse meap01, clear //C1C3
sum math4 //caculate min,max
sum math4 if math==100 //passing rate=100%
display 38/1823 //caculate the rate
sum math4 if math==50 //passing rate=50%
sum read4 if read4>=60 
sum math4 if math>=60 //cumpare passing rates
corr math4 read4
sum exppp
display (6000-5500)/5500
display 100*(ln(6000)-ln(5500))

bcuse jtrain2, clear //c1c4
tabulate train //得到工作培训比例
sum re78 if train==1
sum re78 if train==0
tabulate unem78 if train==1
tabulate unem78 if train==0

bcuse fertil2, clear //c1c5
sum children
tabulate electric
sum children if electric==1
sum children if electric==0
bcuse alcohol, clear

bcuse 401k, clear //c2c1
sum prate mrate
reg prate mrate

bcuse ceosal2, clear //c2c2
sum salary ceoten
gen lnsalary=log(salary)
reg lnsalary ceoten

bcuse sleep75, clear //c2c3
reg sleep totwrk

bcuse wage2, clear //c2c4
sum wage IQ
reg wage IQ
gen lnwage=log(wage)
reg lnwage IQ

bcuse rdchem, clear //c2c5
gen lnrd=log(rd) 
gen lnsales=log(sales)
reg lnrd lnsales

bcuse meap93, clear //c2c6
gen lnexpend = log(expend)
reg math10 lnexpend

bcuse charity, clear //c2c7
sum gift
tabulate gift
sum mailsyear
reg gift mailsyear 

bcuse catholic, clear //c2c10
sum read12 math12
reg math12 read12

bcuse bwght, clear //c3c1
reg bwght cigs 
reg bwght cigs faminc

bcuse hprice1 //c3c2
reg price sqrft bdrms

bcuse ceosal2 //c3c3
gen lnsalary=log(salary)
gen lnsales=log(sales)
gen lnmktval=log(mktval)
reg lnsalary lnsales lnmktval
reg lnsalary lnsales lnmktval profits
reg lnsalary lnsales lnmktval profits ceoten
corr lnmktval profits

bcuse attend, clear //c3c4
sum atndrte priGPA ACT
reg atndrte priGPA ACT

bcuse wage2, clear //c3c6
reg IQ educ
gen lnwage=log(wage)
reg lnwage educ
reg lnwage educ IQ

bcuse meap93, clear //c3c7 
gen lnexpend=log(expend)
reg math10 lnexpend lnchprg
reg lnexpend lnchprg
reg math10 lnexpend 
corr lnexpend lnchprg

bcuse discrim, clear  //c3c8
sum prpblck income
reg psoda prpblck income  //如何报告时不使用科学技术法 
reg psoda prpblck
reg lpsoda lincome prpblck 
reg lpsoda lincome prpblck prppov
corr lincome prppov

bcuse charity, clear //c3c9
reg gift mailsyear giftlast propresp
reg gift mailsyear
reg gift mailsyear giftlast propresp avggift

bcuse econmath, clear  //c3c11

bcuse vote1, clear //c4c1
gen lnexpendA=log(expendA)
gen lnexpendB=log(expendB)
reg voteA ln*A ln*B prt*A
gen lnab=lnexpendA+lnexpendB
reg voteA lnAB ln*A prt*A



use lawsch85, clear //c4c2
gen lns=log(salary)
gen lnlibvol=log(libvol)
gen lnct=log(cost)
reg lns LSAT GPA lnlibvol lnct rank
test rank
test LSAT GPA
reg lns LSAT GPA lnlibvol lnct rank clsize faculty
test clsize faculty

bcuse hprice1, clear //c4c3
gen lnprice=log(price)
reg lnprice sqrft bdrms
gen sb=sqrft-150*bdrms
reg lnprice bdrms sb

bcuse mab1, clear


bcuse wage2, clear //c4c6
gen lnw=log(wage)
reg lnw educ exper tenure
test educ=exper

bcuse twoyear, clear //c4c7
sum ph
reg lwage jc totcoll exper phs

bcuse 401ksubs, clear //c4c8
tabulate marr if fsize==2
reg nettfa inc age
test age==1
reg nettfa inc

bcuse discrim, clear //c4c9
gen lnpso=log(psoda)
gen lnincome=log(income)
reg lnpso prpblck lnincome prppov
corr lnincome prppov
gen lnhse=log(hseval)
reg lnpso prpblck lnincome prppov lnhse
test lnincome prppov

bcuse elem94_95, clear //c4c10
reg lavg bs
test bs==-1
reg lavg bs lenrol lstaff
reg lavg bs lenrol lstaff lunch

bcuse htv, clear //c4c11
gen abil2=abil^2
reg educ motheduc fatheduc abil abil2
test abil2
test moth=fath
reg educ motheduc fatheduc abil abil2 tuit17 tuit18
test tuit17 tuit18
corr tuit17 tuit18

bcuse wage1, clear //C5C1
	reg wage educ exper tenure 
	predict e, residual
	histogram e, normal 
	reg lwage educ exper tenure 
	predict e2, residual
	histogram e2, normal

bcuse gpa2, clear //C5C2
	reg colgpa hsperc sat 
	reg colgpa hsperc sat if _n <= 2070
	
bcuse bwght, clear //c5c3
	reg bwght cigs parity faminc motheduc fatheduc
	reg bwght cigs parity faminc
	predict uhat, residual
	reg uhat bwght cigs parity faminc motheduc fatheduc
	display "LM = " e(N)*e(r2) //计算LM统计量
	display invchi2tail(e(N),0.05) //计算卡方分布显著性水平为5%的临界值
	
bcuse 401ksubs, clear //c5c4
	drop if fsize != 1
	sum inc
	gen stdinc = (inc-29.44618)/16.67356    
    gen z = stdinc^3
    sum z
	gen linc = log(inc)
	sum linc
	gen lstdinc = (linc-3.252557)/ .4968014
	gen z2 = lstdinc^3
	sum z2
	
	bcuse htv, clear //c5c5
	egen a = group(educ)
	sum a, tetail
	histogram educ, normal

bcuse kielmc, clear //c6c1
	gen lnp=log(price) 
	gen lndist=log(dist)
	reg lnp lndist
	reg lprice ldist lintst larea lland rooms baths age
	gen lintst2=(lintst)^2
	reg lprice ldist lintst larea lland rooms baths age lintst2
	gen ldist2=(ldist)^2
	reg lprice ldist lintst larea lland rooms baths age ldist2 lintst2

bcuse wage1, clear //c6c2
	gen exper2=exper^2
	reg lwage educ exper exper2
	dis 0.0410089/(0.0007136*2)
	tab exper
	
bcuse wage2, clear //c6c3
	ge edper=educ*exper
	reg lwage educ exper edper 
	gen exper10=exper-10
	gen edexper10=educ*exper10
	reg lwage educ exper edexper10

bcuse gpa2, clear //c6c4
	reg sat hsize hsizesq
	dis -19.81446/ (-2.130606*2)*100
	gen lsat = log(sat)
	reg lsat hsize hsizesq
	dis .0196029/ (.0020872*2)*100
	
bcuse hprice1, clear //c6c5
	reg lprice llotsize lsqrft bdrms
	
bcuse vote1, clear //c6c6
	gen exAB = expendA*expendB
	reg voteA prtystrA expendA expendB exAB
	sum expendA 
	
bcuse attend, clear //c6c7
	*略
	
bcuse nbasal, clear //c6c9
	reg points exper age coll expersq
	dis -2.363631/(-.0770269*2) //只有个别超过转折点
	reg points exper age coll expersq agesq
*如果一次项为正，二次项也为正，那么是一个y随x递增的函数，而且是以增加的速度递增。
*如果一次项为负，二次项也为负，那么是一个y随x递减的函数，而且是以递减的速度递减。
*对于（二）和（三），具体需要看你的研究内容是什么。如果你更关心一次项的估计系数
*但是二次项的缺失会导致一次项系数的有偏估计，这个时候，
*你最好加入二次项，即使它是不显著的（特别是你说的F检验显著）。
*如果你更关心二次项的问题，比如研究price asymmetry，那么二次项本身的显著性也有关系了。
*其实在没有研究背景的情况下说这些有些武断，而且也不一定对。
*关键是看你的研究的数据的性质。如果图反映出你的数据更像直线而非曲线，
*那么即使二次项在你的模型中是显著的，也一定是发生了什么问题。
*还有就是加入了二次项到底有没有经济意义呢，起码经济理论上要说的通吧。
*我也再想一个问题，正好和你讨论讨论，为什么不用LOG呢？
*如果你的数据基本反映出指数趋势（一般时间序列数据都是这样），
*用LOG是不是可以得到更加精确的OLS估计值呢？你是否已经试过LOG了？发现不行？
	reg lwage points exper age coll expersq
	test age coll
	
bcuse bwght2 //c6c10
	reg lbwght npvis npvissq 
	dis -.0189167/(-.0004288*2)
	count if npvis >= 22
	dis 89/1832 //有意义，产检过多可能是因为有问题。
	reg lbwght npvis npvissq magesq mage
	dis  .025392/( -.0004119*2)
	count if mage >=31
	dis 746/1832
	reg lbwght npvis npvissq magesq mage
	reg bwght npvis npvissq magesq mage
	
bcuse apple, clear //c6c11
	reg ecolbs ecoprc regprc
	predict yhat
	sum yhat
	count if ecolbs == 0
	sum ecolbs
	reg ecolbs ecoprc regprc faminc hhsize educ age
	test faminc hhsize educ age
	
bcuse 401ksubs, clear //c6c12
	drop if fsize == 0
	sum age
	count if age == 25
	reg nettfa inc age agesq 
	dis  2.231489/(.0377221*2)
	gen avagesq = (age - 25)^2
	reg nettfa inc age avagesq 
	reg nettfa inc avagesq 
	reg nettfa inc avagesq incsq
	dis .1626518/(.0096831*2)
	sum inc

bcuse gpa1, clear //c7c1
	reg colGPA PC hsGPA ACT fathcoll mothcoll
	test fathcoll mothcoll
	gen hsGPAsq = hsGPA^2
	reg colGPA PC hsGPA ACT fathcoll mothcoll hsGPAsq
	dis 1.802523/(.337341*2)
	
*结果表明在2.6716631处发生转折，并没有经济意义，因此这只是一个简单的稳健性检验。
view browse "https://www.lianxh.cn/news/32ae13ec789a1.html"稳健性检验推文
	
bcuse wage2, clear //c7c2
	reg lwage educ exper tenure married black south urban 
	gen expersq = exper^2
	gen tenuresq = tenure^2
	reg lwage educ exper tenure married black south urban expersq tenuresq
	test expersq tenuresq
	gen beduc = black*educ
	reg lwage educ exper tenure married black south urban beduc
	test beduc
	reg lwage educ exper tenure south urban i.married##i.black
	dis  .1889147-.2408201+ .0613538-.1889147
	
bcuse mlb1, clear //c7c3
	reg lsalary years gamesyr bavg hrunsyr rbisyr runsyr fldperc allstar ///
	scndbase thrdbase shrtstop catcher
	test scndbase thrdbase shrtstop catcher 
	
bcuse gpa2, clear //c7c4
	reg colgpa hsize hsizesq hsperc sat female athlete
	reg colgpa hsize hsizesq hsperc female athlete
	gen flathlete = female*athlete
	reg colgpa hsize hsizesq hsperc sat female athlete flathlete
	gen femsat = female*sat
	reg colgpa hsize hsizesq hsperc sat female athlete femsat 
	
bcuse ceosal1, clear //c7c5
	gen rosneg = (ros < 0)
	reg lsalary lsales roe rosneg 
	
bcuse sleep75, clear //c7c6
	bys male:reg sleep totwrk educ age agesq yngkid //分组回归
	
bcuse wage1, clear //c7c7
	gen feduc = female*educ
	reg lwage female educ exper expersq tenure tenursq feduc
	dis -.2267887 -.0055645*12.5
	gen feduc2 = female*(educ - 12.5)
	reg lwage female educ exper expersq tenure tenursq feduc2 
	
bcuse loanapp, clear //c7c8
	
bcuse 401ksubs, clear //c7c9
	tab e401k
	
bcuse 401ksubs, clear //c7c11
	sum nettfa
	ttest nettfa, by(e401k)
	reg nettfa e401k age inc agesq incsq
	gen eage = e401k*(age - 41)
	gen eagesq = e401k*(age - 41)^2
	reg nettfa e401k age inc eage eagesq
	gen fsize1 = (fsize == 1)
	gen fsize2 = (fsize == 2)
	gen fsize3 = (fsize == 3)
	gen fsize4 = (fsize == 4)
	gen fsize5 = (fsize >= 5)
	reg nettfa e401k age inc agesq incsq fsize1-fsize4
	test fsize1 fsize2 fsize3 fsize4
	
bcuse beauty, clear //c7c12
	sort female
	by female: tab belavg
	bys female:reg lwage belavg abvavg
	bys female:reg lwage belavg abvavg educ exper expersq ///
	union goodhlth black married south bigcity smllcity service
	
bcuse fertil2, clear //c7c15
	sum children
	tab elec
	bys elec:sum children
	reg children elec
	reg children elec age educ agesq urban catholic protest
	gen eleduc = elec*educ
	reg children elec age educ agesq urban catholic protest eleduc
	gen eleduc2 = elec*(educ - 7)
	reg children elec age educ agesq urban catholic protest eleduc2
	
bcuse catholic, clear //c7c16
	tab cathhs
	sum math12
	reg math12 cathhs
	reg math12 cathhs lfaminc motheduc fatheduc 
	gen cathfam = cathhs*lfaminc
	gen cathmoth = cathhs*motheduc
	gen cathfath = cathhs*fatheduc
	reg math12 cathhs lfaminc motheduc fatheduc cathfam cathmoth cathfath
	test cathfam cathmoth cathfath
	

	
	

	
	
	
	
	

	
	
	
	
	

	
	
	

	
	
	
	
	
	

	

	
	
	
	
	
	
	
	
	
	
	


































 

















