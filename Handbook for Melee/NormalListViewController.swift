//
//  TechniqueViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/26/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import AEXML

class NormalListViewController:  UIViewController, UITableViewDataSource {
    
    var titleList = [String]()
    
    override func viewDidLoad() {
        titleList = XMLHelper.getTitleListFromXML(title: restorationIdentifier!)
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
}
