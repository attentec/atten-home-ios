var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
app.tabBar().buttons()["Stats"].tap();
target.delay(1);