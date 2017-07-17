//
//  HealthsViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/1/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//
import UIKit

class HealthsViewController: HandbookViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sections : [String] = ["Important priorities", "Eye stretches", "Hand stretches"]
    let length : [Int] = [2, 5, 10]
    
    var titleList = [String]()
    
    let type = "Health"
    var tech : String! = "Mental health"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleList = XMLHelper.getTitleListFromXMLNoSort(title: "health")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        decorateTableView(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = type
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.theme_textColor = ["#000", "#FFF"]
        header.contentView.theme_backgroundColor = ["#c8c7cc", "#4d4d4d"]
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    //Number of rows, returns int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return length[section]
    }
    
    //Contents of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        var addition : Int = 0
        for index in 0..<indexPath.section {
            addition += length[index]
        }
        
        decorateCell(cell: cell)
        
        cell.textLabel?.text = titleList[addition + indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        var addition : Int = 0
        for index in 0..<indexPath.section {
            addition += length[index]
        }
        tech = titleList[addition + indexPath.row]
        
        print(tech)
        
        performSegue(withIdentifier: "healthdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "healthdetail" {
            let controller = segue.destination as! VideoViewController
            controller.navigationItem.title = tech
            controller.technique = tech
            controller.type = "health"
        }
}
}
