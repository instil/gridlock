//
//  GridLock.swift
//  GridLock
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import Foundation

public class GridLock {
    public static var shared = GridLock()
    
    public var isActive = false {
        didSet {
            isActive ? activate() : deactivate()
        }
    }
    
    let controller = GridLockViewController()
    
    private let window: UIWindow
    private var isConfigured: Bool = false
    
    private init() {
        guard let applicationFrame = UIApplication.shared.windows.first?.frame else {
            fatalError("Unabled to determine application frame")
        }
        
        window = UIWindow(frame: applicationFrame)
        window.rootViewController = controller
        window.windowLevel = UIWindow.Level(.greatestFiniteMagnitude)
        window.makeKeyAndVisible()
        window.isUserInteractionEnabled = false
    }
    
    /// Initlises GridLock
    public func configure() {
        assert(_isDebugAssertConfiguration(), "GridLock is intended for use during development builds only")
        UIApplication.initialiseSwizzleMotionEvent
        UIApplication.initialiseSwizzleTouchBeganEvent
        UIApplication.initialiseSwizzleTouchMovedEvent
        UIApplication.initialiseSwizzleTouchEndedEvent
        isConfigured = true
    }
    
    /// Activates GridLock - applies an faint white canvas over current view
    public func activate() {
        assert(isConfigured, "Configure must be called before activate()")
        controller.activate()
    }
    
    /// Deactivates GridLock and resets canvas
    public func deactivate() {
        assert(isConfigured, "Configure must be called before deactivate()")
        controller.deactivate()
    }

}
