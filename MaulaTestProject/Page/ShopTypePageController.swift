//
//  ShopTypePageController.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/3/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit

class ShopTypePageController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var shopTypeTableView: UITableView!
    
    let shopTypeListCellIdentifier: String = "ShopTypeListCell"
    let shopTypeCellArray: [String] = ["Gold Merchant", "Official Store"]
    let checkedImg = UIImage(named: "checked.png")
    let uncheckedImg = UIImage(named: "unchecked.png")
    var checkedGM: Bool = false
    var checkedOS: Bool = false
    
    var globalExecuteDelegate: GlobalExecuteDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Shop Type"
        removeTitleBackNavigation()
        addRightButtonItem()
        registerNib()
    }
    
    func addRightButtonItem() {
        let rightButtonItem = UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: #selector(resetData))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hexString: "3AA931")
    }
    
    func registerNib() {
        shopTypeTableView.registerNib(UINib(nibName: shopTypeListCellIdentifier, bundle: nil), forCellReuseIdentifier: shopTypeListCellIdentifier)
    }
    
    func resetData() {
        checkedGM = false
        checkedOS = false
        shopTypeTableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopTypeCellArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ShopTypeListCell = tableView.dequeueReusableCellWithIdentifier(shopTypeListCellIdentifier, forIndexPath: indexPath) as! ShopTypeListCell
        cell.shopTypeLabel.text = shopTypeCellArray[indexPath.row]
        cell.checkboxButton.tag = indexPath.row
        cell.checkboxButton .layer.zPosition = 999
        if indexPath.row == 0 {
            let image = checkedGM ? checkedImg : uncheckedImg
            cell.checkboxButton.setImage(image, forState: .Normal)
        } else if indexPath.row == 1  {
            let image = checkedOS ? checkedImg : uncheckedImg
            cell.checkboxButton.setImage(image, forState: .Normal)
        }
        cell.checkboxButton.addTarget(self, action: #selector(ShopTypePageController.checkboxClicked(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func checkboxClicked(checkbox: UIButton) {
        if checkbox.tag == 0 {
            checkedGM = changeCheckboxImage(checkedGM, checkbox: checkbox)
        } else {
            checkedOS = changeCheckboxImage(checkedOS, checkbox: checkbox)
        }
    }
    
    func changeCheckboxImage(statusCheck: Bool, checkbox: UIButton) -> Bool {
        if statusCheck == false {
            checkbox.setImage(checkedImg, forState: .Normal)
        }else{
            checkbox.setImage(uncheckedImg, forState: .Normal)
        }
        
        return !statusCheck
    }

    @IBAction func applyButtonClicked(sender: AnyObject) {
        let tempFilterData = FilterModel()
        tempFilterData.fshop = checkedGM
        tempFilterData.official = checkedOS
        globalExecuteDelegate?.execute(0, data: tempFilterData)
        self.navigationController?.popViewControllerAnimated(true)
    }
}
