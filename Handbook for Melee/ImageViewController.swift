//
//  CharacterDetailViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 2/23/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class ImageViewController: HandbookViewController {
    
    var screenSize: CGRect = CGRect.init()
    
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0
    
    var character : String! = ""
    var type : String? = ""
    
    var tab = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        if !hasHitboxes() {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        let text = XMLHelper.getDescFromXML(type: type!, title: character!)
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        imageView.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenWidth)
        imageView.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: character!))!, size: imageView.frame.size)
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
        
        infoTextView.theme_textColor = ["#000", "#FFF"]
        infoTextView.theme_backgroundColor = ["#fafafa", "#212121"]
        
        var tabHeight = (tabBarController?.tabBar.frame.size.height)!
        if tab {
            tabHeight = 0
        }
        
        scrollView.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight - ((navigationController?.navigationBar.frame.size.height)! + tabHeight + UIApplication.shared.statusBarFrame.height))
        scrollView.contentSize = CGSize.init(width: self.view.bounds.width, height: infoTextView.bounds.height + imageView.bounds.height)
    }
    
    func hasHitboxes() -> Bool {
        switch (character) {
            case "Fox", "Falco", "Captain Falcon", "Luigi", "Marth",
                 "Sheik", "Jigglypuff", "Princess Peach", "Ice Climbers",
                 "Pikachu","Samus","Dr. Mario","Yoshi", "Ganondorf":
                return true;
            default:
                return false;
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        self.title = character
        
        if !adsAreRemoved() {
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        }  else {
            Appodeal.hideBanner()
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "hitboxes" {
            let controller = segue.destination as! HitboxViewController
            controller.navigationItem.title = "Hitboxes"
            controller.character = character
        }
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
