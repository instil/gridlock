//
//  GridLockViewController.swift
//  GridLock
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import UIKit

enum LineOrientation {
    case vertical
    case horizontal
}

class GridLockViewController: UIViewController {
    
    var lines: [UIView] = []
    let lineColor: UIColor
    let lineWidth: CGFloat
    var deferredEdgeSystemGestures: UIRectEdge = []
    
    init(lineColor: UIColor = .blue, lineWidth: CGFloat = 2.0) {
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
        self.view.addGestureRecognizer(buildScreenEdgePanGestureRecognizerFor(edge: .bottom))
        self.view.addGestureRecognizer(buildScreenEdgePanGestureRecognizerFor(edge: .top))
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return self.deferredEdgeSystemGestures
    }
    
    func disable() {
        self.removeAllLines()
        self.enableSystemGestures()
    }
    
    func enable() {
        self.disableSystemGestures()
    }
    
    private func removeAllLines() {
        lines.forEach { $0.removeFromSuperview() }
        lines.removeAll()
    }
    
    private func enableSystemGestures() {
        self.deferredEdgeSystemGestures = []
        self.setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
    }
    
    private func disableSystemGestures() {
        self.deferredEdgeSystemGestures = [.bottom, .top]
        self.setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
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
    
    private func buildHorizontalLine(y: CGFloat) -> UIView {
        let width = self.view.bounds.width
        let verticalLine = UIView(frame: CGRect(x: 0, y: y, width: width, height: lineWidth))
        verticalLine.backgroundColor = self.lineColor
        return verticalLine
    }
    
    private func edgePanDidBegin(position: CGFloat, orientation: LineOrientation) {
        let view = (orientation == .vertical) ? buildVerticalLine(x: position) : buildHorizontalLine(y: position)
        lines.append(view)
        self.view.addSubview(view)
        self.view.layoutIfNeeded()
    }
    
    private func edgePanDidChange(position: CGFloat, orientation: LineOrientation) {
        guard let view = lines.last else {
            return
        }
        
        switch orientation {
        case .vertical:
            view.frame.origin.x = position
        default:
            view.frame.origin.y = position
        }
        
        self.view.layoutIfNeeded()
    }
    
    private func handleEdgePan(gesture: UIScreenEdgePanGestureRecognizer, orientation: LineOrientation) {
        let location = gesture.location(in: self.view)
        let position = (orientation == .vertical) ? location.x : location.y
        
        if gesture.state == .began {
            self.edgePanDidBegin(position: position, orientation: orientation)
        } else if gesture.state == .changed {
            self.edgePanDidChange(position: position, orientation: orientation)
        } else if gesture.state == .ended {
            self.setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
        }
    }
    
    @objc func handleEgdePan(gesture: UIScreenEdgePanGestureRecognizer) {
        switch gesture.edges {
        case .left, .right:
            self.handleEdgePan(gesture: gesture, orientation: .vertical)
        default:
            self.handleEdgePan(gesture: gesture, orientation: .horizontal)
        }
    }
    
    
}
