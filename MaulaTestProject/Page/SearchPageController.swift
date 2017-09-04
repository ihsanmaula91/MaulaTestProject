//
//  ViewController.swift
//  MaulaTestProject
//
//  Created by MyMacbook on 9/2/17.
//  Copyright © 2017 MyMacbook. All rights reserved.
//

import UIKit
import Haneke

class SearchPageController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, GlobalExecuteDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 6.0, bottom: 10.0, right: 8.0)
    let itemsPerRow: CGFloat = 2
    var isLazyLoad: Bool = false
    var isRequest: Bool = false
    var offsetRequest: Int = 0
    var productList: [ProductModel] = []
    var filterData: FilterModel?
    
    let productCollectionViewCell = Constants.PRODUCT_COLLECTION_VIEW_CELL
    let searchErrorMessage: String = Constants.SEARCH_ERROR_MESSAGE
    let searchTitle: String = Constants.SEARCH_TITLE

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = searchTitle
        registerNib()
        requestSearchProduct()
    }
    
    func registerNib() {
        let nibName = UINib(nibName: productCollectionViewCell, bundle: nil)
        collectionView.registerNib(nibName, forCellWithReuseIdentifier: productCollectionViewCell)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(productCollectionViewCell, forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.productImage.contentMode = .ScaleAspectFit
        cell.productImage.hnk_setImageFromURL(NSURL(string: productList[indexPath.row].imageUrl!)!)
        cell.productName.text = productList[indexPath.row].name
        cell.productPrice.text = productList[indexPath.row].price
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 200)
    }
    
    func requestSearchProduct() {
        showSpinner()
        let module: String = getModule()
        let request = NSMutableURLRequest(URL: NSURL(string: Utility.getUrl(module))!)
        let session = NSURLSession.sharedSession()
        var searchModel = SearchModel()
        
        session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            let json: AnyObject?
            do {
                if data != nil {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options:[])
                    searchModel = SearchModel(dictionary: json as! NSDictionary)
                    dispatch_async(dispatch_get_main_queue()) {
                        if searchModel.products.count > 0 {
                            self.successHandler(searchModel.products)
                        } else {
                            self.errorSearchHandler()
                        }
                    }
                }else{
                    self.errorSearchHandler()
                }
            } catch {
                self.errorSearchHandler()
            }
            
        }).resume()
    }
    
    func getModule() -> String {
        let start: Int = offsetRequest * 10
        var module: String = Utility.getURIFromURIConfig(Constants.URI.SEARCH_PODUCT)!+"q=samsung"
        if filterData != nil {
            if filterData!.pMin != nil {
                module = module + "&pmin=" + String(filterData!.pMin!)
            }
            if filterData!.pMax != nil {
                module = module + "&pmax=" + String(filterData!.pMax!)
            }
            module = module + "&wholesale=" + String(filterData!.wholeSale) + "&official=" + String(filterData!.official)
//            module = filterData!.fshop ? module + "&fshop=2" : module + "&fshop=0"
        }
        
        module = module + "&fshop=2" + "&start=" + String(start) + "&rows=10"
        
        return module
    }
    
    func successHandler(products: [ProductModel]) {
        offsetRequest += 1
        productList.appendContentsOf(products)
        collectionView.reloadData()
        if !isLazyLoad {
            collectionView.setContentOffset(CGPointZero, animated:true)
        }
        isRequest = false
        isLazyLoad = false
        removeSpinner()
    }
    
    func errorSearchHandler() {
        if !isLazyLoad {
            showAlertView(searchErrorMessage)
            productList = []
        }
        self.isRequest = false
        self.isLazyLoad = false
        collectionView.reloadData()
        removeSpinner()
    }
    
    func showAlertView(errorMessage: String) {
        let alert = UIAlertController(title: "", message: errorMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: Constants.OK_TITLE, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let productCountChecking: Bool = productList.count > 0 && productList.count >= 10 && productList.count % 10 == 0
        if productCountChecking && collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height) {
            isLazyLoad = true
            
        }
    }
    
    /// did end scroll will request the data
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if productList.count > 0 && isLazyLoad && !isRequest {
            isRequest = true
            requestSearchProduct()
        }
    }
    
    func resetSearchPage() {
        productList = []
        offsetRequest = 0
        isLazyLoad = false
        isRequest = false
    }
    
    @IBAction func FilterButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("goToFilterPage", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToFilterPage" {
            let filterPage = segue.destinationViewController as! FilterPageController
            filterPage.filterData = filterData
            filterPage.globalExecuteDelegate = self
        }
    }
    
    func execute(action: Int, data: AnyObject?) {
        if action == 0 {
            filterData = data as? FilterModel
            resetSearchPage()
            requestSearchProduct()
        }
    }
}

