Chart.defaults.global.defaultFontFamily="'LM Mono 10',Consolas";
Chart.defaults.global.defaultFontSize=11*96/72;
Papa.parse("/notebook/misc/190220chartjs1.csv",{download:true,complete:function(results){
    new Chart(document.getElementById("Figure1"),
        {type:"line",
            data:{labels:results.data[0],
                datasets:[{label:"Quadratic",
                    data:results.data[1],
                    borderColor:"Blue",
                    backgroundColor:"Blue",
                    fill:false},{label:"Exponential",
                    data:results.data[2],
                    borderColor:"Red",
                    backgroundColor:"Red",
                    fill:false}]},
            options:{responsive:false}});
}});
Papa.parse("/notebook/misc/190220chartjs2.csv",{download:true,header:true,complete:function(results){
    results.data1=[];results.data2=[];for(i=0;i<results.data.length-1;i++){results.data1[i]={};results.data1[i].x=results.data[i].x;results.data1[i].y=results.data[i].y1;results.data2[i]={};results.data2[i].x=results.data[i].x;results.data2[i].y=results.data[i].y2;}
    new Chart(document.getElementById("Figure2"),
        {type:"scatter",
            data:{datasets:[{label:"Quadratic",
                    data:results.data1,
                    borderColor:"Blue",
                    backgroundColor:"Blue",
                    fill:false,
                    showLine:true},{label:"Exponential",
                    data:results.data2,
                    borderColor:"Red",
                    backgroundColor:"Red",
                    fill:false,
                    showLine:true}]},
            options:{responsive:false}});
}});
Papa.parse("/notebook/misc/190220chartjs3.csv",{download:true,header:true,complete:function(results){
    results.data1=[];results.data2=[];for(i=0;i<results.data.length-1;i++){results.data1[i]={};results.data1[i].x=results.data[i].x1;results.data1[i].y=results.data[i].y1;results.data2[i]={};results.data2[i].x=results.data[i].x2;results.data2[i].y=results.data[i].y2;}
    new Chart(document.getElementById("Figure3"),
        {type:"scatter",
            data:{datasets:[{label:"call streaminit(1)",
                    data:results.data1,
                    borderColor:"Blue",
                    backgroundColor:"Blue",
                    fill:false},{label:"call streaminit(2)",
                    data:results.data2,
                    borderColor:"Red",
                    backgroundColor:"Red",
                    fill:false}]},
            options:{responsive:false}});
}});
Papa.parse("/notebook/misc/190220chartjs4.csv",{download:true,complete:function(results){
    new Chart(document.getElementById("Figure4"),
        {type:"bar",
            data:{labels:results.data[0],
                datasets:[{label:"call streaminit(1)",
                    data:results.data[1],
                    borderColor:"Blue",
                    backgroundColor:"Blue",
                    fill:false},{type:"line",
                    label:'rand("normal",0,1)',
                    data:results.data[2],
                    borderColor:"Red",
                    backgroundColor:"Red",
                    fill:false,
                    pointRadius:0}]},
            options:{responsive:false,
                yAxes:[{ticks:{beginAtZero:true}}]}});
}});
Papa.parse("/notebook/misc/190220chartjs5.csv",{download:true,complete:function(results){
    new Chart(document.getElementById("Figure5"),
        {type:"horizontalBar",
            data:{labels:results.data[0],
                datasets:[{label:"call streaminit(1)",
                    data:results.data[1],
                    borderColor:"Blue",
                    backgroundColor:"Blue",
                    fill:false},{label:"call streaminit(2)",
                    data:results.data[2],
                    borderColor:"Red",
                    backgroundColor:"Red",
                    fill:false}]},
            options:{responsive:false,
                xAxes:[{ticks:{beginAtZero:true}}]}});
}});
