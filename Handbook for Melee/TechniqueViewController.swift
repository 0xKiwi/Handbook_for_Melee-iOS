//
//  TechniqueViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/26/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import AEXML

class TechniqueViewController:  UIViewController, UITableViewDataSource {
    
    var titleList = [String]()
    
    override func viewDidLoad() {
        populateArray()
        super.viewDidLoad()
        
        self.title = title;
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of rows, returns int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    //Contents of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = titleList[indexPath.row]
        return cell
    }
    
    func populateArray(){
        
        guard
            let xmlPath = Bundle.main.path(forResource: restorationIdentifier, ofType: "xml"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: xmlPath))
            else { return }
        
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
        
        titleList = titleList.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }

    }
}
