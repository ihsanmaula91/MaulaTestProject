//
//  BaseViewController.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var spinnerWidget: SpinnerWidget!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     This method is called to show spinner.
     */
    func showSpinner() {
        spinnerWidget = SpinnerWidget()
        spinnerWidget.showSpinner(self)
    }
    
    /**
     This method is called to remove spinner.
     */
    func removeSpinner() {
        spinnerWidget.hideSpinner()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
