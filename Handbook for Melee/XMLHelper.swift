//
//  XMLHelper.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/28/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import Foundation
import AEXML

class XMLHelper {
    static func getTitleListFromXML(title: String) -> [String] {
        var titleList = [String]()
        
        guard
            let xmlPath = Bundle.main.path(forResource: title, ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return titleList}
        
        do {
            
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for child in xmlDoc.root.children {
                titleList.append(child.attributes["title"]!)
            }
            
        }
        catch {
            print("\(error)")
        }
        
        return titleList.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
    }
    
    static func getTitleAndDescListFromXML(title: String) -> ([String], [String]) {
        var titleList = [String]()
        var descList = [String]()
        
        guard
            let xmlPath = Bundle.main.path(forResource: title, ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return (titleList,descList)}
        
        do {
            
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for child in xmlDoc.root.children {
                titleList.append(child.attributes["title"]!)
                descList.append(child.string.condenseWhitespace())
            }
            
        }
        catch {
            print("\(error)")
        }
        
        return (titleList, descList)
    }
}
