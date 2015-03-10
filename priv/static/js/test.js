
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
