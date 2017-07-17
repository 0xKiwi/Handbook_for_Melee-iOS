//
//  MainTabBarController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/27/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import SwiftTheme

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        tabBar.theme_backgroundColor = ["#fafafa", "#212121"]
        tabBar.theme_barTintColor = ["#fafafa", "#212121"]
        tabBar.theme_tintColor = ["#303f9f", "#FDD835"]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "More";
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 48.0/255.0, green: 63.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        self.moreNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.moreNavigationController.navigationBar.tintColor = UIColor.white;
        self.moreNavigationController.navigationBar.barStyle = UIBarStyle.blackOpaque;
        self.moreNavigationController.navigationBar.isTranslucent = false;
        
        let moreTableView = self.moreNavigationController.topViewController?.view as! UITableView
        moreTableView.theme_backgroundColor = ["#fafafa", "#212121"]
        moreTableView.theme_separatorColor = ["#c8c7cc", "#4d4d4d"]
        
        for cell in moreTableView.visibleCells {
            decorateCell(cell: cell)
        }
    }
    
    func decorateCell(cell: UITableViewCell){
        cell.theme_backgroundColor = ["#fafafa", "#212121"]
        cell.textLabel?.theme_textColor = ["#000", "#FFF"]
        
        let bg = UIView()
        bg.theme_backgroundColor = ["#eee", "#303030"]
        cell.selectedBackgroundView = bg
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
