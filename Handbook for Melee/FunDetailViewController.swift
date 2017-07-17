//
//  FunDetailViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 2/23/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class FunDetailViewController: HandbookViewController {
    
    var fun : String? = ""
    var type : String? = ""
    
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = fun
        
        let text = XMLHelper.getDescFromXML(type: type!, title: fun!)
        
        infoTextView.setHTMLFromString(htmlText: text)
        infoTextView.isEditable = false;
        infoTextView.dataDetectorTypes = UIDataDetectorTypes.link;
        infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        infoTextView.theme_textColor = ["#000", "#FFF"]
        infoTextView.theme_backgroundColor = ["#fafafa", "#212121"]
    }
 
    override func viewWillAppear(_ animated: Bool) {
        infoTextView.isScrollEnabled = false
        self.title = fun
        
        if !adsAreRemoved() {
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        infoTextView.isScrollEnabled = true
        if !adsAreRemoved() {
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 62, 16)
        } else {
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
    }
}
