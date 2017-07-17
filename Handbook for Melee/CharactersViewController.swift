//
//  CharactersViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/1/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class CharactersViewController: HandbookViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let type = "Characters"
    var character : String = ""
    
    var titleList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let searchController = UISearchController(searchResultsController: SearchViewController())
        //searchController.dimsBackgroundDuringPresentation = false
        //definesPresentationContext = true
        //tableView.tableHeaderView = searchController.searchBar
        tableView.delegate = self
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
        
        let old = titleList
        titleList = XMLHelper.getTitleListFromXML(title: type.lowercased())
        if old != titleList {
            tableView.reloadData()
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

        character = titleList[indexPath.row]
        
        print(character)
        
        performSegue(withIdentifier: "chardetail", sender: self)
    }
    
    func setImageToTableViewCell(tableCell : UITableViewCell) {
        switch(tableCell.textLabel?.text) {
            case "Bowser"?:
                tableCell.imageView?.image = UIImage(named: "marioicon")
            case "Dr. Mario"?:
                tableCell.imageView?.image = UIImage(named: "marioicon")
            case "Mario"?:
                tableCell.imageView?.image = UIImage(named: "marioicon")
            case "Captain Falcon"?:
                tableCell.imageView?.image = UIImage(named: "fzeroicon")
            case "Donkey Kong"?:
                tableCell.imageView?.image = UIImage(named: "dkicon")
            case "Falco"?:
                tableCell.imageView?.image = UIImage(named: "falcoicon")
            case "Fox"?:
                tableCell.imageView?.image = UIImage(named: "foxicon")
            case "Ganondorf"?:
                tableCell.imageView?.image = UIImage(named: "zeldaicon")
            case "Ice Climbers"?:
                tableCell.imageView?.image = UIImage(named: "icicon")
            case "Jigglypuff"?:
                tableCell.imageView?.image = UIImage(named: "jiggsicon")
            case "Kirby"?:
                tableCell.imageView?.image = UIImage(named: "kirbyicon")
            case "Link"?:
                tableCell.imageView?.image = UIImage(named: "linkicon")
            case "Young Link"?:
                tableCell.imageView?.image = UIImage(named: "linkicon")
            case "Luigi"?:
                tableCell.imageView?.image = UIImage(named: "luigiicon")
            case "Marth"?:
                tableCell.imageView?.image = UIImage(named: "marthicon")
            case "Mewtwo"?:
                tableCell.imageView?.image = UIImage(named: "pokemonicon")
            case "Mr. Game & Watch"?:
                tableCell.imageView?.image = UIImage(named: "gandwicon")
            case "Ness"?:
                tableCell.imageView?.image = UIImage(named: "ebicon")
            case "Pichu"?, "Pikachu"?:
                tableCell.imageView?.image = UIImage(named: "pikaicon")
            case "Princess Peach"?:
                tableCell.imageView?.image = UIImage(named: "peachicon")
            case "Princess Zelda"?:
                tableCell.imageView?.image = UIImage(named: "zeldaicon")
            case "Roy"?:
                tableCell.imageView?.image = UIImage(named: "royicon")
            case "Samus"?:
                tableCell.imageView?.image = UIImage(named: "metroidicon")
            case "Sheik"?:
                tableCell.imageView?.image = UIImage(named: "zeldaicon")
            case "Yoshi"?:
                tableCell.imageView?.image = UIImage(named: "yoshiicon")
        default:
            tableCell.imageView?.image = UIImage(named: "marioicon")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "chardetail" {
                let controller = segue.destination as! ImageViewController
                controller.character = character
                controller.type = type
        }
    }
}
