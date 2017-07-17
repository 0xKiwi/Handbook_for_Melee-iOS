//
//  TechniqueViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/26/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import AEXML
import Appodeal

class StagesViewController:  HandbookViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let type = "Stages"
    var stage : String!
    
    var titleList = [String]()
    
    override func viewDidLoad() {
        titleList = XMLHelper.getTitleListFromXML(title: type.lowercased())
        super.viewDidLoad()
        
        self.tabBarController?.moreNavigationController.navigationBar.backItem?.title = "More"
        
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
        setImageToTableViewCell(tableCell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        stage = titleList[indexPath.row]
        print(titleList[indexPath.row])
        
        performSegue(withIdentifier: "stagedetail", sender: self)
    }
    
    func setImageToTableViewCell(tableCell : UITableViewCell){
        switch(tableCell.textLabel?.text) {
        case "Kongo Jungle (SSB)"?:
            tableCell.imageView?.image = UIImage(named: "dkicon")
        case "Dream Land"?, "Fountain of Dreams"?:
            tableCell.imageView?.image = UIImage(named: "kirbyicon")
        case "Pokemon Stadium"?:
            tableCell.imageView?.image = UIImage(named: "pokemonicon")
        case "Yoshi's Story"?:
            tableCell.imageView?.image = UIImage(named: "yoshiicon")
        case "Battlefield"?, "Final Destination"?:
            tableCell.imageView?.image = UIImage(named: "smashicon")
        default:
            tableCell.imageView?.image = UIImage(named: "smashicon")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "stagedetail" {
            let controller = segue.destination as! ImageViewController
            controller.character = stage
            controller.type = "Stages"
        }
    }
}
