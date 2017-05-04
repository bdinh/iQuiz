//
//  ViewControllerTableViewCell.swift
//  iQuiz
//
//  Created by Bao Dinh on 5/4/17.
//  Copyright © 2017 Bao Dinh. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImage: UIImageView!

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
