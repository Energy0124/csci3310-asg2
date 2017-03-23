//
//  CritterTableViewCell.swift
//  CatTracker
//
//  Created by LING Leong on 23/3/2017.
//  Copyright © 2017 LING Leong. All rights reserved.
//

import UIKit

class CritterTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var details: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
