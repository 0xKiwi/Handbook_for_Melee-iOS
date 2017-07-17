//
//  StageDetailViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 2/23/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class StageDetailViewController: HandbookViewController {
    
    var stage : String? = ""
    var type : String? = ""
    
    var tab = false

    var screenSize: CGRect = CGRect.init()
    
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let text = XMLHelper.getDescFromXML(type: type!, title: stage!)
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        imageView.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenWidth - 100)
        imageView.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: stage!))!, size: imageView.frame.size)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true;
        imageView.sizeToFit()
        
        infoTextView.setHTMLFromString(htmlText: text)
        infoTextView.frame = CGRect.init(x: 0.0, y: imageView.bounds.height, width: screenWidth, height: 7000)
        if !adsAreRemoved() {
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 62, 16)
        } else {
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
        infoTextView.isScrollEnabled = false;
        infoTextView.layoutIfNeeded()
        infoTextView.sizeToFit()
        infoTextView.isEditable = false;
        infoTextView.dataDetectorTypes = UIDataDetectorTypes.link;
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        infoTextView.theme_textColor = ["#000", "#FFF"]
        infoTextView.theme_backgroundColor = ["#fafafa", "#212121"]
        
        var tabHeight = (tabBarController?.tabBar.frame.size.height)!
        if tab {
            tabHeight = 0
        }
        
        scrollView.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight - ((navigationController?.navigationBar.frame.size.height)! + tabHeight + UIApplication.shared.statusBarFrame.height))
        scrollView.contentSize = CGSize.init(width: self.view.bounds.width, height: infoTextView.bounds.height + imageView.bounds.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
           
    override func viewWillAppear(_ animated: Bool) {
        self.title = stage
        
        if !adsAreRemoved() {
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
    }
}
