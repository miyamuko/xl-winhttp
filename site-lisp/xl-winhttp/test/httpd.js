/**
 * Module dependencies.
 */

var express = require('express')

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});


// Routes

app.get('/chunked', function(req, res) {
    var send_chunk = function(res, n) {
        setTimeout(function() {
            var chunk = "chunk data " + n + "\n";
            if (n == 0) {
                console.log("End chunk");
                res.end(chunk);
            } else {
                console.log("Send chunk: %d", n);
                res.write(chunk);
                send_chunk(res, n - 1);
            }
        }, 2 * 1000);
    };

    setTimeout(function() {
        res.writeHead(200, {
            'Content_type': 'text/plain',
            'Transfer-Encoding': 'chunked',
        });
        send_chunk(res, 10);
    }, 2 * 1000);
});

app.listen(3000);
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
