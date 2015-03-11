class window.APIClient
  constructor: (@url) ->
    console.log(@url)
    $.getJSON(@url, {"format" : "json"}, @draw_chart)

  draw_chart: (data) =>
    data = JSON.parse(data['data'])
    window.chart.draw(data)

  data: ->
    'ok'

# coffee -j js/app.js -cw coffee/*.coffee
