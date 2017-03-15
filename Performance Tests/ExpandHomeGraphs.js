var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();
app.tabBar().buttons()["Stats"].tap();
window.tableViews()[0].cells()[0].tap();
window.tableViews()[0].cells()[1].tap();
target.delay(5);