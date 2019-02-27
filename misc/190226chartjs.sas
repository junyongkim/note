resetline;
option nodate nonumber ls=128 ps=max;
filename tbmics temp;
proc http method="get" out=tbmics
    url="http://www.sca.isr.umich.edu/files/tbmics.csv";
run;
proc import datafile=tbmics dbms=csv out=tbmics;
run;
data _190226chartjs1(keep=x y);
    format x y;
    set tbmics(rename=(ICS_ALL=y));
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
proc import datafile=FEDFUNDS dbms=csv out=FEDFUNDS;
run;
data _190226chartjs2(keep=x y);
    format x y;
	set FEDFUNDS(rename=(FEDFUNDS=y));
	x=year(DATE)+month(DATE)/12;
run;
proc export data=_190226chartjs2 replace
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190226chartjs2.csv';
run;
quit;
