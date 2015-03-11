class window.BaseChart
  constructor: (@chart_div_id) ->
    @$chart_div = $("##{@chart_div_id}")
    url = @$chart_div.attr('data-url')
    @api_client = new window.APIClient(url)
    @init()

  init: ->
    throw "Override me!"
