var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
var list = window.tableViews()[0];
UIALogger.logDebug("hej");
list.cells()[0].tap();
