//
//  ViewController.swift
//  LoadingBalls
//
//  Created by Hari Kunwar on 4/16/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var loadingBalls: LoadingBalls?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadingBalls = LoadingBalls(numberOfBalls: 3)
        loadingBalls?.backgroundColor = UIColor.gray
        
        if let loadingBalls = loadingBalls {
            view.addSubview(loadingBalls)
            loadingBalls.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                loadingBalls.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingBalls.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
        }
    }


}

