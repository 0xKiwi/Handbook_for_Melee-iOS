//
//  attribute+data.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/2/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Foundation

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
