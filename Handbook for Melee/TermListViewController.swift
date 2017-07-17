//
//  TermListViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/28/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class TermListViewController: HandbookViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleList = [String]()
    var descList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (titleList, descList) = XMLHelper.getTitleAndDescListFromXML(title: restorationIdentifier!)
        
        tableView.delegate = self
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableViewAutomaticDimension
        decorateTableView(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Terminology"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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

