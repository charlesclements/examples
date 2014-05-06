io = require('socket.io').listen(4000)
io.sockets.on 'connection', (socket) ->