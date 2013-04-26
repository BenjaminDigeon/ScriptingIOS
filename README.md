Scripting iOS
============

Screenshots
---------

![Screenshot1](https://raw.github.com/BenjaminDigeon/ScriptingIOS/master/screenshots/Capture1.png)
![Screenshot2](https://raw.github.com/BenjaminDigeon/ScriptingIOS/master/screenshots/Capture2.png)

Local Setup
---------

Gem and Pod setup:

    gem install cocoapods
    pod setup
    pod install


If anything is missing from Pods/Headers

`rm -rf Pods/ && pod install`

If the build fails with a bunch of redefined header issues try manually cleaning your xcode build location, usually:

`rm -rf ~/Library/Developer/Xcode/DerivedData`

Clear Cocoapods cache

`rm -rf ~/Library/Caches/CocoaPods/`


License
---------

See LICENSE.txt
