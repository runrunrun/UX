//
//  ViewController.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var isEditingCells = false
    fileprivate var cellScreenShot = UIImageView()
    fileprivate let scaleValue = 1.2
    fileprivate let scaleDuration = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellScreenShot.layer.borderColor = UIColor.red.cgColor
        cellScreenShot.layer.borderWidth = 2.0
        
        cellScreenShot.contentMode = .scaleToFill
        self.view.addSubview(cellScreenShot)
        
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        cell.titleLabel.text = "Cell\(indexPath.row)"
        cell.delegate = self
        cell.isEditing = isEditingCells
        
        return cell
    }
}

extension ViewController: CollectionCellDelegate {
    func beginLongPress(cell: CollectionCell) {
        isEditingCells = true
        
        // Replace cell with screenshot
        cellScreenShot.alpha = 1.0
        cellScreenShot.image = cell.screenShot()
        cellScreenShot.frame = cell.frame
        view.bringSubview(toFront: cellScreenShot)
        
        // Hide cell
        cell.alpha = 0.0
        
        // Scale up screenshot
        let scaleUp = CABasicAnimation(keyPath: "transform.scale")
        scaleUp.fromValue = 1.0
        scaleUp.toValue = 1.2
        scaleUp.duration = 0.1
        scaleUp.fillMode = kCAFillModeForwards
        scaleUp.isRemovedOnCompletion = false
        cellScreenShot.layer.add(scaleUp, forKey: "scalingUp")
        
        // Change visible cells state.
        for cell in collectionView.visibleCells {
            if let cell = cell as? CollectionCell {
                cell.isEditing = isEditingCells
            }
        }
    }
    
    func endLongPress(cell: CollectionCell) {
        // Scale Down
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = scaleValue
        scaleDown.toValue = 1.0
        scaleDown.duration = scaleDuration
        cellScreenShot.layer.add(scaleDown, forKey: "scalingDown")
        cellScreenShot.layer.removeAnimation(forKey: "scalingUp")
        
        // Show cell and hide cell screenshot.
        UIView.animate(withDuration: 0.01, delay: scaleDuration, animations: {
            cell.alpha = 1.0
            self.cellScreenShot.alpha = 0.0
        }, completion: nil)

    }
    
    func moved(cell: CollectionCell, center: CGPoint) {
        cellScreenShot.center = center
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}


