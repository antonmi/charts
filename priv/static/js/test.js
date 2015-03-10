
var socket  = new Phoenix.Socket("/ws");

socket.join("data:source", {}, function(channel){

  window.chan = channel;

  channel.on("join", function(message){
    console.log("joined");
    console.log(message);
  });

  channel.on("new:msg", function(message){
    console.log("new:msg")
    console.log(message)
  });


});

google.setOnLoadCallback(drawChart);

google.load('visualization', '1.0', {'packages':['corechart']});

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Year', 'Sales', 'Expenses'],
    ['2004',  1000,      400],
    ['2005',  1170,      460],
    ['2006',  660,       1120],
    ['2007',  1030,      540]
  ]);

  var options = {
    title: 'Company Performance',
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

  chart.draw(data, options);
}
