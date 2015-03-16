class window.WSClient
  constructor: (@chart, protocol) ->
    url = "#{protocol}://" + location.host +  "/ws"
    @socket = new Phoenix.Socket(url);
    @init()

  init: ->
    @socket.join "data:#{@chart.token}", {}, (channel) =>
      window.chan = channel

      channel.on "join", (message) ->
        console.log("joined")
        console.log(message)

      channel.on "update", (message) =>
        console.log("update")
        @chart.update()
        console.log(message)
