//
//  FunViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/1/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class FunViewController: HandbookViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleList = [String]()
    
    let type = "Fundamentals"
    var tech : String! = "Common errors"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleList = XMLHelper.getTitleListFromXML(title: "fundamentals")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        decorateTableView(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = type
        if !adsAreRemoved() {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
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
        
        decorateCell(cell: cell)
        
        cell.textLabel?.text = titleList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        tech = titleList[indexPath.row]
        
        print(tech)
        
        performSegue(withIdentifier: "fundetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "fundetail" {
            let controller = segue.destination as! FunDetailViewController
            controller.navigationItem.title = tech
            controller.fun = tech
            controller.type = "fundamentals"
        }
    }
}
