//
//  DVOrderViewController.swift
//  UnitTestCafe
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import UIKit
import SDWebImage

class DVOrderViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var menuItemArray = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        queryMenu()
    }
    
    func queryMenu() {
        FirebaseManager.shared.queryMenu { itemArray in
            self.menuItemArray = itemArray
            self.collectionView.reloadData()
        }
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xib = UINib(nibName: "WillSelectCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "WillSelectCell")
    }

}

extension DVOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, WillSelectCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WillSelectCell", for: indexPath) as? WillSelectCell {
            cell.coffeeImage.sd_setImage(with: URL(string: menuItemArray[indexPath.row].image), placeholderImage: #imageLiteral(resourceName: "add-shopping-cart"))
            cell.itemInfo = menuItemArray[indexPath.row]
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func didTapItem(_ sender: WillSelectCell) {
        print(sender.itemInfo)
    }
}

extension DVOrderViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Double(collectionView.frame.size.width)/4 - 10
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
