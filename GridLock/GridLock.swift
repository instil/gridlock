//
//  GridLock.swift
//  GridLock
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import Foundation

public class GridLock {
    
    var gridlockWindow: UIWindow?
    let appDelegate: UIApplicationDelegate
    
    public init(appDelegate: UIApplicationDelegate, frame: CGRect) {
        self.appDelegate = appDelegate
        self.createGridLockWindow(frame: frame)
    }
    
    func createGridLockWindow(frame: CGRect) {
        gridlockWindow = UIWindow(frame: frame)
        gridlockWindow?.rootViewController = GridLockViewController()
        gridlockWindow?.windowLevel = UIWindow.Level(.greatestFiniteMagnitude)
        gridlockWindow?.makeKeyAndVisible()
        gridlockWindow?.isUserInteractionEnabled = false
    }
    
}
