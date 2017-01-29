//
//  ViewController.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var isEditingCells = false
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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
    func longPressedCollectionCell(cell: CollectionCell) {
        isEditingCells = true
        
        for cell in collectionView.visibleCells {
            if let cell = cell as? CollectionCell {
                cell.isEditing = isEditingCells
            }
        }
        
    }
    
}



