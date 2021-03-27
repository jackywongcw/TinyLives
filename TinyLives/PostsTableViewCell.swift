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
    
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet var expireDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
