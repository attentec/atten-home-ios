var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
target.frontMostApp().tabBar().buttons()["Statistics"].tap();
target.delay(1);