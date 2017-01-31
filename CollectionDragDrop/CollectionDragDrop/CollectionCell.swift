//
//  CollectionCell.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func touched(cell: CollectionCell)
    func beginLongPress(cell: CollectionCell)
    func endLongPress(cell: CollectionCell)
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    fileprivate let vibrateAnimationKey = "vibrate"
    
    weak var delegate: CollectionCellDelegate?
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gesture:)))
        addGestureRecognizer(longPress)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panning(gesture:)))
        addGestureRecognizer(pan)
        
        
    }
    
    var isEditing: Bool = false {
        didSet {
            vibrate(isEditing)
        }
    }
    
    fileprivate func vibrate(_ start: Bool) {
        if start {
            let isVibrating = layer.animation(forKey: vibrateAnimationKey) != nil
            if !isVibrating {
                // Vibrate
                let angle = Float.pi/72 // 2.5 degree
                let vibrate = CABasicAnimation(keyPath: "transform.rotation")
                vibrate.beginTime = CACurrentMediaTime()
                vibrate.duration = 0.15
                vibrate.fromValue = -angle
                vibrate.toValue = angle
                vibrate.autoreverses = true
                vibrate.repeatCount = .infinity
                layer.add(vibrate, forKey: vibrateAnimationKey)
            }
        }
        else {
            layer.removeAnimation(forKey: vibrateAnimationKey)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        delegate?.touched(cell: self)
    }
}

extension CollectionCell: UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }

    
    func longPressAction(gesture: UILongPressGestureRecognizer) {
        
        if gesture.state == .began {
            delegate?.beginLongPress(cell: self)
            // Stop vibrating
            self.isHidden = true
            vibrate(false)
        }
        
        if gesture.state == .ended {
            delegate?.endLongPress(cell: self)
            // Start vibrating
            self.isHidden = false
            vibrate(true)
        }
    }
}

extension CollectionCell {
    func panning(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
        
        }
        
    }
}

