//
//  ConfirmCell.swift
//  UnitTestCafe
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import UIKit

protocol ConfirmCellDelegate: class {
    
    func confirmButtonPressed(_ sender: ConfirmCell)
    
}

class ConfirmCell: UITableViewCell {
    
    weak var delegate: ConfirmCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func bottonPressed(_ sender: UIButton) {
        delegate?.confirmButtonPressed(self)
    }
}
