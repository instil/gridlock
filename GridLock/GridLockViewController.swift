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
    let lineColor: UIColor
    let lineWidth: CGFloat
    
    init(lineColor: UIColor = .blue, lineWidth: CGFloat = 5.0) {
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        self.view.addGestureRecognizer(buildScreenEdgePanGestureRecognizerFor(edge: .left))
        self.view.addGestureRecognizer(buildScreenEdgePanGestureRecognizerFor(edge: .right))
    }
    
    func reset() {
        lines.forEach { $0.removeFromSuperview() }
        lines.removeAll()
    }
    
    private func buildScreenEdgePanGestureRecognizerFor(edge: UIRectEdge) -> UIGestureRecognizer {
        let gestureRecogniser = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEgdePan))
        gestureRecogniser.edges = edge
        return gestureRecogniser
    }
    
    private func buildVerticalLine(x: CGFloat) -> UIView {
        let height = self.view.bounds.height
        let verticalLine = UIView(frame: CGRect(x: x, y: 0, width: lineWidth, height: height))
        verticalLine.backgroundColor = self.lineColor
        return verticalLine
    }
    
    private func edgePanDidBegin(gestureXPosition: CGFloat) {
        let view = buildVerticalLine(x: gestureXPosition)
        lines.append(view)
        self.view.addSubview(view)
        self.view.layoutIfNeeded()
    }
    
    private func edgePanDidChange(gestureXPosition: CGFloat) {
        guard let view = lines.last else {
            return
        }
        
        view.frame.origin.x = gestureXPosition
        self.view.layoutIfNeeded()
    }
    
    @objc func handleEgdePan(gesture: UIScreenEdgePanGestureRecognizer) {
        let location = gesture.location(in: self.view)
    
        if gesture.state == .began {
            self.edgePanDidBegin(gestureXPosition: location.x)
        } else if gesture.state == .changed {
            self.edgePanDidChange(gestureXPosition: location.x)
        }
    }
    
}
