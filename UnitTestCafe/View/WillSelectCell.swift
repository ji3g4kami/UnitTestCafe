//
//  WillSelectCell.swift
//  UnitTestCafe
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import UIKit

protocol WillSelectCellDelegate: class {
    
    func didTapItem(_ sender: WillSelectCell)

}

class WillSelectCell: UICollectionViewCell {

    @IBOutlet weak var coffeeImage: UIImageView!
    
    weak var delegate: WillSelectCellDelegate?
    
    var itemInfo: Item?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.didTapItem(self)
    }
}
