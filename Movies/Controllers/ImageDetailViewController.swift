//  Created by Duje Medak on 14/05/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController{

    var itemImg:UIImage?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var itemImage: UIImageView!
    
    convenience init() {
        self.init(movieImg: nil)
    }
    
    init(movieImg: UIImage?) {
        if let img = movieImg{
            self.itemImg = img
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
        itemImage.image = self.itemImg
    }
}

extension ImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return itemImage
    }
}
