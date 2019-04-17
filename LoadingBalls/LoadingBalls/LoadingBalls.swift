//
//  LoadingBalls.swift
//  LoadingBalls
//
//  Created by Hari Kunwar on 4/16/19.
//  Copyright © 2019 Learning. All rights reserved.
//

import UIKit

class LoadingBalls: UIView {
    private var numberOfBalls: Int = 0
    private var balls: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(numberOfBalls: Int) {
        self.init(frame: CGRect.zero)
        self.numberOfBalls = numberOfBalls
        setupBalls()
    }
    
    override var intrinsicContentSize: CGSize {
        let count = CGFloat(numberOfBalls)
        let width = count*Constant.ballDiameter + (count-1)*Constant.ballGap
        return CGSize(width: width, height: Constant.ballDiameter)
    }
    
    private func setupBalls() {
        // Setup First ball
        let ball = ballView()
        balls.append(ball)
        addSubview(ball)

        ball.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup constraints
        NSLayoutConstraint.activate([
            ball.leftAnchor.constraint(equalTo: leftAnchor),
            ball.centerYAnchor.constraint(equalTo: centerYAnchor),
            ball.widthAnchor.constraint(equalToConstant: Constant.ballDiameter),
            ball.heightAnchor.constraint(equalToConstant: Constant.ballDiameter)
            ])
        
        var previousView = ball

        // Setup other balls
        for _ in 1..<numberOfBalls {
            let ball = ballView()
            balls.append(ball)
            addSubview(ball)
            
            ball.translatesAutoresizingMaskIntoConstraints = false
            
            // Setup constraints
            NSLayoutConstraint.activate([
                ball.leftAnchor.constraint(equalTo: previousView.rightAnchor,
                                           constant: Constant.ballGap),
                ball.centerYAnchor.constraint(equalTo: centerYAnchor),
                ball.widthAnchor.constraint(equalToConstant: Constant.ballDiameter),
                ball.heightAnchor.constraint(equalToConstant: Constant.ballDiameter)
                ])
            
            previousView = ball
        }
    }
    
    private func ballView() -> UIView {
        let ball = UIView()
        ball.backgroundColor = UIColor.red
        ball.layer.cornerRadius = Constant.ballDiameter/2
        return ball
    }
}

private extension LoadingBalls {
    enum Constant {
        static let ballDiameter: CGFloat = 40
        static let ballGap: CGFloat = 20
    }
    
}
