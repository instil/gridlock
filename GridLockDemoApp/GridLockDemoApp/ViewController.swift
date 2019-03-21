//
//  ViewController.swift
//  GridLockDemoApp
//
//  Created by Matt Wilson on 15/03/2019.
//  Copyright © 2019 Instil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        let button = UIButton(frame: .zero)
        button.setTitle("Hello World", for: .normal)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
    
    @objc func buttonPressed(sender: UIButton) {
        print("hello world")
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("motion in sample app")
    }
}

