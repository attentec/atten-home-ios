var target = UIATarget.localTarget();
var app = target.frontMostApp();
app.navigationBar().leftButton().tap();
target.delay(1);