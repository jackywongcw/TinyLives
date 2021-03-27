//
//  PostsTableViewCell.swift
//  TinyLives
//
//  Created by Jacky Wong on 26/3/21.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var iconImageView: UIImageView!
    
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet var expireDate: UILabel!
    
    @IBOutlet var imageStackView: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        downloadButton.layer.cornerRadius = 5
        downloadButton.layer.borderWidth = 1
        downloadButton.layer.borderColor = UIColor.clear.cgColor
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.layer.borderWidth = 1
        coverImageView.layer.borderColor = UIColor.clear.cgColor
        
        iconImageView.image = iconImageView.image?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor(named: "SkyBlue")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
