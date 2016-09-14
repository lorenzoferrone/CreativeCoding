var app = require('app')
var bw = require('browser-window')
var ipc = require('ipc')
var fs = require('fs')

app.on('ready', function(){
    mw = new bw({
        width: 1200,
        height: 640,
    })
    mw.loadUrl('file://' + __dirname + '/index.html');
    // mw.openDevTools();

    return mw
});
app.commandLine.appendSwitch('enable-javascript-harmony')
