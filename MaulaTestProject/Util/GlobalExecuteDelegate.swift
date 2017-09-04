//
//  GlobalExecuteDelegate.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//


import Foundation

public protocol GlobalExecuteDelegate {
    func execute(action: Int, data: AnyObject?) -> Void
}