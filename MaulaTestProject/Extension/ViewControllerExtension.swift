//
//  ViewControllerExtension.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/2/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit
/**
 Add new functionality to an existing UIViewController class, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling).
 */
extension UIViewController {
    /**
     Remove back text in navigation controller on the bar button item.
    */
    public func removeTitleBackNavigation() {
        let changeTitle = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = changeTitle
        self.navigationController?.navigationBar.tintColor = UIColor(hexString: "3AA931")
    }
}