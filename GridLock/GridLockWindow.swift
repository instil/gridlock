//
//  GridLockWindow.swift
//  GridLock
//
//  Created by Matt Wilson on 20/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import Foundation

class GridLockWindow: UIWindow {
    
    let gridLockViewController: GridLockViewController
    var nextUIResponder: UIResponder?
    var isGridLockEnabled: Bool {
        didSet {
            self.isUserInteractionEnabled = isGridLockEnabled
            isGridLockEnabled ? self.gridLockViewController.enable() : self.gridLockViewController.disable()
        }
    }
    
    init(frame: CGRect, nextUIResponder: UIResponder?, gridLockViewController: GridLockViewController = GridLockViewController()) {
        self.nextUIResponder = nextUIResponder
        self.isGridLockEnabled = false
        self.gridLockViewController = gridLockViewController
        
        super.init(frame: frame)
        
        self.rootViewController = gridLockViewController
        self.windowLevel = UIWindow.Level(.greatestFiniteMagnitude)
        self.makeKeyAndVisible()
        self.isUserInteractionEnabled = false
    }
    
    override var next: UIResponder? {
        return self.nextUIResponder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            toggleGridLock()
        }
    }
    
    private func toggleGridLock() {
        self.isGridLockEnabled = !self.isGridLockEnabled
    }
    
    
}
