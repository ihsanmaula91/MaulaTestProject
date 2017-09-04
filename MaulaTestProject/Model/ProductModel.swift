//
//  ProductModel.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class ProductModel: NSObject {
    var name: String?
    var imageUrl: String?
    var price: String?
    
    override init() {
        super.init()
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        fromDictionary(dictionary)
    }
    
    func fromDictionary(dictionary: NSDictionary) {
        name = dictionary.objectIsAvailableForKey("name") ? (dictionary.objectForKey("name") as? String)! : ""
        imageUrl = dictionary.objectIsAvailableForKey("image_uri") ? (dictionary.objectForKey("image_uri") as? String)! : ""
        price = dictionary.objectIsAvailableForKey("price") ? (dictionary.objectForKey("price") as? String)! : ""
    }
}
