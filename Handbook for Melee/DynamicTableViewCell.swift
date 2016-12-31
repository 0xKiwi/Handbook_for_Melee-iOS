//
//  DynamicTableViewCell.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/28/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLAbel: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
