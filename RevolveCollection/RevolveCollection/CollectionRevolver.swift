//
//  CollectionRevolver.swift
//  RevolveCollection
//
//  Created by Hari Kunwar on 3/2/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

class CollectionRevolver: NSObject {
    private var dataSource: [Any]?
    private weak var collectionView: UICollectionView?
    private var observerContext = 0
    private let contentOffsetKeyPath = "contentOffset"
    private var updateTriggerValue: CGFloat = 0.0

    init(with collectionView: UICollectionView, dataSource: [Any]) {
        super.init()
        self.dataSource = dataSource
        self.collectionView = collectionView
        self.collectionView?.addObserver(self, forKeyPath: contentOffsetKeyPath, options: [.new, .old], context: &observerContext)
        self.updateTriggerValue = collectionView.contentSize.height/2
    }
 
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let collectionView = self.collectionView else {
            return
        }
        
        if keyPath == contentOffsetKeyPath {
            // Check if bottom item is last or first index.
            // If yes add first or last item from dataSource.
            let topY = collectionView.contentOffset.y
            let bottomPoint = CGPoint(x: 10, y: topY + collectionView.bounds.height)
            let topPoint = CGPoint(x: 10, y: topY)
            
            let bottomVisibleIndexPath = collectionView.indexPathForItem(at: bottomPoint)
            let topVisibleIndexPath = collectionView.indexPathForItem(at: topPoint)
            
            
            
            
           let shouldUpdate = collectionView.contentOffset.y > collectionView.contentSize.height/2
        }
    }
    
    func updateCollection() {
        // Delete hidden item from collection view and dataSouce.
        // Insert this deleted item to collection view and dataSource in opposite position.
        
    }
    
}
