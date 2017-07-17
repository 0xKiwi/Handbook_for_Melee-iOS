//
//  Trim+Extension.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/29/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import Foundation
import CoreFoundation

extension String {
    func condenseWhitespace() -> String {
        return self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
    var utf8Data: Data? {
        return data(using: .utf8)
    }
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func stripHTML() -> String{
        do {
            let regex =  "<[^>]+>"
            let expr = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
            let replacement = expr.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.characters.count), withTemplate: "")
            return replacement
        } catch {
            // regex was bad!
        }
        return ""
    }

    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.characters.count else {
                return ""
            }
        }

        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }

        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }

        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }

        let endIndex: String.Index
        if let end = to, end >= 0, end < self.characters.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }

        return self[startIndex ..< endIndex]
    }

    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }

    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }

    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }

        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }

        return self.substring(from: from, to: end)
    }
    
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }

    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }

        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }

        return self.substring(from: start, to: to)
    }
    
    //func containsIgnoringCase(find: String) -> Bool{
    //    return self.range find, options: NSString.CompareOptions.CaseInsensitiveSearch) != nil
    //}
}
