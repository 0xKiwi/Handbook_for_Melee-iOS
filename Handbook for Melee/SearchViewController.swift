//
//  SearchViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 4/6/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit

class SearchViewController: HandbookViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleList = [String]()
    var descList = [InfoItem]()
    
    var searchHelper = SearchHelper()
    
    var searchController : UISearchController? = nil
    
    var technique : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        
        searchController?.delegate = self
        searchController?.searchBar.delegate = self
        
        let statusBarView = UIView(frame: CGRect.init(x:0, y: 0,
                                                      width: UIApplication.shared.statusBarFrame.size.width,
                                                      height: UIApplication.shared.statusBarFrame.size.height))
        statusBarView.backgroundColor = UIColor(red: 48.0/255.0, green: 63.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        searchController?.view.addSubview(statusBarView)
        
        searchController?.searchResultsUpdater = self
        searchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController?.searchBar
        
        tableView.delegate = self
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableViewAutomaticDimension
        decorateTableView(tableView: tableView)
        
        searchController?.searchBar.theme_barTintColor = ["#c8c7cc", "#4d4d4d"]
        UISearchBar.appearance().theme_tintColor = ["#303f9f", "#FDD835"]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController?.isActive)! && searchController?.searchBar.text != "" {
            return titleList.count
        }
        return titleList.count
    }
    
    //Contents of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchs", for: indexPath) as! DynamicTableViewCell
        
        let title = titleList[indexPath.row]
        let subtitle = descList[indexPath.row].desc
        
        if descList[indexPath.row].type == 0 {
            cell.subtitleLAbel.isSelectable = true
        } else {
            cell.subtitleLAbel.isUserInteractionEnabled = false
        }
        
        cell.textLabel?.theme_textColor = ["#000", "#FFF"]
        cell.subtitleLAbel?.theme_textColor = ["#000", "#FFF"]
        
        cell.titleLabel?.text = title
        cell.subtitleLAbel?.text = subtitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        technique = titleList[indexPath.row]
        
        launch(type: descList[indexPath.row].type)
        
        /*final let TERMS = 0
         final let TECHS = 1
         final let UNIQUES = 2
         final let FUNS = 3
         final let CHARACTERS = 4
         final let MAPS = 5*/
    }
    
    func launch(type : Int) {
        switch (type) {
        case 0:
            break;
        case 1:
            if(XMLHelper.getIfTab(title: "standardtech", tech: technique)) {
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Technique tab detail") as! TechTabViewController
                secondViewController.technique = technique
                secondViewController.type = "standardtech"
                secondViewController.tabHidden = true
                self.title = "Search"
                self.navigationController?.pushViewController(secondViewController, animated: true)
            } else {
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Technique detail") as! VideoViewController
                secondViewController.technique = technique
                secondViewController.type = "standardtech"
                secondViewController.tab = true
                self.title = "Search"
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        case 2:
            if(XMLHelper.getIfTab(title: "uniquetech", tech: technique)) {
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Unique tab detail") as! TechTabViewController
                secondViewController.technique = technique
                secondViewController.type = "uniquetech"
                secondViewController.tabHidden = true
                self.title = "Search"
                self.navigationController?.pushViewController(secondViewController, animated: true)
            } else {
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Unique detail") as! VideoViewController
                secondViewController.technique = technique
                secondViewController.tab = true
                secondViewController.type = "uniquetech"
                self.title = "Search"
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
        case 3:
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Fundamental detail") as! FunDetailViewController
            secondViewController.fun = technique
            secondViewController.type = "fundamentals"
            self.title = "Search"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        case 4:
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Character detail") as! ImageViewController
            secondViewController.character = technique
            secondViewController.type = "characters"
            secondViewController.tab = true
            self.title = "Search"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        case 5:
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Stage detail") as! ImageViewController
            secondViewController.character = technique
            secondViewController.type = "stages"
            secondViewController.tab = true
            self.title = "Search"
            self.navigationController?.pushViewController(secondViewController, animated: true)
        default:
            print("meme")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        (titleList, descList) = searchHelper.getSearchResults(search: searchBar.text!)
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        //(titleList, descList) = searchHelper.getSearchResults(search: searchBar.text!)
        //tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Search for info"
    }
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
