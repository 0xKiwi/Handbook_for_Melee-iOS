//
//  MatchupViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/4/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit

class MatchupViewController: HandbookViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var muImgRight: UIImageView!
    @IBOutlet weak var muImgLeft: UIImageView!
    
    @IBOutlet weak var spinnerLeft: UIPickerView!
    @IBOutlet weak var spinnerRight: UIPickerView!
    
    @IBOutlet weak var charLeft: UILabel!
    @IBOutlet weak var charRight: UILabel!
    
    @IBOutlet weak var leftDetail: UILabel!
    @IBOutlet weak var rightDetail: UILabel!
    
    @IBOutlet weak var vsText: UILabel!
    
    var characterLeft : String = ""
    var characterRight : String = ""
    
    var pickerDataSource : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Matchups"
        
        spinnerLeft.dataSource = self
        spinnerLeft.delegate = self
        
        spinnerRight.dataSource = self
        spinnerRight.delegate = self
        
        pickerDataSource = XMLHelper.getTitleListFromXML(title: "characters")
        
        characterLeft = pickerDataSource[0]
        characterRight = pickerDataSource[0]
        
        charLeft.text = getLeftPercent(left: characterLeft, right: characterRight)
        charRight.text = getLeftPercent(left: characterRight, right: characterLeft)
        
        leftDetail.text = ""
        rightDetail.text = ""
        
        let img = getFileName(title: pickerDataSource[0])
        
        muImgLeft.image = scaleUIImageToSize(image: UIImage(named: img)!, size: muImgRight.frame.size)
        muImgRight.image = scaleUIImageToSize(image: UIImage(named: img)!, size: muImgRight.frame.size)
        
        vsText.theme_textColor = ["#000", "#FFF"]
        charLeft.theme_textColor = ["#000", "#FFF"]
        charRight.theme_textColor = ["#000", "#FFF"]
        leftDetail.theme_textColor = ["#000", "#FFF"]
        rightDetail.theme_textColor = ["#000", "#FFF"]
        
        //spinnerRight.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        //spinnerLeft.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if (pickerLabel == nil){
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = pickerDataSource[row]
        pickerLabel?.theme_textColor = ["#000", "#FFF"]
        
        return pickerLabel!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        muImgLeft.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: characterLeft))!, size: muImgLeft.frame.size)
        muImgRight.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: characterRight))!, size: muImgRight.frame.size)
        
        if(characterRight == characterLeft) {
            charLeft.text = getLeftPercent(left: characterLeft, right: characterRight)
            charRight.text = getLeftPercent(left: characterRight, right: characterLeft)
            leftDetail.text = ""
            rightDetail.text = ""
        } else {
            charLeft.text = getLeftPercent(left: characterLeft, right: characterRight) + "%"
            charRight.text = getLeftPercent(left: characterRight, right: characterLeft) + "%"
            leftDetail.text = getInfo(left: characterLeft, right: characterRight)
            rightDetail.text = getInfo(left: characterRight, right: characterLeft)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        characterRight = pickerDataSource[spinnerRight.selectedRow(inComponent: 0)]
        characterLeft = pickerDataSource[spinnerLeft.selectedRow(inComponent: 0)]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // selected value in Uipickerview in Swift
        let value = pickerDataSource[row]
        if pickerView.restorationIdentifier == "left" {
            characterLeft = value;
            muImgLeft.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: value))!, size: muImgLeft.frame.size)
        } else {
            characterRight = value;
            muImgRight.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: value))!, size: muImgRight.frame.size)
        }
        
        if(characterRight == characterLeft) {
            charLeft.text = getLeftPercent(left: characterLeft, right: characterRight)
            charRight.text = getLeftPercent(left: characterRight, right: characterLeft)
            leftDetail.text = ""
            rightDetail.text = ""
        } else {
            charLeft.text = getLeftPercent(left: characterLeft, right: characterRight) + "%"
            charRight.text = getLeftPercent(left: characterRight, right: characterLeft) + "%"
            leftDetail.text = getInfo(left: characterLeft, right: characterRight)
            rightDetail.text = getInfo(left: characterRight, right: characterLeft)
        }
    }
    
    func getPercent(left: String, right: String) -> String{
        return "\(abs(Int(getLeftPercent(left: left, right: right))! - 100))"
    }
    
    func getLeftPercent(left: String, right: String) -> String {
        switch left {
        case "Fox":
            switch right {
            case "Fox":
                return "Mirror"
            case "Falco":
                return "50"
            case "Sheik":
                return "60"
            case "Marth":
                return "50"
            case "Princess Peach":
                return "60"
            case "Captain Falcon":
                return "65"
            case "Ice Climbers":
                return "65"
            case "Samus":
                return "50"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "63"
            case "Mario":
                return "60"
            case "Ganondorf":
                return "60"
            case "Link":
                return "80"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "70"
            case "Young Link":
                return "70"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "60"
            case "Princess Zelda":
                return "80"
            case "Mr. Game & Watch":
                return "80"
            case "Ness":
                return "80"
            case "Bowser":
                return "80"
            case "Kirby":
                return "80"
            case "Pichu":
                return "80"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
            
        case "Marth":
            switch (right) {
            case "Fox":
                return getPercent(left: right, right: left)
            case "Falco":
                return getPercent(left: right, right: left)
            case "Sheik":
                return getPercent(left: right, right: left)
            case "Marth":
                return "Mirror"
            case "Princess Peach":
                return "60"
            case "Captain Falcon":
                return "50"
            case "Ice Climbers":
                return "60"
            case "Samus":
                return "60"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "50"
            case "Mario":
                return "70"
            case "Ganondorf":
                return "60"
            case "Link":
                return "55"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "60"
            case "Roy":
                return "70"
            case "Young Link":
                return "60"
            case "Pikachu":
                return "40"
            case "Yoshi":
                return "60"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "90"
            case "Ness":
                return "70"
            case "Bowser":
                return "80"
            case "Kirby":
                return "90"
            case "Pichu":
                return "90"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
            
        case "Sheik":
            switch right {
            case "Fox":
                return getPercent(left: right, right: left)
            case "Falco":
                return getPercent(left: right, right: left)
            case "Sheik":
                return "Mirror"
            case "Marth":
                return "50"
            case "Princess Peach":
                return "55"
            case "Captain Falcon":
                return "60"
            case "Ice Climbers":
                return "45"
            case "Samus":
                return "60"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "50"
            case "Mario":
                return "70"
            case "Ganondorf":
                return "70"
            case "Link":
                return "65"
            case "Luigi":
                return "65"
            case "Donkey Kong":
                return "80"
            case "Roy":
                return "90"
            case "Young Link":
                return "80"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "60"
            case "Princess Zelda":
                return "80"
            case "Mr. Game & Watch":
                return "90"
            case "Ness":
                return "80"
            case "Bowser":
                return "90"
            case "Kirby":
                return "75"
            case "Pichu":
                return "80"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Princess Peach":
            switch (right) {
            case "Fox","Falco","Sheik","Marth":
                return getPercent(left: right, right: left)
            case "Princess Peach":
                return "Mirror"
            case "Captain Falcon":
                return "45"
            case "Ice Climbers":
                return "70"
            case "Samus":
                return "60"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "40"
            case "Mario":
                return "70"
            case "Ganondorf":
                return "60"
            case "Link":
                return "40"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "60"
            case "Young Link":
                return "40"
            case "Pikachu":
                return "65"
            case "Yoshi":
                return "65"
            case "Princess Zelda":
                return "80"
            case "Mr. Game & Watch":
                return "70"
            case "Ness":
                return "70"
            case "Bowser":
                return "80"
            case "Kirby":
                return "80"
            case "Pichu":
                return "90"
            case "Mewtwo":
                return "70"
            default:
                return ""
            }
            
        case "Captain Falcon":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach":
                return getPercent(left: right, right: left)
            case "Captain Falcon":
                return "Mirror"
            case "Ice Climbers":
                return "60"
            case "Samus":
                return "60"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "50"
            case "Mario":
                return "70"
            case "Ganondorf":
                return "60"
            case "Link":
                return "80"
            case "Luigi":
                return "55"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "60"
            case "Young Link":
                return "70"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "60"
            case "Princess Zelda":
                return "80"
            case "Mr. Game & Watch":
                return "70"
            case "Ness":
                return "70"
            case "Bowser":
                return "80"
            case "Kirby":
                return "80"
            case "Pichu":
                return "90"
            case "Mewtwo":
                return "70"
            default:
                return ""
            }
            
        case "Ice Climbers":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon":
                return getPercent(left: right, right: left)
            case "Ice Climbers":
                return "Mirror"
            case "Samus":
                return "45"
            case "Dr. Mario":
                return "50"
            case "Jigglypuff":
                return "50"
            case "Mario":
                return "70"
            case "Ganondorf":
                return "50"
            case "Link":
                return "45"
            case "Luigi":
                return "50"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "90"
            case "Young Link":
                return "65"
            case "Pikachu":
                return "70"
            case "Yoshi":
                return "45"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "60"
            case "Ness":
                return "60"
            case "Bowser":
                return "90"
            case "Kirby":
                return "70"
            case "Pichu":
                return "90"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
            
        case "Samus":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers":
                return getPercent(left: right, right: left)
            case "Samus":
                return "Mirror"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "40"
            case "Mario":
                return "70"
            case "Ganondorf":
                return "40"
            case "Link":
                return "55"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "80"
            case "Young Link":
                return "70"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "70"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "70"
            case "Ness":
                return "60"
            case "Bowser":
                return "80"
            case "Kirby":
                return "80"
            case "Pichu":
                return "80"
            case "Mewtwo":
                return "70"
            default:
                return ""
            }
            
        case "Dr. Mario":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus":
                return getPercent(left: right, right: left)
            case "Dr. Mario":
                return "Mirror"
            case "Jigglypuff":
                return "50"
            case "Mario":
                return "60"
            case "Ganondorf":
                return "50"
            case "Link":
                return "55"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "60"
            case "Roy":
                return "60"
            case "Young Link":
                return "50"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "70"
            case "Princess Zelda":
                return "55"
            case "Mr. Game & Watch":
                return "70"
            case "Ness":
                return "60"
            case "Bowser":
                return "80"
            case "Kirby":
                return "70"
            case "Pichu":
                return "80"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Mario":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff":
                return getPercent(left: right, right: left)
            case "Mario":
                return "Mirror"
            case "Ganondorf":
                return "50"
            case "Link":
                return "55"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "60"
            case "Roy":
                return "60"
            case "Young Link":
                return "60"
            case "Pikachu":
                return "40"
            case "Yoshi":
                return "60"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "70"
            case "Ness":
                return "50"
            case "Bowser":
                return "80"
            case "Kirby":
                return "70"
            case "Pichu":
                return "90"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
            
        case "Ganondorf":
            switch right {
            case "Fox", "Falco", "Sheik", "Marth", "Princess Peach", "Captain Falcon", "Ice Climbers", "Samus", "Dr. Mario", "Jigglypuff", "Mario":
                return getPercent(left: right, right: left)
            case "Ganondorf":
                return "Mirror"
            case "Link":
                return "50"
            case "Luigi":
                return "50"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "60"
            case "Young Link":
                return "60"
            case "Pikachu":
                return "50"
            case "Yoshi":
                return "70"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "60"
            case "Ness":
                return "90"
            case "Bowser":
                return "90"
            case "Kirby":
                return "80"
            case "Pichu":
                return "60"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
            
            
        case "Jigglypuff":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario":
                return getPercent(left: right, right: left)
            case "Jigglypuff":
                return "Mirror"
            case "Mario":
                return "60"
            case "Ganondorf":
                return "45"
            case "Link":
                return "50"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "60"
            case "Young Link":
                return "60"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "70"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "60"
            case "Ness":
                return "90"
            case "Bowser":
                return "90"
            case "Kirby":
                return "80"
            case "Pichu":
                return "60"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
            
        case "Link":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf":
                return getPercent(left: right, right: left)
            case "Link":
                return "Mirror"
            case "Luigi":
                return "50"
            case "Donkey Kong":
                return "60"
            case "Roy":
                return "60"
            case "Young Link":
                return "55"
            case "Pikachu":
                return "40"
            case "Yoshi":
                return "70"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "75"
            case "Ness":
                return "60"
            case "Bowser":
                return "80"
            case "Kirby":
                return "60"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Luigi":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link":
                return getPercent(left: right, right: left)
            case "Luigi":
                return "Mirror"
            case "Donkey Kong":
                return "50"
            case "Roy":
                return "60"
            case "Young Link":
                return "45"
            case "Pikachu":
                return "50"
            case "Yoshi":
                return "50"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "60"
            case "Ness":
                return "50"
            case "Bowser":
                return "70"
            case "Kirby":
                return "60"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Donkey Kong":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi":
                return getPercent(left: right, right: left)
            case "Donkey Kong":
                return "Mirror"
            case "Roy":
                return "40"
            case "Young Link":
                return "40"
            case "Pikachu":
                return "30"
            case "Yoshi":
                return "50"
            case "Princess Zelda":
                return "50"
            case "Mr. Game & Watch":
                return "55"
            case "Ness":
                return "70"
            case "Bowser":
                return "70"
            case "Kirby":
                return "70"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Roy":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong":
                return getPercent(left: right, right: left)
            case "Roy":
                return "Mirror"
            case "Young Link":
                return "40"
            case "Pikachu":
                return "40"
            case "Yoshi":
                return "30"
            case "Princess Zelda":
                return "50"
            case "Mr. Game & Watch":
                return "50"
            case "Ness":
                return "30"
            case "Bowser":
                return "70"
            case "Kirby":
                return "70"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Young Link":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy":
                return getPercent(left: right, right: left)
            case "Young Link":
                return "Mirror"
            case "Pikachu":
                return "50"
            case "Yoshi":
                return "55"
            case "Princess Zelda":
                return "60"
            case "Mr. Game & Watch":
                return "60"
            case "Ness":
                return "60"
            case "Bowser":
                return "70"
            case "Kirby":
                return "60"
            case "Pichu":
                return "60"
            case "Mewtwo":
                return "40"
            default:
                return ""
            }
            
        case "Pikachu":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link":
                return getPercent(left: right, right: left)
            case "Pikachu":
                return "Mirror"
            case "Yoshi":
                return "40"
            case "Princess Zelda":
                return "65"
            case "Mr. Game & Watch":
                return "60"
            case "Ness":
                return "70"
            case "Bowser":
                return "70"
            case "Kirby":
                return "70"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Yoshi":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu":
                return getPercent(left: right, right: left)
            case "Yoshi":
                return "Mirror"
            case "Princess Zelda":
                return "50"
            case "Mr. Game & Watch":
                return "50"
            case "Ness":
                return "20"
            case "Bowser":
                return "70"
            case "Kirby":
                return "70"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
                
            }
        case "Princess Zelda":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi":
                return getPercent(left: right, right: left)
            case "Princess Zelda":
                return "Mirror"
            case "Mr. Game & Watch":
                return "50"
            case "Ness":
                return "30"
            case "Bowser":
                return "70"
            case "Kirby":
                return "70"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "60"
            default:
                return ""
            }
            
        case "Mr. Game & Watch":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi","Princess Zelda":
                return getPercent(left: right, right: left)
            case "Mr. Game & Watch":
                return "Mirror"
            case "Ness":
                return "20"
            case "Bowser":
                return "80"
            case "Kirby":
                return "70"
            case "Pichu":
                return "60"
            case "Mewtwo":
                return "30"
            default:
                return ""
            }
            
        case "Ness":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi","Princess Zelda","Mr. Game & Watch":
                return getPercent(left: right, right: left)
            case "Ness":
                return "Mirror"
            case "Bowser":
                return "60"
            case "Kirby":
                return "60"
            case "Pichu":
                return "80"
            case "Mewtwo":
                return "40"
            default:
                return ""
            }
            
        case "Kirby":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi","Princess Zelda","Mr. Game & Watch","Ness","Bowser":
                return getPercent(left: right, right: left)
            case "Kirby":
                return "Mirror"
            case "Pichu":
                return "40"
            case "Mewtwo":
                return "30"
            default:
                return ""
            }
            
        case "Bowser":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi","Princess Zelda","Mr. Game & Watch","Ness":
                return getPercent(left: right, right: left)
            case "Bowser":
                return "Mirror"
            case "Kirby":
                return "70"
            case "Pichu":
                return "60"
            case "Mewtwo":
                return "20"
            default:
                return ""
            }
            
        case "Mewtwo":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi","Princess Zelda","Mr. Game & Watch","Ness","Bowser","Kirby","Pichu":
                return getPercent(left: right, right: left)
            case "Mewtwo":
                return "Mirror"
            default:
                return ""
            }
            
        case "Pichu":
            switch (right) {
            case "Fox","Falco","Sheik","Marth","Princess Peach","Captain Falcon","Ice Climbers","Samus","Dr. Mario","Jigglypuff","Mario","Ganondorf","Link","Luigi","Donkey Kong","Roy","Young Link","Pikachu","Yoshi","Princess Zelda","Mr. Game & Watch","Ness","Bowser","Kirby":
                return getPercent(left: right, right: left)
            case "Pichu":
                return "Mirror"
            case "Mewtwo":
                return "30"
            default:
                return ""
            }
            
        case "Falco":
            switch right {
            case "Fox":
                return getPercent(left: right, right: left)
            case "Falco":
                return "Mirror"
            case "Sheik":
                return "55"
            case "Marth":
                return "50"
            case "Princess Peach":
                return "50"
            case "Captain Falcon":
                return "60"
            case "Ice Climbers":
                return "50"
            case "Samus":
                return "55"
            case "Dr. Mario":
                return "60"
            case "Jigglypuff":
                return "50"
            case "Mario":
                return "60"
            case "Ganondorf":
                return "70"
            case "Link":
                return "60"
            case "Luigi":
                return "60"
            case "Donkey Kong":
                return "70"
            case "Roy":
                return "70"
            case "Young Link":
                return "70"
            case "Pikachu":
                return "60"
            case "Yoshi":
                return "60"
            case "Princess Zelda":
                return "90"
            case "Mr. Game & Watch":
                return "90"
            case "Ness":
                return "90"
            case "Bowser":
                return "90"
            case "Kirby":
                return "70"
            case "Pichu":
                return "70"
            case "Mewtwo":
                return "80"
            default:
                return ""
            }
        default:
            return ""
        }
    }
    
    func getInfo(left: String, right: String) -> String{
        switch (left) {
        case "Fox":
            switch (right) {
            case "Falco":
                return "Better recovery and amazing neutral"
            case "Sheik":
                return "Strong attacks, punish game"
            case "Marth":
                return "Combo ability, strong attacks and approach"
            case "Princess Peach":
                return "Strong attacks"
            case "Captain Falcon":
                return "Combo and gimping ability"
            case "Ice Climbers":
                return "Combo and gimping ability"
            case "Samus":
                return "Strong attacks"
            case "Jigglypuff":
                return "Rest combos"
            default:
                return ""
            }
            
        case "Falco":
            switch (right) {
            case "Fox":
                return "Stopping power, but poor recovery"
            case "Sheik":
                return "Long tech roll and punish game"
            case "Marth":
                return "Stopping power, but poor recovery"
            case "Princess Peach":
                return "Combo ability, but poor recovery"
            case "Captain Falcon":
                return "Stopping power, dair priority"
            case "Ice Climbers":
                return "Easily chaingrabbed"
            case "Samus":
                return "Stopping power"
            case "Jigglypuff":
                return "Strong attacks, but easily rested"
            default:
                return ""
            }
            
        case "Sheik":
            switch (right) {
            case "Fox":
                return "Tech chase and gimping ability"
            case "Falco":
                return "Gimp ability"
            case "Sheik":
                return "Good punish, needles"
            case "Marth":
                return "Lightweight"
            case "Princess Peach":
                return "Stopping power"
            case "Captain Falcon":
                return "Gimping ability"
            case "Ice Climbers":
                return "Can separate with B-Air but hard to camp"
            case "Samus":
                return "Floaty"
            case "Jigglypuff":
                return "Lightweight"
            default:
                return ""
            }
            
        case "Marth":
            switch (right) {
            case "Fox":
                return "Can gimp, disjointed hitboxes"
            case "Falco":
                return "Can gimp, disjointed hitboxes"
            case "Sheik":
                return "Strong attacks"
            case "Princess Peach":
                return "Priority"
            case "Captain Falcon":
                return "Priority"
            case "Ice Climbers":
                return "Strong attacks"
            case "Samus":
                return "Priority, edge guard"
            case "Jigglypuff":
                return "Can space well"
            default:
                return ""
            }
            
        case "Princess Peach":
            switch (right) {
            case "Fox":
                return "Zoning power"
            case "Falco":
                return "Easily gimps, down smash"
            case "Sheik":
                return "Easily comboed"
            case "Marth":
                return "Outranged"
            case "Captain Falcon":
                return "Lightweight"
            case "Ice Climbers":
                return "Can edgeguard"
            case "Samus":
                return "Can gimp"
            case "Jigglypuff":
                return "Lightweight"
            default:
                return ""
            }
            
        case "Captain Falcon":
            switch (right) {
            case "Fox":
                return "Predictable recovery"
            case "Falco":
                return "Predictable recovery"
            case "Sheik":
                return "Predictable recovery"
            case "Marth":
                return "Strong punish"
            case "Princess Peach":
                return "Trouble edgeguarding"
            case "Ice Climbers":
                return "Trouble separating"
            case "Samus":
                return "Strong attacks"
            case "Jigglypuff":
                return "Strong punish"
            default:
                return ""
            }
            
        case "Ice Climbers":
            switch (right) {
            case "Fox":
                return "Can chain grab"
            case "Falco":
                return "Can gimp"
            case "Sheik":
                return "Easily wobbles"
            case "Marth":
                return "Easily separates"
            case "Princess Peach":
                return "Easily separates"
            case "Captain Falcon":
                return "Can wobble easily"
            case "Samus":
                return "Easily separated"
            case "Jigglypuff":
                return "Punishes hard"
            default:
                return ""
            }
            
        case "Samus":
            switch (right) {
            case "Fox":
                return "Spam power"
            case "Falco":
                return "Spam power"
            case "Sheik":
                return "Easily comboed"
            case "Marth":
                return "Easily comboed"
            case "Princess Peach":
                return "Several recovery options"
            case "Captain Falcon":
                return "Floaty"
            case "Ice Climbers":
                return "Spam power"
            case "Jigglypuff":
                return "Floaty"
            default:
                return ""
            }
            
        case "Jigglypuff":
            switch (right) {
            case "Fox":
                return "Lightweight, can be punished by Up-Throw -> Up-Air"
            case "Falco":
                return "Floaty"
            case "Sheik":
                return "Floaty"
            case "Marth":
                return "Floaty"
            case "Princess Peach":
                return "Edgeguards"
            case "Captain Falcon":
                return "Floaty"
            case "Ice Climbers":
                return "Easy to edgeguard"
            case "Samus":
                return "Easy to avoid spam"
            default:
                return ""
            }
            
        default:
            return ""
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*class RightSpinner: UIPickerViewDelegate {
     
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return pickerDataSource.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return pickerDataSource[row]
     }
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     // selected value in Uipickerview in Swift
     let value = pickerDataSource[row]
     muImgLeft.image = scaleUIImageToSize(image: UIImage(named: getFileName(title: value))!, size: muImgLeft.frame.size)
     
     }*/
    
}
