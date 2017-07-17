//
//  NavigationControllerViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/27/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class NavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 48.0/255.0, green: 63.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationBar.tintColor = UIColor.white;
    }
}
