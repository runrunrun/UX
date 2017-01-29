//
//  CollectionCell.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func longPressedCollectionCell(cell: CollectionCell)
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerViewWidth: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    let containerPadding: CGFloat = 20
    
    private var isActive = false
    private var longPress: UILongPressGestureRecognizer?
    
    private var scaleUp: CABasicAnimation?
    private var vibrate: CABasicAnimation?
    private let vibrateAnimationKey = "vibrate"
    
    private let scaleValue = 1.2
    private let scaleDuration = 0.1

    weak var delegate: CollectionCellDelegate?
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if longPress == nil {
            longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gesture:)))
            addGestureRecognizer(longPress!)
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            vibrate(isEditing)
        }
    }

    func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            delegate?.longPressedCollectionCell(cell: self)
            
            // Stop vibrating
            vibrate(false)
            
            // Scale Up
            scaleUp = CABasicAnimation(keyPath: "transform.scale")
            scaleUp?.fromValue = 1.0
            scaleUp?.toValue = scaleValue
            scaleUp?.duration = scaleDuration
            scaleUp?.fillMode = kCAFillModeForwards
            scaleUp?.isRemovedOnCompletion = false
            layer.add(scaleUp!, forKey: "scalingUp")
        }
        
        if gesture.state == .ended {
            // Scale Down
            let scaleDown = CABasicAnimation(keyPath: "transform.scale")
            scaleDown.fromValue = scaleValue
            scaleDown.toValue = 1.0
            scaleDown.duration = scaleDuration
            layer.add(scaleDown, forKey: "scalingDown")
            layer.removeAnimation(forKey: "scalingUp")
            
            vibrate(true)
        }
    }
    
    private func vibrate(_ start: Bool) {
        if start {
            let isVibrating = layer.animation(forKey: vibrateAnimationKey) != nil
            if !isVibrating {
                // Vibrate
                let angle = Float.pi/72 // 2.5 degree
                vibrate = CABasicAnimation(keyPath: "transform.rotation")
                vibrate?.beginTime = CACurrentMediaTime() + scaleDuration
                vibrate?.duration = 0.15
                vibrate?.fromValue = -angle
                vibrate?.toValue = angle
                vibrate?.autoreverses = true
                vibrate?.repeatCount = .infinity
                layer.add(self.vibrate!, forKey: vibrateAnimationKey)
            }
        }
        else {
            layer.removeAnimation(forKey: vibrateAnimationKey)
        }
    }
}
