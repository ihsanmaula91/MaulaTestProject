//
//  ShopTypeCell.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/3/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class ShopTypeCell: UITableViewCell {

    @IBOutlet weak var shopTypeLabel: UILabel!
    @IBOutlet weak var shopTypeButtonOne: UIButton!
    @IBOutlet weak var shopTypeButtonTwo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setData()
        // Initialization code
    }
    
    func setupUI() {
        self.accessoryType = .DisclosureIndicator
        shopTypeLabel.text = "Shop Type"
        setButtonBorder(shopTypeButtonOne)
        setButtonBorder(shopTypeButtonTwo)
    }
    
    func setButtonBorder(button: UIButton) {
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "808080").CGColor
    }
    
    func setData() {

    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
