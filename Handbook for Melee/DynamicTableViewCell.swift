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
        
        self.theme_backgroundColor = ["#fafafa", "#212121"]
        self.textLabel?.theme_textColor = ["#000", "#FFF"]
        
        let bg = UIView()
        bg.theme_backgroundColor = ["#eee", "#303030"]
        self.selectedBackgroundView = bg
        
        self.titleLabel?.theme_textColor = ["#000", "#FFF"]
        self.subtitleLAbel?.theme_textColor = ["#000", "#FFF"]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
