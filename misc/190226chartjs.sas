resetline;
option nodate nonumber ls=128 ps=max;
filename tbmics temp;
proc http method="get" out=tbmics
    url="http://www.sca.isr.umich.edu/files/tbmics.csv";
run;
proc import datafile=tbmics dbms=csv out=tbmics;
run;
data _190226chartjs(keep=x y);
    format x y;
    set tbmics(rename=(ICS_ALL=y));
	x=input("1"||substr(Month,1,3)||put(YYYY,4.),date8.);
	x=year(x)+month(x)/12;
run;
proc export data=_190226chartjs replace
    outfile='%SystemDrive%\Users\%USERNAME\Desktop\190226chartjs.csv';
run;
quit;
