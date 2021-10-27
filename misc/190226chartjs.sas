dm "log;clear;output;clear;";
resetline;
option nodate nonumber ls=128 ps=max;
proc datasets lib=work kill nolist;
run;
filename tbmics temp;
proc http method="get" out=tbmics
    url="http://www.sca.isr.umich.edu/files/tbmics.csv";
run;
proc import datafile=tbmics dbms=csv out=_190226chartjs1;
run;
data _190226chartjs1(keep=x y);
    format x y;
    set _190226chartjs1(rename=(ICS_ALL=y));
    x=input("1"||substr(Month,1,3)||put(YYYY,4.),date8.);
    x=year(x)+month(x)/12;
run;
proc export data=_190226chartjs1 replace
    outfile='!USERPROFILE\Desktop\190226chartjs1.csv';
run;
filename FEDFUNDS temp;
proc http method="get" out=FEDFUNDS
    url='https://fred.stlouisfed.org/graph/fredgraph.csv?id=FEDFUNDS';
run;
proc import datafile=FEDFUNDS dbms=csv out=_190226chartjs2;
run;
data _190226chartjs2(keep=x y);
    format x y;
    set _190226chartjs2(rename=(FEDFUNDS=y));
    x=year(DATE)+month(DATE)/12;
run;
proc export data=_190226chartjs2 replace
    outfile='!USERPROFILE\Desktop\190226chartjs2.csv';
run;
filename cay_curr temp;
proc http method="get" out=cay_curr
    url='https://drive.google.com/uc?export=download&id=1iju5xUGE0l7ZnFHMZtFDzunI0V85Zi5y';
run;
data _190226chartjs3;
    infile cay_curr dsd firstobs=2;
    input x yymmdd10. +1 c w y cay;
    x=year(x)+month(x)/12;
    drop c--y;
    rename cay=y;
run;
proc export data=_190226chartjs3 replace
    outfile='!USERPROFILE\Desktop\190226chartjs3.csv';
run;
filename FF5F23Z1 "%sysfunc(getoption(WORK))\F-F_Research_Data_5_Factors_2x3_CSV.zip";
filename FF5F23Z2 zip "%sysfunc(getoption(WORK))\F-F_Research_Data_5_Factors_2x3_CSV.zip";
proc http method="get" out=FF5F23Z1
    url="http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_5_Factors_2x3_CSV.zip";
run;
data _190226chartjs4(keep=x y1-y6);
    infile FF5F23Z2(F-F_Research_Data_5_Factors_2x3.csv) dsd firstobs=5;
    input x Mkt_RF SMB HML RMW CMA RF;
    if x then n+1;
    if n=_n_;
    x=int(x/100)+mod(x,100)/12;
    array r(*) Mkt_RF--RF;
    array l(*) l1-l6;
    array y(*) y1-y6;
    do i=1 to dim(r);
        l(i)+log(1+r(i)/100);
        y(i)=100*exp(l(i));
    end;
run;
proc export data=_190226chartjs4 replace
    outfile='!USERPROFILE\Desktop\190226chartjs4.csv';
run;
filename liq_data temp;
proc http method="get" out=liq_data
    url="http://finance.wharton.upenn.edu/~stambaug/liq_data_1962_2020.txt";
run;
data _190227chartjs1(keep=x y);
    infile liq_data expandtabs firstobs=12;
    input x y InnovLiq TradedLiq;
    x=int(x/100)+mod(x,100)/12;
run;
proc export data=_190227chartjs1 replace
    outfile='!USERPROFILE\Desktop\190227chartjs1.csv';
run;
filename IPOALL "%sysfunc(getoption(WORK))\IPOALL_2020.xlsx";
proc http method="get" out=IPOALL
    url="https://site.warrington.ufl.edu/ritter/files/IPOALL_2020.xlsx";
run;
proc import datafile=IPOALL dbms=excel out=_190227chartjs2 replace;
    getnames=no;
run;
proc datasets lib=WORK nolist;
    modify _190227chartjs2;
    attrib _all_ label="";
run;
data _190227chartjs2(keep=x y1-y4);
    format x y1-y4;
    set _190227chartjs2(keep=F1-F6 rename=(F3=y1 F4=y2));
    if F2<60 then x=2000+F2+F1/12;
    else x=1900+F2+F1/12;
    if x;
    y3=input(F5,4.);
    y4=input(F6,4.);
run;
proc export data=_190227chartjs2 replace
    outfile='!USERPROFILE\Desktop\190227chartjs2.csv';
run;
filename ie_data "%sysfunc(getoption(WORK))\ie_data.xlsx";
proc http method="get" out=ie_data
    url="http://www.econ.yale.edu/~shiller/data/ie_data.xls";
run;
proc import datafile=ie_data dbms=excel out=_190227chartjs3 replace;
    sheet="Data";
    getnames=no;
run;
data _190227chartjs3(keep=x y);
    set _190227chartjs3;
    x=int(F1)+mod(100*F1,100)/12;
    y=input(F13,8.2);
    if y;
run;
proc export data=_190227chartjs3 replace
    outfile='!USERPROFILE\Desktop\190227chartjs3.csv';
run;
filename Betting "%sysfunc(getoption(WORK))\Betting-Against-Beta-Equity-Factors-Monthly.xlsx";
proc http method="get" out=Betting
    url="https://images.aqr.com/-/media/AQR/Documents/Insights/Data-Sets/Betting-Against-Beta-Equity-Factors-Monthly.xlsx";
run;
proc import datafile=Betting dbms=excel out=_190227chartjs4 replace;
    sheet="BAB Factors";
    getnames=no;
run;
data _190227chartjs4(keep=x y);
    set _190227chartjs4;
    x=input(F1,mmddyy10.);
    x=year(x)+month(x)/12;
    if x>1963.5;
    l+log(1+input(F25,percent8.2));
    y=100*exp(l);
run;
proc export data=_190227chartjs4 replace
    outfile='!USERPROFILE\Desktop\190227chartjs4.csv';
run;
quit;
