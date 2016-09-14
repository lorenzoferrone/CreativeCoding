var app = require('app')
var bw = require('browser-window')
var ipc = require('ipc')
var fs = require('fs')
// require('coffee-script').register()

app.on('ready', function(){
    mw = new bw({
        width: 1300,
        height: 750,
    })
    mw.loadUrl('file://' + __dirname + '/index.html');
    mw.openDevTools();

    return mw
});
app.commandLine.appendSwitch('enable-javascript-harmony')
