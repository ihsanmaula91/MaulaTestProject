//
//  NSDictionaryExtension.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/2/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import Foundation
/**
 Add new functionality to an existing NSDictionary class, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling).
 */
extension NSDictionary {
    /**
     Return a valid or not, checking the key condition not nil and not NSNull.
     - Returns : A boolean from checking the data.
     */
    public func objectIsAvailableForKey(aKey: AnyObject) -> Bool {
        return self.objectForKey(aKey) != nil && !self.objectForKey(aKey)!.isKindOfClass(NSNull) 
    }
    /**
     Return a valid value or nil, checking the value with condition not nil and not NSNull.
     - Returns : A AnyObject from checking the data.
     */
    public func availableValueForKey(aKey: AnyObject) -> AnyObject? {
        return (self.objectForKey(aKey) != nil && !self.objectForKey(aKey)!.isKindOfClass(NSNull)) ? self.objectForKey(aKey) : nil
    }
}
