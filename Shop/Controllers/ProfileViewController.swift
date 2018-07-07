//
//  ProfileViewController.swift
//  Shop
//
//  Created by Lovro Buničić on 01/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var content: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var birthday: UILabel!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ratingCircle: UILabel!
    @IBOutlet weak var bougthitemsCircle: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func roundUpView(view:UIView){
        view.layer.borderWidth = 2
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.cornerRadius = view.frame.height/2
        view.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        roundUpView(view: profileImage)
        roundUpView(view: ratingCircle)
        roundUpView(view: bougthitemsCircle)
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: scrollView.contentSize.height+1)
    }
}
