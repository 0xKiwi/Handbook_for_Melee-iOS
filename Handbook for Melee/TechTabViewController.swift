//
//  TechTabViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 3/26/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit

import XLPagerTabStrip

class TechTabViewController : TwitterPagerTabStripViewController {
    
    var technique : String = ""
    var type : String = ""
    var tabHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("THIS IS TECHCONTROLLER")
        
        
        // change selected bar color
        settings.style.dotColor = .white
        settings.style.selectedDotColor = .yellow
        settings.style.titleColor = .white
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let items = XMLHelper.getItemListForTabFromXML(title: type, tech: technique)
        
        var tabs : [TabItemViewController] = []
        
        var count = 1
        for item in items {
            let tab = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabitem" + "\(count)") as! TabItemViewController
            count += 1
            tab.technique = item
            tab.type = type
            
            var tabHeight = CGFloat.init(0.0)
            if tabHidden {
                tabHeight = 0
            } else {
                tabHeight = 49
            }
            tab.tab = tabHeight
        
            tabs.append(tab)
        }
        return tabs
    }
}
