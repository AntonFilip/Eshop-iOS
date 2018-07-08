//
//  DialogHelper.swift
//  Shop
//
//  Created by Anton Filipović on 08/07/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import Foundation
import UIKit

class DialogHelper{
    
    static func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
