//
//  CreateSchoolTableViewCell.swift
//  iNeedABreak2
//
//  Created by Robert Hensley on 12/4/16.
//  Copyright © 2016 Robert Hensley. All rights reserved.
//

import UIKit
import Firebase

class CreateSchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var dateName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    var data: FIRDataSnapshot?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
