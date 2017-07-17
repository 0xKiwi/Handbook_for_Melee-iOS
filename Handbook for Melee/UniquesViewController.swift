//
//  UniquesViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/1/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class UniquesViewController: HandbookViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var sectionList = [String]()
    var movesList = [UniqueTechCharItem]()
    var titleList = [String]()
    
    let type = "Unique Tech"
    var tech : String! = "Chillin dash"
    
    var stretch = false
    var grouped = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleList = XMLHelper.getTitleListFromXML(title: "uniquetech")
        
        grouped = UserDefaults.standard.bool(forKey: SettingsViewController.GROUP_PREF)
        sectionList = XMLHelper.getCharListFromXML(title: "uniquetech")
        movesList = XMLHelper.getMoveListByCharFromXML(charList: sectionList)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        decorateTableView(tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if grouped {
            return 40
        } else {
            return 0.1
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.theme_textColor = ["#000", "#FFF"]
        header.contentView.theme_backgroundColor = ["#c8c7cc", "#4d4d4d"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (grouped) {
            return sectionList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (grouped) {
            return sectionList[section]
        } else {
            return ""
        }
    }
    
    
    //Number of rows, returns int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (grouped) {
            return movesList[section].moveList.count
        } else {
            return titleList.count
        }
    }
    
    //Contents of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        decorateCell(cell: cell)
        
        if (grouped) {
            cell.textLabel?.text = movesList[indexPath.section].moveList[indexPath.row]
        } else {
            cell.textLabel?.text = titleList[indexPath.row]
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !stretch {
            showToast(message: "Don't forget to stretch and take breaks!")
            stretch = true
        }
        
        if grouped != UserDefaults.standard.bool(forKey: SettingsViewController.GROUP_PREF) {
            grouped = UserDefaults.standard.bool(forKey: SettingsViewController.GROUP_PREF)
            if !grouped {
            }
            tableView.reloadData()
        }
        
        self.navigationItem.title = type;
        if !adsAreRemoved() {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        if (grouped) {
            tech = movesList[indexPath.section].moveList[indexPath.row]
        } else {
            tech = titleList[indexPath.row]
        }
        
        print(tech)
        
        if(XMLHelper.getIfTab(title: "uniquetech", tech: tech)) {
            performSegue(withIdentifier: "uniquetabdetail", sender: self)
        } else {
            performSegue(withIdentifier: "uniquedetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "uniquetabdetail" {
            let controller = segue.destination as! TechTabViewController
            controller.navigationItem.title = tech
            controller.technique = tech
            controller.type = "uniquetech"
        }
        else if segue.identifier == "uniquedetail" {
            let controller = segue.destination as! VideoViewController
            controller.navigationItem.title = tech
            controller.technique = tech
            controller.type = "uniquetech"
        }
    }
}
