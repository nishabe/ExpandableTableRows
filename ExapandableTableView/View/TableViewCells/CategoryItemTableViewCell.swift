//
//  CategoryItemTableViewCell.swift
//  ExapandableTableView
//
//  Created by Aneesh Abraham on 4/11/20.
//  Copyright © 2020 qaz. All rights reserved.
//

import UIKit

class CategoryItemView: UITableViewCell {

    @IBOutlet weak var label: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
