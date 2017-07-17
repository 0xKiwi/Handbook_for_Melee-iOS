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
        
        let defaults = UserDefaults.standard   
        if title != "characters" {
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
        } else {
            if (defaults.bool(forKey: "tier_pref")) {
                titleList = ["Fox", "Falco", "Marth", "Sheik", "Jigglypuff", "Princess Peach",
                        "Ice Climbers", "Captain Falcon", "Pikachu", "Samus",
                        "Dr. Mario", "Yoshi", "Luigi", "Ganondorf",
                        "Mario", "Young Link", "Donkey Kong", "Link", "Mr. Game & Watch", "Roy",
                        "Mewtwo", "Princess Zelda", "Ness", "Pichu", "Bowser", "Kirby"]  
                
                let main = defaults.string(forKey: SettingsViewController.MAIN_PREF)
                if main != nil {
                if(main != "None" && titleList.contains(main!)) {
                   titleList.remove(at: titleList.index(of: main!)!)
                    titleList.insert(main!, at: 0)
                }
                }
            } else {
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

                } catch {
                    print("\(error)")
                }

                titleList = titleList.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }

                let main = defaults.string(forKey: SettingsViewController.MAIN_PREF)
                    if main != nil {
                if(main != "None" && titleList.contains(main!)) {
                   titleList.remove(at: titleList.index(of: main!)!)
                    titleList.insert(main!, at: 0)
                }
                }
            }
        }
        
        return titleList;
    }
    
    static func getTitleListFromXMLNoSort(title: String) -> [String] {
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
        
        return titleList
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
    
    static func getDescFromXML(type : String, title: String) -> String {
        
        guard
            let xmlPath = Bundle.main.path(forResource: type.lowercased(), ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return "MELEEISFAIRANDBALANCED"}
        
        do {
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for child in xmlDoc.root.children {
                if child.attributes["title"]! == title {
                    return child.string.condenseWhitespace()
                }
            }
            
        }
        catch {
            print("\(error)")
        }
        
        return "MELEEISFAIRANDBALANCED"
    }
    
    static func getTitleAndDescListFromXMLSearch(title: String) -> ([String], [String]) {
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
                titleList.append(child.attributes["title"]!.stripHTML())
                descList.append(child.string.condenseWhitespace().stripHTML())
            }
            
        }
        catch {
            print("\(error)")
        }
        
        return (titleList, descList)
    }
    
    
    static func getCharListFromXML(title: String) -> [String] {
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
                let chars = child.attributes["character"]?.components(separatedBy: "/")
                for name in chars! {
                    if !titleList.contains(name) {
                        titleList.append(name)
                    }
                }
            }
            
        } catch {
            print("\(error)")
        }
        
        let defaults = UserDefaults.standard
            if (defaults.bool(forKey: "tier_pref")) {
                var tierList = ["Fox", "Falco", "Marth", "Sheik", "Jigglypuff", "Princess Peach",
                             "Ice Climbers", "Captain Falcon", "Pikachu", "Samus",
                             "Dr. Mario", "Yoshi", "Luigi", "Ganondorf",
                             "Mario", "Young Link", "Donkey Kong", "Link", "Mr. Game & Watch", "Roy",
                             "Mewtwo", "Princess Zelda", "Ness", "Pichu", "Bowser", "Kirby"]
                
                let main = defaults.string(forKey: SettingsViewController.MAIN_PREF)
                if main != nil {
                    if(main != "None" && titleList.contains(main!)) {
                        tierList.remove(at: titleList.index(of: main!)!)
                        tierList.insert(main!, at: 0)
                    }
                }
                
                for char in tierList {
                    if !titleList.contains(char) {
                        tierList.remove(at: tierList.index(of: char)!)
                    }
                }
                
                titleList = tierList
            } else {
                titleList = titleList.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
                
                let main = defaults.string(forKey: SettingsViewController.MAIN_PREF)
                if main != nil {
                    if(main != "None" && titleList.contains(main!)) {
                        titleList.remove(at: titleList.index(of: main!)!)
                        titleList.insert(main!, at: 0)
                    }
                }
            }
        
        return titleList;
    }
    
    
    static func getMoveListByCharFromXML(charList: [String]) -> [UniqueTechCharItem] {
        var titleList = [UniqueTechCharItem]()
        
        guard
            let xmlPath = Bundle.main.path(forResource: "uniquetech", ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return titleList}
        
        do {
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for char in charList {
                var moves = UniqueTechCharItem()
                for child in xmlDoc.root.children {
                    let chars = child.attributes["character"]?.components(separatedBy: "/")
                    moves.char = char
                    nameCheck: for name in chars! {
                        if(char == name) {
                            moves.moveList.append(child.attributes["title"]!)
                            break nameCheck
                        }
                    }
                }
                titleList.append(moves)
            }
            
        } catch {
            print("\(error)")
        }
        
        return titleList;
    }
    
    static func getItemListForTabFromXML(title: String, tech: String) -> [String] {
        var descList = [String]()
        
        guard
            let xmlPath = Bundle.main.path(forResource: title, ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return descList}
        
        do {
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for child in xmlDoc.root.children {
                print("\(child.name)")
                if (child.name == "string-array" && child.attributes["title"]! == tech) {
                    for childs in child.children {
                        descList.append(childs.attributes["title"]!)
                    }
                }
            }
        }
        catch {
            print("\(error)")
        }
        
        return descList
    }
    
    static func getTextForTabFromXML(title: String, tech: String) -> String {
        guard
            let xmlPath = Bundle.main.path(forResource: title, ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return "MELEEEEE"}
        
        do {
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for child in xmlDoc.root.children {
                if (child.name == "string-array") {
                    for childs in child.children {
                        if childs.attributes["title"]! == tech {
                            return childs.string.condenseWhitespace()
                        }
                    }
                }
            }
            
        }
        catch {
            print("\(error)")
        }
        
        return "MELEE"
    }
    
    static func getIfTab(title: String, tech: String) -> Bool {
        guard
            let xmlPath = Bundle.main.path(forResource: title, ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return false}
        
        do {
            var options = AEXMLOptions()
            options.parserSettings.shouldProcessNamespaces = true
            options.parserSettings.shouldReportNamespacePrefixes = true
            options.parserSettings.shouldResolveExternalEntities = true
            
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            
            for child in xmlDoc.root.children {
                if (child.name == "string-array") {
                    if(child.attributes["title"] == tech) {
                        return true
                    }
                }
            }
            
        }
        catch {
            print("\(error)")
        }
        
        return false
    }
}
