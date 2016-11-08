var {app, BrowserWindow} = require('electron')


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
