//
//  ShopTypeListCell.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/3/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class ShopTypeListCell: UITableViewCell {

    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var shopTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
