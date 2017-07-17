//
//  VideoViewController.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/26/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import AVFoundation
import Player
import Appodeal

class VideoViewController: HandbookViewController, PlayerDelegate {
    func playerBufferTimeDidChange(_ bufferTime: Double) {
        
    }

    
    var affiliation = ""
    var technique : String? = ""
    var type : String? = ""
    
    var tab = false
    
    var screenSize: CGRect = CGRect.init()
    
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0
    
    private var player: Player!
    
    //@IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let text = XMLHelper.getDescFromXML(type: type!, title: technique!)
        
        self.automaticallyAdjustsScrollViewInsets = false;
        
        infoTextView.setHTMLFromString(htmlText: text)
        infoTextView.frame = CGRect.init(x: 0.0, y: 300, width: screenWidth, height: 5000)
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
        
        playVideo()
        
        var tabHeight = (tabBarController?.tabBar.frame.size.height)!
        if tab {
            tabHeight = 0
        }
        
        scrollView.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight - ((navigationController?.navigationBar.frame.size.height)! + tabHeight + UIApplication.shared.statusBarFrame.height))
        scrollView.contentSize = CGSize.init(width: screenWidth, height: infoTextView.bounds.height + player.view.bounds.height)
    }
    
    /*func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.bounds.intersects(player.view.frame) {
            if player.playbackState == PlaybackState.stopped {
                player.playFromBeginning()
            }
        } else {
            if player.playbackState == PlaybackState.playing {
                player.stop()
            }
        }
    }*/
    
    override func viewDidDisappear(_ animated: Bool) {
        player.stop()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.stop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = technique
        player.playFromBeginning()
        
        if !adsAreRemoved() {
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
            infoTextView.textContainerInset = UIEdgeInsetsMake(12, 16, 12, 16)
        }
    }
    
    func playVideo() {
        self.player = Player()
        self.player.view.frame = CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: 300)
        
        scrollView.addSubview(player.view)
        player.volume = 0
        
        let resourceUrl = Bundle.main.url(forResource: getFileName(title: technique!), withExtension: "mp4")
        self.player.url = resourceUrl!
        
        self.player.playFromBeginning()
        player.playbackLoops = true
        self.player.fillMode = AVLayerVideoGravityResize
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    func playerPlaybackStateDidChange(_ player: Player) {
        
    }
    
    func playerBufferingStateDidChange(_ player: Player) {
        
    }
    
    func playerReady(_ player: Player) {
        player.playFromBeginning()
    }
}
