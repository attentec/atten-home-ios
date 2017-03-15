var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
window.elements()[4].tap();
target.delay(1);
