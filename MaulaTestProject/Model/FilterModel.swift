//
//  FilterModel.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class FilterModel: NSObject {
    
    var pMin: Int?
    var pMax: Int?
    var wholeSale: Bool = false
    var official: Bool = false
    var fshop: Bool = false
    
    override init() {
        super.init()
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        fromDictionary(dictionary)
    }
    
    func fromDictionary(dictionary: NSDictionary) {
        
    }
    
    func toDictionary() -> NSMutableDictionary {
        let dictionary: NSMutableDictionary = NSMutableDictionary()
        
        return dictionary
    }
}
