//
//  UILabel+Font.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 2/26/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import Foundation
import UIKit
import SwiftTheme

extension UITextView {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout).pointSize)\">%@</span>" as NSString, htmlText.replacingOccurrences(of: "\\t", with: "")) as String

        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)

    
        self.attributedText = attrStr
    }
}
