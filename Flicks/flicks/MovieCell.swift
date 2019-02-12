//
//  MovieCell.swift
//  flicks
//
//  Created by Syed Kazmi on 2/6/19.
//  Copyright © 2019 Syed Kazmi. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    
    
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
