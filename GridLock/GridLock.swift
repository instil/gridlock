//
//  GridLock.swift
//  GridLock
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import Foundation

public class GridLock {
    public init() {}
    
    var gridLockWindow: GridLockAppWindow?
    public var window: UIWindow? {
        get {
            #if DEBUG
                gridLockWindow = gridLockWindow ?? GridLockAppWindow(frame: UIScreen.main.bounds)
                return gridLockWindow
            #else
                return nil
            #endif
        }
        set {}
    }
}

public class GridLockAppWindow: UIWindow {
    
    public var gridlockWindow: UIWindow?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.gridlockWindow = GridLockWindow(frame: frame, nextUIResponder: self.next)
    }
    
    public override var next: UIResponder? {
        get {
            return self.gridlockWindow
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
