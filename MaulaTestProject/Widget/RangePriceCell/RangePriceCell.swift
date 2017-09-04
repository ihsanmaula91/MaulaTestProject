//
//  RangePriceCell.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit
import MARKRangeSlider

class RangePriceCell: UITableViewCell {

    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var maxPriceLabel: UILabel!
    @IBOutlet weak var wholeSaleSwitch: UISwitch!
    
    
    var rangeSlider: MARKRangeSlider?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
