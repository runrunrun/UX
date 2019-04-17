//
//  ViewController.swift
//  RevolveCollection
//
//  Created by Hari Kunwar on 3/2/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var items = [1, 2, 3, 4, 6]
    var revolveItems: [Int] = []
    fileprivate var topPulled: Bool = false
    fileprivate var firstLauch = true
    fileprivate var isSwappingCells = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        revolveItems.append(contentsOf: items)
        revolveItems.append(contentsOf: items)
        revolveItems.append(contentsOf: items)
        
        collectionView.performBatchUpdates({ 
            
        }) { (finished) in
            self.firstLauch = false
            let section = self.collectionView.numberOfSections - 1
            let indexPath = IndexPath(item: self.items.count, section: section)
            self.collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return revolveItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as! LabelCell
        let item = revolveItems[indexPath.item]
        cell.textLabel.text = "\(item)"
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Check if first cell will be displayed
        if indexPath.row == 0  {
//            if firstLauch || isSwappingCells {
//                return
//            }
//            
//            // Move last item to top
//            let lastItem = self.revolveItems.removeLast()
//            self.revolveItems.insert(lastItem, at: 0)
//            
//            // First and last indexPaths
//            let firstIndexPath = IndexPath(item: 0, section: 0)
//            let lastIndexPath = IndexPath(item: revolveItems.count - 1, section: 0)
//            
//            self.isSwappingCells = true
//            // Move last item to top
//            UIView.animate(withDuration: 0.0, animations: { 
//                collectionView.moveItem(at: lastIndexPath, to: firstIndexPath)
//            }, completion: { (done) in
//                self.isSwappingCells = false
//            })
        }// Check if last cell will be displayed
        else if indexPath.row == items.count - 1 {
            // Insert more items to bottom
//            revolveItems.append(contentsOf: items)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newTopPull = scrollView.contentOffset.y <= 100 && !isSwappingCells
        
        if newTopPull {
            topPulled = true
            
            let swapCount = 5
            var deleteIndexPaths: [IndexPath] = []
            var insertIndexPaths: [IndexPath] = []
            for i in 1...swapCount {
                // Move last item to top
                let lastItem = self.revolveItems.removeLast()
                self.revolveItems.insert(lastItem, at: 0)
                
                // Add at and to indexPaths
                let deleteIndexPath = IndexPath(item: self.revolveItems.count - i, section: 0)
                let insertIndexPath = IndexPath(item: 0, section: 0)
                deleteIndexPaths.append(deleteIndexPath)
                insertIndexPaths.append(insertIndexPath)
            }
            
//            // Move last item to top
//            let lastItem = self.revolveItems.removeLast()
//            self.revolveItems.insert(lastItem, at: 0)
//            
//            // First and last indexPaths
//            let firstIndexPath = IndexPath(item: 0, section: 0)
//            let lastIndexPath = IndexPath(item: revolveItems.count - 1, section: 0)
            
            self.isSwappingCells = true
            let currentCellIndex = self.collectionView.indexPathForItem(at: CGPoint(x: 10, y: self.collectionView.contentOffset.y))
            let attributes = self.collectionView.layoutAttributesForItem(at: currentCellIndex!)
            
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: deleteIndexPaths)
                self.collectionView.insertItems(at: insertIndexPaths)
            }, completion: { (done) in
                self.isSwappingCells = false
                if let att = attributes {
                    self.collectionView.contentOffset = att.frame.origin
                }
            })
            
//            // Move last item to top
//            UIView.animate(withDuration: 0.0, animations: {
//
//            }, completion: { (done) in
//                self.isSwappingCells = false
//            })
        }
        else {
        
        }
    }

}
