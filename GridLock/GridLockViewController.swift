//
//  GridLockViewController.swift
//  GridLock
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import UIKit

class GridLockViewController: UIViewController {
    
    var lines: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.becomeFirstResponder()
        
        let gestureRecogniser = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEgdePan))
        gestureRecogniser.edges = .left
        self.view.addGestureRecognizer(gestureRecogniser)
        
    }
    
    func buildVerticalLine(x: CGFloat) -> UIView {
        let height = self.view.bounds.height
        let verticalLine = UIView(frame: CGRect(x: x, y: 0, width: 5, height: height))
        verticalLine.backgroundColor = .blue
        return verticalLine
    }
    
    @objc func handleEgdePan(gesture: UIScreenEdgePanGestureRecognizer) {
        let location = gesture.location(in: self.view)
    
        if gesture.state == .began {
            let view = buildVerticalLine(x: location.x)
            lines.append(view)
            self.view.addSubview(view)
            
            UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            })
            
        } else if gesture.state == .changed {
            guard let view = lines.last else {
                return
            }
            
            view.frame.origin.x = location.x
            
            UIView.animate(withDuration: 0.0, delay: 0.0, options: .curveEaseOut, animations: {
                view.layoutIfNeeded()
            })
        }
    }
    
}
