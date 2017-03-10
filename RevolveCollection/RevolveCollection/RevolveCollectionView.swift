//
//  RevolveCollectionView.swift
//  RevolveCollection
//
//  Created by Hari Kunwar on 3/2/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

protocol RevolveCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
}

protocol RevolveCollectionViewDataSource: UICollectionViewDataSource {
    
}

class RevolveCollectionView: UICollectionView {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
