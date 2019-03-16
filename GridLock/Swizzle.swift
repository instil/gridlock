//
//  Swizzle.swift
//  GridLock
//
//  Created by Stevey Brown on 16/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import Foundation

private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

extension UIApplication {
    
    static let initialiseSwizzleMotionEvent: Void = {
        let originalSelector = #selector(motionBegan(_:with:))
        let swizzledSelector = #selector(swizzledMotionBegan(_:with:))
        swizzling(UIApplication.self, originalSelector, swizzledSelector)
    }()
    
    static let initialiseSwizzleTouchBeganEvent: Void = {
        let originalSelector = #selector(touchesBegan(_:with:))
        let swizzledSelector = #selector(swizzledTouchesBegan(_:with:))
        swizzling(UIApplication.self, originalSelector, swizzledSelector)
    }()
    
    static let initialiseSwizzleTouchMovedEvent: Void = {
        let originalSelector = #selector(touchesMoved(_:with:))
        let swizzledSelector = #selector(swizzledTouchesMoved(_:with:))
        swizzling(UIApplication.self, originalSelector, swizzledSelector)
    }()
    
    static let initialiseSwizzleTouchEndedEvent: Void = {
        let originalSelector = #selector(touchesEnded(_:with:))
        let swizzledSelector = #selector(swizzledTouchesEnded(_:with:))
        swizzling(UIApplication.self, originalSelector, swizzledSelector)
    }()
    
    @objc func swizzledMotionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            GridLock.shared.isActive = !GridLock.shared.isActive
        }
        
        // Run default implementation of Apps UIApplication
        swizzledMotionBegan(motion, with: event)
    }
    
    @objc func swizzledTouchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first else { return }
        
        if GridLock.shared.isActive {
            GridLock.shared.controller.touchStarted(touchLocation)
        }
        
        //        swizzledTouchesBegan(touches, with: event)
    }
    
    @objc func swizzledTouchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first else { return }
        
        if GridLock.shared.isActive {
            GridLock.shared.controller.touchMoved(touchLocation)
        }
        
        //        swizzledTouchesBegan(touches, with: event)
    }
    
    @objc func swizzledTouchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first else { return }
        
        if GridLock.shared.isActive {
            GridLock.shared.controller.touchEnded(touchLocation)
        }
        
        //        swizzledTouchesEnded(touches, with: event)
    }
}

