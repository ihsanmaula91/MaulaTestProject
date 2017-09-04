//
//  SpinnerWidget.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/4/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//


import UIKit

public class SpinnerWidget: UIViewController {

    public var navigationHeight: CGFloat = 0.00
    public var containerView: UIViewController!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        loadFromXibWithCurrentClassName()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFromXibWithCurrentClassName() {
        let xibName: String? = NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last
        let widget: UIViewController? = NSBundle.mainBundle().loadNibNamed(xibName, owner: self, options: nil)[0] as? UIViewController
        
        if widget != nil {
            addChildViewController(widget!)
            view.addSubview(widget!.view)
        }
    }
    
    public func showSpinner(contentView: UIViewController!) {
        containerView = contentView
        let frame = CGRectMake(contentView.view.frame.minX, navigationHeight, contentView.view.frame.width, UIScreen.mainScreen().bounds.height)
        self.view.frame = frame
        self.view.layer.zPosition = 1000
        containerView.navigationController?.view.addSubview(self.view)
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    public func hideSpinner() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if finished {
                    self.view.removeFromSuperview()
                }
        });
    }

}
