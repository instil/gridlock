//
//  GridLockViewController.swift
//  GridLock
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import UIKit

class GridLockViewController: UIViewController {
    var markers: [UIView] = []
    var drawingLine: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }
    
    public func activate() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    public func deactivate() {
        markers.forEach { $0.removeFromSuperview() }
        drawingLine = nil
        view.backgroundColor = .clear
    }
    
    public func touchStarted(_ touch: UITouch) {
        view.backgroundColor = .clear
        let loc = touch.location(in: view)
        let targetFrame = CGRect(x: loc.x, y: 0, width: 2, height: self.view.frame.height)
        
        drawingLine = UIView(frame: targetFrame)
        drawingLine?.backgroundColor = .green
        drawingLine?.translatesAutoresizingMaskIntoConstraints = false
        
        // Ensure GridLock still active
        guard let line = drawingLine else { return }
        view.addSubview(line)
    }
    
    public func touchMoved(_ touch: UITouch) {
        let loc = touch.location(in: view)
        drawingLine?.frame.origin.x = loc.x
    }
    
    public func touchEnded(_ touch: UITouch) {
        guard let marker = drawingLine else { return }
        markers.append(marker)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    }
    
}
