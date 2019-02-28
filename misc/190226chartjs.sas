resetline;
option nodate nonumber ls=128 ps=max;
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
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190226chartjs1.csv';
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
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190226chartjs2.csv';
run;
filename cay_curr temp;
proc http method="get" out=cay_curr
    url='https://drive.google.com/uc?export=download&id=1upTaL-6iv-9BI8TI_qgKxyCMk1nkVX7L';
run;
data _190226chartjs3;
    infile cay_curr dsd firstobs=3;
    input x cpce a y cay;
    x=int(x/100)+mod(x,100)/4;
    drop cpce--y;
    rename cay=y;
run;
proc export data=_190226chartjs3 replace
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190226chartjs3.csv';
run;
filename FF5F23Z1 "%sysfunc(getoption(WORK))\F-F_Research_Data_5_Factors_2x3_CSV.zip";
filename FF5F23Z2 zip "%sysfunc(getoption(WORK))\F-F_Research_Data_5_Factors_2x3_CSV.zip";
proc http method="get" out=FF5F23Z1
    url="http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_5_Factors_2x3_CSV.zip";
run;
data _190226chartjs4(keep=x y1-y6);
    infile FF5F23Z2(F-F_Research_Data_5_Factors_2x3.CSV) dsd firstobs=5;
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
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190226chartjs4.csv';
run;
filename liq_data temp;
proc http method="get" out=liq_data
    url="http://finance.wharton.upenn.edu/~stambaug/liq_data_1962_2017.txt";
run;
data _190227chartjs1(keep=x y);
    infile liq_data expandtabs firstobs=12;
    input x y InnovLiq TradedLiq;
    x=int(x/100)+mod(x,100)/12;
run;
proc export data=_190227chartjs1 replace
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190227chartjs1.csv';
run;
filename IPOALL "%sysfunc(getoption(WORK))\IPOALL_2018.xlsx";
proc http method="get" out=IPOALL
    url="https://site.warrington.ufl.edu/ritter/files/2019/01/IPOALL_2018.xlsx";
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
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190227chartjs2.csv';
run;
quit;
