//
//  SearchHelper.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 2/23/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//
import UIKit
import Foundation

class SearchHelper {
    
    final let TERMS = 0
    final let TECHS = 1
    final let UNIQUES = 2
    final let FUNS = 3
    final let CHARACTERS = 4
    final let MAPS = 5
    
    var terms: [String] = []
    var techs: [String] = []
    var uniques: [String] = []
    var funs: [String] = []
    var characters: [String] = []
    var maps: [String] = []
    
    var termInfo: [String] = []
    var techInfo: [String] = []
    var uniqueInfo: [String] = []
    var funInfo: [String] = []
    var characterInfo: [String] = []
    var mapInfo: [String] = []
    
    init(){
        (terms, termInfo) = XMLHelper.getTitleAndDescListFromXMLSearch(title: "terms")
        (techs, techInfo) = XMLHelper.getTitleAndDescListFromXMLSearch(title: "standardtech")
        (uniques, uniqueInfo) = XMLHelper.getTitleAndDescListFromXMLSearch(title: "uniquetech");
        (funs, funInfo) = XMLHelper.getTitleAndDescListFromXMLSearch(title: "fundamentals");
        (characters, characterInfo) = XMLHelper.getTitleAndDescListFromXMLSearch(title: "characters")
        (maps, mapInfo) = XMLHelper.getTitleAndDescListFromXMLSearch(title: "stages")
    }
    
    func setDescHTMLFromString(htmlText: String) -> String {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.preferredFont(forTextStyle: UIFontTextStyle.callout).pointSize)\">%@</span>" as NSString, htmlText.replacingOccurrences(of: "\\t", with: "")) as String
        
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        return attrStr.string
    }
    
    static func setDescHTMLFromString(htmlText: String) -> NSAttributedString {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline).pointSize)\">%@</span>" as NSString, htmlText.replacingOccurrences(of: "\\t", with: "")) as String
        
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        
        return attrStr
    }
    
    static func setTitleHTMLFromString(htmlText: String) -> NSAttributedString {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3).pointSize)\">%@</span>" as NSString, htmlText.replacingOccurrences(of: "\\t", with: "")) as String
        
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        return attrStr
    }

    public static func highlight(search: String, originalText: String) -> String{
        let searchString = search
        let baseString = originalText
        
        let attributed = NSMutableAttributedString(string: baseString)
        
       /*do {
            let regex = try NSRegularExpression(pattern: searchString, options: .caseInsensitive)
            for match in try regex.matches(in: baseString, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSRange(location: 0, length: baseString.characters.count)) as [NSTextCheckingResult] {
                attributed.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellow, range: match.range)
            }
            
            return attributed
        } catch {
            
        }*/
        return baseString
    }
    
    func highlightAndCut(search: String, originalText: String) -> String {
        var mystring = originalText.lowercased()
        mystring = mystring.replacingOccurrences(of: "\t", with: "")
        
        var startPos = 0
        var endPos = 0
        if let range = mystring.range(of: search) {
            startPos = mystring.distance(from: mystring.startIndex, to: range.lowerBound)
            endPos = mystring.distance(from: mystring.startIndex, to: range.upperBound)
        }
        
        if startPos > 100 {
            startPos -= 100
        } else {
            startPos = 0
        }
        
        if endPos + 100 < mystring.characters.count {
            endPos += 100
        } else {
            endPos = mystring.characters.count - 1
        }
    
        mystring = mystring.substring(from: startPos, to: endPos).condenseWhitespace()
        
        if endPos != mystring.characters.count - 1{
            mystring = mystring.condenseWhitespace()
        }
        
        
        /*int wholeStart = string.toLowerCase().indexOf(" ", startPos - 100);
         if(wholeStart == -1) wholeStart = 0;
         
         if(string.substring(wholeStart, wholeStart + 1).equals(",")) wholeStart += 1;
         
         int wholeEnd = string.toLowerCase().indexOf(" ", endPos + 100 < string.length
         () - 1 ? endPos + 100 : endPos - search.length() - 1);
         
         if(wholeEnd == -1)
         wholeEnd = endPos;*/
        
        return mystring + " (Click for more)"
    }
    
    func getStringFromHTML(htmlText: String) -> NSAttributedString {
        let modifiedFont = NSString(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(CGFloat.init(14))\">%@</span>" as NSString, htmlText.replacingOccurrences(of: "\\t", with: "")) as String
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        return attrStr
    }
    
    func getSearchResults(search: String) -> (titles: [String], desc: [InfoItem]) {
        let query = search.lowercased()
        var titles: [String] = []
        var desc: [InfoItem] = []
        
        //TODO MOVE EACH THING TO ITS OWN METHOD
        
        //if (prefs.getBoolean(TERM_KEY, true))
        for index in 0..<terms.count {
            if terms[index].lowercased().contains(query) {
                titles.append(terms[index])
                desc.append(InfoItem(dscript: SearchHelper.highlight(search: query, originalText: termInfo[index]), name: TERMS))
            }
        }
        
        //if (prefs.getBoolean(TECH_KEY, true))
        for index in 0..<techs.count {
            if techs[index].lowercased().contains(query) {
                titles.append(techs[index])
                desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: techInfo[index]), name: TECHS))
            }
        }
        
        //if (prefs.getBoolean(UNIQUE_KEY, true))
        for index in 0..<uniques.count {
            if uniques[index].lowercased().contains(query) {
                titles.append(uniques[index])
                desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: uniqueInfo[index]), name: UNIQUES))
            }
        }
        
        //if (prefs.getBoolean(FUN_KEY, true))
        for index in 0..<funs.count {
            if funs[index].lowercased().contains(query) {
                titles.append(funs[index])
                desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: funInfo[index]), name: FUNS))
            }
        }
        
        //if (prefs.getBoolean(CHAR_KEY, true))
        for index in 0..<characters.count {
            if characters[index].lowercased().contains(query) {
                titles.append(characters[index])
                desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: characterInfo[index]), name: CHARACTERS))
            }
        }
        
        //if (prefs.getBoolean(MAP_KEY, true))
        for index in 0..<maps.count {
            if maps[index].lowercased().contains(query) {
                titles.append(maps[index])
                desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: mapInfo[index]), name: MAPS))
            }
        }
        
        //if (prefs.getBoolean(TERM_KEY, true))
        for index in 0..<terms.count {
            if !terms[index].lowercased().contains(query) {
                if termInfo[index].lowercased().contains(query) {
                    titles.append(terms[index])
                    desc.append(InfoItem(dscript: SearchHelper.highlight(search: query, originalText: termInfo[index]), name: TERMS))
                }
            }
        }
        
        //if (prefs.getBoolean(TECH_KEY, true))
        for index in 0..<techs.count {
            if !techs[index].lowercased().contains(query) {
                if techInfo[index].lowercased().contains(query) {
                    titles.append(techs[index])
                    desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: techInfo[index]), name: TECHS))
                }
            }
        }
        
        //if (prefs.getBoolean(UNIQUE_KEY, true))
        for index in 0..<uniques.count {
            if !uniques[index].lowercased().contains(query) {
                if uniqueInfo[index].lowercased().contains(query) {
                    titles.append(uniques[index])
                    desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: uniqueInfo[index]), name: UNIQUES))
                }	
            }
        }
        
        //if (prefs.getBoolean(FUN_KEY, true))
        for index in 0..<funs.count {
            if !funs[index].lowercased().contains(query) {
                if funInfo[index].lowercased().contains(query) {
                    titles.append(funs[index])
                    desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: funInfo[index]), name: FUNS))
                }
            }
        }
        
        //if (prefs.getBoolean(CHAR_KEY, true))
        for index in 0..<characters.count {
            if !characters[index].lowercased().contains(query) {
                if (characterInfo[index].lowercased().contains(query)) {
                    titles.append(characters[index])
                    desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: characterInfo[index]), name: CHARACTERS))
                }
            }
        }
        
        //if (prefs.getBoolean(MAP_KEY, true))
        for index in 0..<maps.count {
            if !maps[index].lowercased().contains(query) {
                if (mapInfo[index].lowercased().contains(query)) {
                    titles.append(maps[index])
                    desc.append(InfoItem(dscript: highlightAndCut(search: query, originalText: mapInfo[index]), name: MAPS))
                }
            }
        }
        
        return (titles, desc)
    }
}
