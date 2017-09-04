//
//  Utility.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

public class Utility: NSObject {

    public static func getURIFromURIConfig(module: String?) -> String? {
        let plistPath: String? = NSBundle.mainBundle().pathForResource(Constants.URI_CONFIG_PLIST, ofType: Constants.PLIST)
        let plist: NSDictionary? = plistPath != nil ? NSDictionary(contentsOfFile: plistPath!) : nil
        let uriConfigCache = plist?.valueForKey(Constants.URI_CONFIG) as? NSDictionary
        
        let serviceModule: String? = module != nil ? uriConfigCache?.valueForKey(module!) as? String : nil
        return serviceModule
    }
    
    public static func getProtocol() -> String {
        let protocolString = Constants.API.HTTP
        let domain: String = Utility.getValueFromInfoPlist(Constants.DOMAIN_PREFERENCE) as! String
        
        return protocolString + "://" + domain
    }
    
    public static func getValueFromInfoPlist(key: String) -> AnyObject? {
        let infoPlist: [String:AnyObject]? = NSBundle.mainBundle().infoDictionary
        return infoPlist?[key]
    }
    
    public static func getUrl(module: String) -> String {
        let protocolWithDomain = Utility.getProtocol()
        return protocolWithDomain + module
    }
    
    public static func currencyFormat(price:Int) -> String {
        // Currency Formatter
//        let unitedStatesLocale = NSLocale(localeIdentifier: "id")
        let formatter = NSNumberFormatter()
        var priceInFormat: String?
        formatter.groupingSeparator = "."
        formatter.numberStyle = .DecimalStyle
        priceInFormat = formatter.stringFromNumber(price)
        return priceInFormat != nil ? priceInFormat! : String(price)
    }
}
