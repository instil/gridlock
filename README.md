

![GridLock](https://github.com/instil/gridlock/raw/master/media/GridLockLogo.png)


-----------------

Draw helpful gridlines on your iOS app

# Adding GridLock to your app

Add `import GridLock` to `AppDelegate.swift`

Replace the `var window: UIWindow?` in `AppDelegate.swift` with:

    var gridLock = GridLock()
    var window: UIWindow? {
        get {
            return gridLock.window
        }
        set { }
    }

# Activating GridLock

## Device

Simply shake your device to activate GridLock, then drag grid lines from left or right of the screen.

Shake your device again to disable GridLock and remove all grid lines.

## Simulator

From the Simulator menu choose `hardware > shake gesture` or

Use the keyboard shortcut <kbd>^⌘Z</kbd>
