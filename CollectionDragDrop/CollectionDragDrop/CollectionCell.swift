//
//  CollectionCell.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func didMoveToWindow() {
        super.didMoveToWindow()
    
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(editMode(_:)))
        self.addGestureRecognizer(longPress)
    }
    
    func editMode(_ active: Bool) {
        if active {
            
        }
        else {
        
        }
    }
    
}
