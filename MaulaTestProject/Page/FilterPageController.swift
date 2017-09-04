//
//  FilterPageController.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/3/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit
import MARKRangeSlider

class FilterPageController: BaseViewController, UITableViewDelegate, UITableViewDataSource, GlobalExecuteDelegate {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    var rangePriceCell: RangePriceCell!
    var shopTypeCell: ShopTypeCell!
    
    var filterData: FilterModel?
    var minimumPrice: Int?
    var maximumPrice: Int?
    var wholeSale: Bool = false
    var official: Bool = false
    var goldMerchant: Bool = false
    
    var isResetMode: Bool = false
    var rangeSliderArray: [MARKRangeSlider] = []
    var defaultMinPrice: Int = 100
    var defaultMaxPrice: Int = 8000000
    
    let filterTitle: String = Constants.FILTER_TITLE
    let resetText: String = Constants.RESET_TEXT
    let rangePriceCellIdentifier: String = Constants.RANGE_PRICE_CELL
    let shopTypeCellIdentifier: String = Constants.SHOP_TYPE_CELL
    let goldMerchantText: String = Constants.GOLD_MERCHANT
    let officialStoreText: String = Constants.OFFICIAL_STORE
    
    var globalExecuteDelegate: GlobalExecuteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filterTableView.separatorStyle = .None
        navigationItem.title = filterTitle
        removeTitleBackNavigation()
        addRightButtonItem()
        registerNib()
        prepopulateData()
    }
    
    func addRightButtonItem() {
        let rightButtonItem = UIBarButtonItem(title: resetText, style: .Plain, target: self, action: #selector(resetData))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hexString: "3AA931")
    }
    
    func registerNib() {
        filterTableView.registerNib(UINib(nibName: rangePriceCellIdentifier, bundle: nil), forCellReuseIdentifier: rangePriceCellIdentifier)
        filterTableView.registerNib(UINib(nibName: shopTypeCellIdentifier, bundle: nil), forCellReuseIdentifier: shopTypeCellIdentifier)
    }
    
    func prepopulateData() {
        if filterData != nil {
            minimumPrice = filterData!.pMin!
            maximumPrice = filterData!.pMax!
            wholeSale = filterData!.wholeSale
            official = filterData!.official
            goldMerchant = filterData!.fshop
        } else {
            minimumPrice = defaultMinPrice
            maximumPrice = defaultMaxPrice
            wholeSale = false
            official = false
            goldMerchant = false
        }
    }
    
    func resetData() {
        isResetMode = true
        minimumPrice = defaultMinPrice
        maximumPrice = defaultMaxPrice
        wholeSale = false
        official = false
        goldMerchant = false
        filterTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 152.0
        } else {
            if official || goldMerchant {
                return 70.0
            } else {
                return 34
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: RangePriceCell = tableView.dequeueReusableCellWithIdentifier(rangePriceCellIdentifier, forIndexPath: indexPath) as! RangePriceCell
            setDataRangePriceCell(cell)
            rangePriceCell = cell
            return cell
        } else {
            let cell: ShopTypeCell = tableView.dequeueReusableCellWithIdentifier(shopTypeCellIdentifier, forIndexPath: indexPath) as! ShopTypeCell
            setDataShopTypeCell(cell)
            shopTypeCell = cell
            return cell
        }
    }
    
    func removeRangeSlider() {
        for rangeSlider in rangeSliderArray {
            rangeSlider.removeFromSuperview()
        }
    }
    
    func setDataRangePriceCell(cell: RangePriceCell) {
        cell.minPriceLabel.text = "Rp " + Utility.currencyFormat(minimumPrice!)
        cell.maxPriceLabel.text = "Rp " + Utility.currencyFormat(maximumPrice!)
        
        removeRangeSlider()
        cell.rangeSlider = MARKRangeSlider(frame: CGRect(x: 8, y: 55, width: cell.bounds.width - 16, height: 50))
        cell.rangeSlider!.setMinValue(CGFloat(defaultMinPrice/100), maxValue: CGFloat(defaultMaxPrice/100))
        cell.rangeSlider!.setLeftValue(CGFloat(minimumPrice!/100), rightValue: CGFloat(maximumPrice!/100))
        cell.rangeSlider!.minimumDistance = 1.0
        cell.rangeSlider!.addTarget(self, action: #selector(FilterPageController.rangeSliderValueChanged(_:)), forControlEvents: .ValueChanged)
        rangeSliderArray.append(cell.rangeSlider!)
        cell.contentView.addSubview(cell.rangeSlider!)
        
        cell.wholeSaleSwitch.setOn(wholeSale, animated: true)
        cell.wholeSaleSwitch.addTarget(self, action: #selector(FilterPageController.changeWholeSaleValue(_:)), forControlEvents: .ValueChanged)
    }
    
    func rangeSliderValueChanged(slider: MARKRangeSlider) {
        isResetMode = false
        minimumPrice = Int(floor(slider.leftValue))*100
        maximumPrice = Int(floor(slider.rightValue))*100
        rangePriceCell.minPriceLabel.text = "Rp " + Utility.currencyFormat(minimumPrice!)
        rangePriceCell.maxPriceLabel.text = "Rp " + Utility.currencyFormat(maximumPrice!)
    }
    
    func changeWholeSaleValue(wholeSaleSwitch: UISwitch) {
        isResetMode = false
        if wholeSaleSwitch.on {
            wholeSale = true
        }else{
            wholeSale = false
        }
    }
    
    func setDataShopTypeCell(cell: ShopTypeCell) {
        if !official && !goldMerchant {
            cell.shopTypeButtonOne.hidden = true
            cell.shopTypeButtonTwo.hidden = true
        } else if official && goldMerchant {
            cell.shopTypeButtonOne.hidden = false
            cell.shopTypeButtonTwo.hidden = false
            cell.shopTypeButtonOne.setTitle(goldMerchantText, forState: .Normal)
            cell.shopTypeButtonTwo.setTitle(officialStoreText, forState: .Normal)
            cell.shopTypeButtonOne.addTarget(self, action: #selector(FilterPageController.removeShopTypeClicked(_:)), forControlEvents: .TouchUpInside)
            cell.shopTypeButtonTwo.addTarget(self, action: #selector(FilterPageController.removeShopTypeClicked(_:)), forControlEvents: .TouchUpInside)
        } else if official || goldMerchant {
            cell.shopTypeButtonOne.hidden = false
            cell.shopTypeButtonTwo.hidden = true
            let title = official ? officialStoreText : goldMerchantText
            cell.shopTypeButtonOne.setTitle(title, forState: .Normal)
            cell.shopTypeButtonOne.addTarget(self, action: #selector(FilterPageController.removeShopTypeClicked(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func removeShopTypeClicked(sender: UIButton) {
        if let text = sender.titleLabel?.text {
            if text == goldMerchantText {
                goldMerchant = false
            } else {
                official = false
            }
        }
        filterTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.section == 1 {
            self.performSegueWithIdentifier("goToShopTypePage", sender: nil)
        }
    }
    
    func mappingFilterData() {
        if !isResetMode {
            filterData = FilterModel()
            filterData!.pMin = minimumPrice
            filterData!.pMax = maximumPrice
            filterData!.wholeSale = wholeSale
            filterData!.official = official
            filterData!.fshop = goldMerchant
        } else {
            filterData = nil
        }
    }

    @IBAction func applyButtonClicked(sender: AnyObject) {
        mappingFilterData()
        globalExecuteDelegate?.execute(0, data: filterData)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func execute(action: Int, data: AnyObject?) {
        if action == 0 {
            let tempFilterData = data as! FilterModel
            official = tempFilterData.official
            goldMerchant = tempFilterData.fshop
            isResetMode = false
            filterTableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToShopTypePage" {
            let shopTypePage = segue.destinationViewController as! ShopTypePageController
            shopTypePage.checkedGM = goldMerchant
            shopTypePage.checkedOS = official
            shopTypePage.globalExecuteDelegate = self
        }
    }
}
