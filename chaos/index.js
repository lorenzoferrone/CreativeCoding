const {app, BrowserWindow} = require('electron')
// var bw = require('browser-window')
// var ipc = require('ipc')
var fs = require('fs')
// require('coffee-script').register()

app.on('ready', function(){
    mw = new BrowserWindow({
        width: 1300,
        height: 750,
    })
    mw.loadURL('file://' + __dirname + '/index.html');
    mw.openDevTools();

    return mw
});

app.commandLine.appendSwitch('enable-javascript-harmony')
