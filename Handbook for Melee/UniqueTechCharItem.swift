//
//  InfoItem.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 4/9/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import Foundation
import UIKit

struct UniqueTechCharItem {
    var char : String = ""
    var moveList : [String]
    
    init(character: String, movesList: [String]) {
        char = character
        moveList = movesList
    }
    
    init() {
        char = ""
        moveList = []
    }
}
