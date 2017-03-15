var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
window.scrollViews()[0].elements()[1].tap();
target.delay(1);