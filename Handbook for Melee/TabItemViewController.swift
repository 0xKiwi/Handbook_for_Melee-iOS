//
//  TabItemViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 4/4/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Player
import AVFoundation
import XLPagerTabStrip
import Appodeal

class TabItemViewController: HandbookViewController, IndicatorInfoProvider, PlayerDelegate {
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }

    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerReady(_ player: Player) {
        player.playFromBeginning()
    }
    
    var affiliation = ""
    var technique : String? = ""
    var type : String? = ""
    var tab = CGFloat.init(0.0)
    
    private var player: Player!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoTextView: UITextView!
    
    var screenSize: CGRect = CGRect.init()
    
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let text = XMLHelper.getTextForTabFromXML(title: type!, tech: technique!)
        
        infoTextView.setHTMLFromString(htmlText: text)
        infoTextView.frame = CGRect.init(x: 0.0, y: 300, width: screenWidth, height: 5000)
        if adsAreRemoved() {
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        } else {
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 62, 16)
        }
        infoTextView.isScrollEnabled = false;
        infoTextView.layoutIfNeeded()
        infoTextView.sizeToFit()
        infoTextView.isEditable = false;
        infoTextView.dataDetectorTypes = UIDataDetectorTypes.link;
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        infoTextView.theme_textColor = ["#000", "#FFF"]
        infoTextView.theme_backgroundColor = ["#fafafa", "#212121"]
        
        playVideo()
        scrollView.contentSize = CGSize.init(width: screenWidth, height: infoTextView.bounds.height + player.view.bounds.height)
        
        scrollView.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight - (49 + tab + 20))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.stop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player.playFromBeginning()
        
        if !adsAreRemoved() {
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func playVideo() {
        self.player = Player()
        self.player.view.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: 300)
        
        scrollView.addSubview(player.view)
        player.volume = 0
        
        do {
            let resourceUrl = try Bundle.main.url(forResource: getFileName(title: technique!), withExtension: "mp4")
            self.player.url = resourceUrl!
            
            //self.player.playFromBeginning()
            player.playbackLoops = true
            self.player.fillMode = AVLayerVideoGravityResize
            self.player.pause()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        var title : String = technique!
        
        switch (title) {
        case "Super wavedash":
            title = "Super"
        case "Super duper wavedash" :
            title = "Suder duper"
        case "Extended grapple" :
            title = "Extended"
        case "Homing grapple" :
            title = "Homing"
        case "Reverse wall jump" :
            title = "Reverse"
        default:
            title = technique!
        }
        
        return IndicatorInfo(title: title)
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
