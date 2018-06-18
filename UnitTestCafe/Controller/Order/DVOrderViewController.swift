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
    @IBOutlet weak var tableView: UITableView!

    var menuItemArray = [Item]()
    var selectedItems = [Item]()
    var customizedItems = [CustomizedItem]()
    var nextController: DVDetailViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
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

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let xib = UINib(nibName: String(describing: DidSelectCell.self), bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: String(describing: DidSelectCell.self))
        let confirmXib = UINib(nibName: String(describing: ConfirmCell.self), bundle: nil)
        tableView.register(confirmXib, forCellReuseIdentifier: String(describing: ConfirmCell.self))
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
        guard let item = sender.itemInfo else { return }
        selectedItems.append(item)
        customizedItems.append(CustomizedItem(name: item.name, iced: true, sugar: true))
        tableView.reloadData()
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

extension DVOrderViewController: UITableViewDelegate, UITableViewDataSource, ConfirmCellDelegate, DidSelecteCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return selectedItems.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DidSelectCell.self), for: indexPath) as? DidSelectCell else { return UITableViewCell() }
            cell.itemImage.sd_setImage(with: URL(string: selectedItems[indexPath.row].image), placeholderImage: #imageLiteral(resourceName: "add-shopping-cart"))
            cell.nameLabel.text = selectedItems[indexPath.row].name
            cell.delegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfirmCell.self), for: indexPath) as? ConfirmCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func icedDidTapped(_ sender: DidSelectCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        customizedItems[tappedIndexPath.row].iced = true
    }
    
    func hotDidTapped(_ sender: DidSelectCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        customizedItems[tappedIndexPath.row].iced = false
    }
    
    func yesSugarDidTapped(_ sender: DidSelectCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        customizedItems[tappedIndexPath.row].sugar = true
    }
    
    func noSugarDidTapped(_ sender: DidSelectCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        customizedItems[tappedIndexPath.row].sugar = false
    }
    
    func confirmButtonPressed(_ sender: ConfirmCell) {
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            nextController = segue.destination as? DVDetailViewController
            nextController?.customizedItems = customizedItems
        }
    }
}
