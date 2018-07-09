//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import Kingfisher


protocol ItemDetailsViewControllerDelegate:NSObjectProtocol {
    func searchResultsDidChanged()
}

class ItemDetailsViewController: UIViewController{
    
    var viewModel: SingleItemViewModel!
    var img: UIImage?
    var spinnerView: UIView?
    var shoppingCartVC: ShoppingCartViewController!
    var showBuy: Bool!
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemId: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var shoppingCart: UIImageView!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var itemRating: UIImageView!
    
    convenience init(viewModel: SingleItemViewModel, shoppingCartVC: ShoppingCartViewController, showBuy: Bool) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
        self.shoppingCartVC = shoppingCartVC
        self.showBuy = showBuy
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart"), style: .done, target: self, action: #selector(toggleFavourites))
        
        navigationItem.rightBarButtonItem?.tintColor =  viewModel.item.isFavourite ? UIColor.white.withAlphaComponent(1): UIColor.white.withAlphaComponent(0.15)
    }
    
    @objc func toggleFavourites() {
        if (viewModel.toggleIsFavourite()){
            UIView.animate(withDuration: 1) {
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white.withAlphaComponent(1)
            }
            DialogHelper.showToast(controller: self, message: "Item added to favourites", seconds: 1.0)
        }
        else {
            UIView.animate(withDuration: 1) {
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white.withAlphaComponent(0.15)
            }
            DialogHelper.showToast(controller: self, message: "Item removed from favourites", seconds: 1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!showBuy){
            addToCart.isHidden = true
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationItem.title = "Product information"
        self.navigationController?.navigationBar.titleTextAttributes
        itemImage.isUserInteractionEnabled = true
        itemImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ItemDetailsViewController.onImageViewTap(_:))))
        shoppingCart.image = shoppingCart.image?.withRenderingMode(.alwaysTemplate)
        shoppingCart.tintColor = UIColor.white
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        itemDescription.setContentOffset(CGPoint.zero, animated: false)
        addToCart.layer.cornerRadius = 8
    }
    
    func fetchData(){
        spinnerView = ItemDetailsViewController.displaySpinner(onView: self.view)
        // currently all the data is passed from the listView so no rest call will be made...
        viewModel.fetchItemDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //deselecting the add button from the navigation bar (just color)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @IBAction func onAddButtonTap(_ sender: UIButton) {
        shoppingCartVC.viewModel.addItem(item: viewModel.item)
        DialogHelper.showToast(controller: self, message: "Item added to cart", seconds: 1)
    }
    
    @objc func onImageViewTap(_ sender:AnyObject){
        let vc = ImageDetailViewController(movieImg: self.img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ItemDetailsViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.center = spinnerView.center
        ai.startAnimating()
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            spinnerView.center = onView.convert(onView.center, from:onView.superview)
        }
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension ItemDetailsViewController: ItemDetailsViewControllerDelegate{
    func searchResultsDidChanged() {
        itemName.text = viewModel.itemName
        itemId.text = "ID: " + viewModel.itemId
        itemPrice.text = viewModel.itemPrice + " $"
        itemDescription.text = viewModel.itemDescription
        if  let ratingUrl = URL(string: viewModel.ratingUrl) {
            itemRating.kf.setImage(with: ratingUrl, placeholder: #imageLiteral(resourceName: "item_score"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        if let sv = spinnerView {
            SearchItemViewController.removeSpinner(spinner: sv)
        }
        
        spinnerView = ItemDetailsViewController.displaySpinner(onView: itemImage)
        let url = viewModel.imageUrl
        itemImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.img = image
            if let sv = self.spinnerView {
                SearchItemViewController.removeSpinner(spinner: sv)
            }
        })
    }
}
