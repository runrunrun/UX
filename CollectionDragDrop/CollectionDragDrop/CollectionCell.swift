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
    
    weak var delegate: CollectionCellDelegate?
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
                
        if longPress == nil {
            longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(gesture:)))
            self.addGestureRecognizer(longPress!)
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            
            guard containerViewWidth.constant > 0 else {
                print("Constraints not set yet")
                return
            }
            
            if isEditing {
                containerViewWidth.constant -= containerPadding
                containerViewHeight.constant -= containerPadding
            }
            else {
                containerViewWidth.constant += containerPadding
                containerViewHeight.constant += containerPadding
            }
        }
    }

    func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            delegate?.longPressedCollectionCell(cell: self)
        }
    }
    
}
