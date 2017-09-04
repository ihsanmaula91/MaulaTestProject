//
//  SearchModel.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class SearchModel: NSObject {
    var products : [ProductModel] = []
    
    override init() {
        super.init()
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        fromDictionary(dictionary)
    }
    
    func fromDictionary(dictionary: NSDictionary) {
        if dictionary.objectIsAvailableForKey("data") {
            let data = dictionary.objectForKey("data") as! NSArray
            
            for product in data {
                let productModel = ProductModel(dictionary: product as! NSDictionary)
                products.append(productModel)
            }
        }
    }
}
