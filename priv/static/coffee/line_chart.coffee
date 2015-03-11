class window.LineChart extends window.BaseChart

  init:() ->
    @chart = new google.visualization.LineChart(document.getElementById(@chart_div_id));


  draw:(data) ->
    data = google.visualization.arrayToDataTable(data);

    options = {
      title: 'Company Performance',
      curveType: 'function',
      legend: { position: 'bottom' }
    };
    @chart.draw(data, options);
