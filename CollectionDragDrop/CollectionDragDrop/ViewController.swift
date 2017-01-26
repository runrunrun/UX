//
//  ViewController.swift
//  CollectionDragDrop
//
//  Created by Hari Kunwar on 1/25/17.
//  Copyright © 2017 Learning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var isEditingCells: Bool?
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
        cell.titleLabel.text = "Cell Number \(indexPath.row)"
        cell.delegate = self
        if let editing = isEditingCells {
            cell.isEditing = editing
        }
        
        return cell
    }
}

extension ViewController: CollectionCellDelegate {
    func longPressedCollectionCell(cell: CollectionCell) {
        if let editing = isEditingCells {
            isEditingCells = !editing
        }
        else {
            isEditingCells = true
        }
        
        collectionView.reloadData()
    }
    
}



