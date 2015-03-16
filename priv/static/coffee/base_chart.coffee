# coffee -j js/app.js -cw coffee/*.coffee
class window.BaseChart
  constructor: (@chart_div_id) ->
    @$chart_div = $("##{@chart_div_id}")
    url = @$chart_div.attr('data-url')
    @token = @$chart_div.attr('data-token')
    ws_protocol = @$chart_div.attr('data-ws-protocol')
    @api_client = new window.APIClient(url)
    @ws_client = new window.WSClient(@, ws_protocol)
    @init()
    @update()

  init: ->
  draw: ->

  update: ->
    @api_client.get_data(@draw_chart)

  draw_chart: (data) =>
    data = JSON.parse(data['data'])
    @draw(data)
