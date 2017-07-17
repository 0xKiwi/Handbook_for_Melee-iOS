//
//  HitboxDetailViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 3/15/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal

class HitboxDetailViewController: HandbookViewController {
    
    var character : String = ""
    var moveShort : String = ""
    var moveName : String = ""
    var moveType : String = ""
    
    var images : [String] = []

    var isPlaying : Bool = false
    
    @IBOutlet weak var frameText: UILabel!
    @IBOutlet weak var lagText: UILabel!
    @IBOutlet weak var iasaText: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var frameImage: UIImageView!
    
    var timer = Timer()
    
    var frame = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lagText.text = HitboxHelper.getLandLag(character: character, move: moveShort)
        iasaText.text = HitboxHelper.getIASA(character: character, move: moveShort)
    
        let path = "hitboxes/" + getFileName(title: character) + "/" +
            getFileName(title: moveType) + "/" + moveShort
        
        frameImage.frame = CGRect.init(x: frameImage.bounds.origin.x, y: frameImage.bounds.origin.y, width: frameImage.bounds.width, height: frameImage.bounds.width)
        
        assignFrame()
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        playButton.addGestureRecognizer(longGesture)
        
        images = getListFromFolder(path: path)
        frameText.text = "\(frame + 1)" + "/" + "\(images.count)"
        
        frameText.theme_textColor = ["#000", "#FFF"]
        frameText.theme_backgroundColor = ["#fafafa", "#212121"]
        
        lagText.theme_textColor = ["#000", "#FFF"]
        lagText.theme_backgroundColor = ["#fafafa", "#212121"]
        
        iasaText.theme_textColor = ["#000", "#FFF"]
        iasaText.theme_backgroundColor = ["#fafafa", "#212121"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !adsAreRemoved() {
            Appodeal.showAd(AppodealShowStyle.bannerBottom, rootViewController: self);
            Appodeal.setBannerBackgroundVisible(false)
        } else {
            Appodeal.hideBanner()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func playAnim(_ sender: UIButton) {
        if(!isPlaying){
            play()
        } else {
            isPlaying = false;
            timer.invalidate()
        }
    }
    
    
    func longTap(){
        if(!isPlaying){
            print("Long tap")
            fastPlay()
        }
    }
    
    func play() {
        if frame < images.count - 1 {
            isPlaying = true;
            timer = Timer.scheduledTimer(timeInterval: 0.051, target: self, selector: #selector(animFrame), userInfo: nil, repeats: true)
        } else {
            frame = 0
            play()
        }
    }
    
    func fastPlay() {
        if frame < images.count - 1 {
            isPlaying = true;
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.017, target: self, selector: #selector(animFrame), userInfo: nil, repeats: true)
        } else {
            frame = 0
            fastPlay()
        }
    }
    
    @IBAction func backFrame(_ sender: UIButton) {
        if frame > 0 {
            isPlaying = false;
            timer.invalidate()
            frame -= 1
            assignFrame()
        }
    }
    
    @IBAction func nextFrame(_ sender: UIButton) {
        if frame < images.count - 1 {
            isPlaying = false;
            timer.invalidate()
            frame += 1
            assignFrame()
        }
    }
    
    func animFrame() {
        if frame < images.count - 1 {
            frame += 1
            assignFrame()
        } else {
            frame = 0
            assignFrame()
        }
    }
    
    func getListFromFolder(path: String) -> [String] {
        var files : [String] = []
        
        let soundPath = (Bundle.main.resourcePath! as NSString).appendingPathComponent(path)
        
        do {
            files = try FileManager.default.contentsOfDirectory(atPath: soundPath)
        } catch {
            print(error)
        }
        
        return files
    }
    
    func assignFrame(){
        frameText.text = "\(frame + 1)" + "/" + "\(images.count)"
        
        let shortPath = "hitboxes/" + getFileName(title: character) + "/" +
            getFileName(title: moveType) + "/" + moveShort + "/"
        
        let frameName = "\(frame)"
        
        if let audioFilePath = Bundle.main.path(forResource: frameName, ofType: "jpg", inDirectory: shortPath) {
            print(audioFilePath)
            frameImage.image = UIImage(contentsOfFile: audioFilePath)
        }
    }
    
    func playAnim(sender:UIButton!) {
		 print("Button Clicked")
	}
	
    func longPlayAnim(sender:UIButton!) {
		 print("Button Clicked")
		 
		 if frame != 0 {
			frame -= 1
			assignFrame()
		}
	}
    
    func longBackFrame(sender:UIButton!) {
		 print("Button Clicked")
		 
		 if frame > 10 {
			frame -= 10
			assignFrame()
		}
	}
	
    func longNextFrame(sender:UIButton!) {
		 print("Button Clicked")
		 
		 if frame < images.count - 10{
			frame += 10
			assignFrame()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
