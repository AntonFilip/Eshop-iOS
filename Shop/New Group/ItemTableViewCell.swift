//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.

import UIKit
import Kingfisher

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemRating: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.font = UIFont.systemFont(ofSize: 18)
        name.textColor = UIColor.black
        price.textColor = UIColor.darkGray
        // snippet for making the cell image round
        /*movieImage.layer.borderWidth = 1
        movieImage.layer.masksToBounds = false
        movieImage.layer.borderColor = UIColor.black.cgColor
        movieImage.layer.cornerRadius = movieImage.frame.height/2
        movieImage.clipsToBounds = true*/
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = ""
        price.text = ""
        itemImage.image = nil
    }
    
    func setup(with item: ItemModel) {
        name.text = item.name
        price.text = "(" + item.price + " $)"
        if  let url = URL(string: item.thumbnail) {
            itemImage.kf.setImage(with: url)
        }
        if  let ratingUrl = URL(string: item.ratingUrl) {
            itemRating.kf.setImage(with: ratingUrl, placeholder: #imageLiteral(resourceName: "item_score"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
