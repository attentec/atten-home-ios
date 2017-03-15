var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
target.frontMostApp().tabBar().buttons()["Statistics"].tap();
target.delay(1);
window.scrollViews()[0].elements()[2].tap();
window.scrollViews()[0].elements()[1].tap();
target.delay(5);