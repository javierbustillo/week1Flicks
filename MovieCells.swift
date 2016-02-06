//
//  MovieCells.swift
//  Flicks
//
//  Created by Javier Bustillo on 1/23/16.
//  Copyright © 2016 Javier Bustillo. All rights reserved.
//

import UIKit

class MovieCells: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
