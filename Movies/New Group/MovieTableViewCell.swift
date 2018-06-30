//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//
/*
 import UIKit
 
 class MovieTableViewCell: UITableViewCell {
 
 override func awakeFromNib() {
 super.awakeFromNib()
 // Initialization code
 }
 
 override func setSelected(_ selected: Bool, animated: Bool) {
 super.setSelected(selected, animated: animated)
 
 // Configure the view for the selected state
 }
 
 }
 */
import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.font = UIFont.systemFont(ofSize: 18)
        title.textColor = UIColor.black
        year.textColor = UIColor.darkGray
        // snippet for making the cell image round
        /*movieImage.layer.borderWidth = 1
        movieImage.layer.masksToBounds = false
        movieImage.layer.borderColor = UIColor.black.cgColor
        movieImage.layer.cornerRadius = movieImage.frame.height/2
        movieImage.clipsToBounds = true*/
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        year.text = ""
        movieImage.image = nil
    }
    
    func setup(withMovie item: ItemModel) {
        title.text = item.name
        year.text = "(" + item.price + ")"
        if  let url = URL(string: item.thumbnail) {
            movieImage.kf.setImage(with: url)
        }
    }
}
