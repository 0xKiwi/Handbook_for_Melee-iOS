//
//  ThemedTableViewCell.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 4/26/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import SwiftTheme

class ThemedTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.theme_backgroundColor = ["#fafafa", "#212121"]
        self.textLabel?.theme_textColor = ["#000", "#FFF"]
        
        let bg = UIView()
        bg.theme_backgroundColor = ["#eee", "#303030"]
        self.selectedBackgroundView = bg
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
