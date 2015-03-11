class window.APIClient
  constructor: (@url) ->
    console.log(@url)
    $.getJSON(@url, {"format" : "json"}, @draw_chart)



  get_data: (callback) ->
    $.getJSON(@url, {"format" : "json"}, callback)
