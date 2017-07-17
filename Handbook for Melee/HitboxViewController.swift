//
//  HitboxViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 3/15/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit

class HitboxViewController: HandbookViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var moveShort : String = ""
    var moveName : String = ""
    
    var character : String = ""
    var characterFull : String = ""
    
    var moveType : String = ""
    
    var titles : [String] = ["Tilts", "Smash Attacks", "Aerial Attacks","Normal Attacks", "Special Attacks"]
    var paths : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterFull = character
        character = getFileName(title: character)
        
        tableView.delegate = self
        tableView.dataSource = self
        decorateTableView(tableView: tableView)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.theme_textColor = ["#000", "#FFF"]
        header.contentView.theme_backgroundColor = ["#c8c7cc", "#4d4d4d"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }

    
    //Number of rows, returns int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getListFromFolder(path: "hitboxes/" + character + "/" + getFileName(title: titles[section])).count
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
    
    //Contents of cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let move = getFileName(title: titles[indexPath.section])
        var names = getListFromFolder(path: "hitboxes/" + character + "/" + move)
        
        var moves : [String] = []
        for index in 0..<names.count {
            moves.append(HitboxHelper.getMoveTitle(name: names[index]))
        }
        moves.sort(by: sorterForFileIDASC)
        
        decorateCell(cell: cell)
        
        cell.textLabel?.text = moves[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let move = getFileName(title: titles[indexPath.section])
        var names = getListFromFolder(path: "hitboxes/" + character + "/" + move)
        var moves : [String] = []
        for index in 0..<names.count {
            moves.append(HitboxHelper.getMoveTitle(name: names[index]))
        }
        moves.sort(by: sorterForFileIDASC)

        moveName = moves[indexPath.row]
        moveType = titles[indexPath.section]
        
        print(moveName)
        
        performSegue(withIdentifier: "hitboxdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue called")
        if segue.identifier == "hitboxdetail" {
            let controller = segue.destination as! HitboxDetailViewController
            controller.navigationItem.title = characterFull + "'s " + moveName.lowercased()
            controller.character = characterFull
            controller.moveName = moveName
            controller.moveType = moveType
            controller.moveShort = HitboxHelper.getShortTitle(name: moveName)
        }
    }
    
    func sorterForFileIDASC(this:String, that:String) -> Bool {
        return this.characters.count < that.characters.count
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
