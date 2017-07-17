//
//  InfoItem.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 4/9/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import Foundation
import UIKit

class InfoItem {
    var desc : String = ""
    var type : Int = 1;
    
    init(dscript: String, name: Int) {
        desc = dscript
        type = name
    }
}
