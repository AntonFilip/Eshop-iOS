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
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var yearTxt: UILabel!
    @IBOutlet weak var genreTxt: UILabel!
    @IBOutlet weak var directorTxt: UILabel!
    
    convenience init(viewModel: SingleItemViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .done, target: self, action: #selector(onAddButtonTap))
        itemImage.isUserInteractionEnabled = true
        itemImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ItemDetailsViewController.onImageViewTap(_:))))
        
        itemDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        itemDescription.numberOfLines = 0
        fetchData()
    }
    
    func fetchData(){
        spinnerView = ItemDetailsViewController.displaySpinner(onView: self.view)
        viewModel.fetchItemDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //deselecting the add button from the navigation bar (just color)
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
    }
    
    @objc func onAddButtonTap(sender: AnyObject) {
        //TODO load new activity with basket
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
        itemPrice.text = viewModel.itemPrice
        itemDescription.text = viewModel.itemDescription
        if let sv = spinnerView {
            ItemListViewController.removeSpinner(spinner: sv)
        }
        
        spinnerView = ItemDetailsViewController.displaySpinner(onView: itemImage)
        let url = viewModel.imageUrl
        itemImage.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.img = image
            if let sv = self.spinnerView {
                ItemListViewController.removeSpinner(spinner: sv)
            }
        })
    }
}