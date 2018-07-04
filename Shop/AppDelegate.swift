//  Created by Duje Medak on 13/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import CoreData
import AERecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        try? AERecord.loadCoreDataStack()
        
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor(red:0.15, green:0.73, blue:0.60, alpha:1.0)
        }
        
        UITabBar.appearance().tintColor = UIColor(red:0.15, green:0.73, blue:0.60, alpha:1.0)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = LoginViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
    
    

    
}



