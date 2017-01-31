//
//  CollectionCell.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

protocol CollectionCellDelegate: class {
    func beginLongPress(cell: CollectionCell)
    func endLongPress(cell: CollectionCell)
    func moved(cell: CollectionCell, center: CGPoint)
}

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    fileprivate let vibrateAnimationKey = "vibrate"
    fileprivate var initialCenter: CGPoint?
    
    weak var delegate: CollectionCellDelegate?
    
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gesture:)))
        addGestureRecognizer(longPress)
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
}

extension CollectionCell: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
 
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }

    func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            guard let view = gesture.view else {
                return
            }
            
            delegate?.beginLongPress(cell: self)
            // Stop vibrating
            self.isHidden = true
            vibrate(false)
            
            initialCenter = gesture.location(in: view.superview)
        }
        else if gesture.state == .changed {
            guard let originalCenter = initialCenter else {
                return
            }

            guard let view = gesture.view else {
                return
            }
            
            let point = gesture.location(in: view.superview)
            
            // Calculate new center position
            var newCenter = view.center;
            newCenter.x += point.x - originalCenter.x;
            newCenter.y += point.y - originalCenter.y;
            
            // Notify delegate
            delegate?.moved(cell: self, center: newCenter)
        }
        else if gesture.state == .ended {
            delegate?.endLongPress(cell: self)
            // Start vibrating
            self.isHidden = false
            vibrate(true)
        }
    }
}


