//
//  DidSelectCell.swift
//  UnitTestCafe
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import UIKit

protocol DidSelecteCellDelegate: class {
    
    func icedDidTapped(_ sender: DidSelectCell)
    
    func hotDidTapped(_ sender: DidSelectCell)
    
    func yesSugarDidTapped(_ sender: DidSelectCell)
    
    func noSugarDidTapped(_ sender: DidSelectCell)
}

class DidSelectCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var icedRadioButton: DLRadioButton!
    @IBOutlet weak var yesRadioButton: DLRadioButton!
    
    weak var delegate: DidSelecteCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icedRadioButton.isSelected = true
        yesRadioButton.isSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func icedTapped(_ sender: DLRadioButton) {
        delegate?.icedDidTapped(self)
    }
    
    @IBAction func hotTapped(_ sender: DLRadioButton) {
        delegate?.hotDidTapped(self)
    }
    
    @IBAction func yesSugarTapped(_ sender: DLRadioButton) {
        delegate?.yesSugarDidTapped(self)
    }
    
    @IBAction func noSugarTapped(_ sender: DLRadioButton) {
        delegate?.noSugarDidTapped(self)
    }
}
