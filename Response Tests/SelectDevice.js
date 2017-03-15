var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
var list = window.tableViews()[0];
list.cells()[2].tap();
target.delay(1);