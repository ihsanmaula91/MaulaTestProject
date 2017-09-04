//
//  ProductCollectionViewCell.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/2/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
