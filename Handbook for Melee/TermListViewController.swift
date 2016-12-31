//
//  TermListViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/28/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit

class TermListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleList = [String]()
    var descList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (titleList, descList) = XMLHelper.getTitleAndDescListFromXML(title: restorationIdentifier!)
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        self.title = title;
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //Number of rows, returns int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return titleList.count
    }
    
    //Contents of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "terms", for: indexPath) as! DynamicTableViewCell
        
        cell.titleLabel?.text = titleList[indexPath.row]
        cell.subtitleLAbel?.text = descList[indexPath.row]
    
        return cell
    }
}

