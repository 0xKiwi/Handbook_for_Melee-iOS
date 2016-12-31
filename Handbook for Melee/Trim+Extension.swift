//
//  Trim+Extension.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/29/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import Foundation

extension String {
    func condenseWhitespace() -> String {
        return self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}
