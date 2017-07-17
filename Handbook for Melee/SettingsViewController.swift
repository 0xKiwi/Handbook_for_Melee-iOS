import UIKit
import SwiftTheme

class SettingsViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    static let THEME_PREF : String = "theme_pref"
    static let TIER_PREF : String = "tier_pref"
    static let STRETCH_PREF : String = "stretch_pref"
    static let GROUP_PREF : String = "group_pref"
    static let MAIN_PREF : String = "main_pref"
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var nightText: UILabel!
    @IBOutlet weak var tierText: UILabel!
    @IBOutlet weak var stetchText: UILabel!
    @IBOutlet weak var groupText: UILabel!
    @IBOutlet weak var mainText: UILabel!
    
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var tierSwitch: UISwitch!
    @IBOutlet weak var toastSwitch: UISwitch!
    @IBOutlet weak var groupSwitch: UISwitch!
    
    @IBOutlet weak var mainView: UIPickerView!
    
    var mainList = XMLHelper.getTitleListFromXML(title: "characters")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeSwitch.isOn = defaults.bool(forKey: SettingsViewController.THEME_PREF)
        tierSwitch.isOn = defaults.bool(forKey: SettingsViewController.TIER_PREF)
        toastSwitch.isOn = defaults.bool(forKey: SettingsViewController.STRETCH_PREF)
        groupSwitch.isOn = defaults.bool(forKey: SettingsViewController.GROUP_PREF)
        
        mainList.insert("None", at: 0)
    
        mainView.delegate = self
        mainView.dataSource = self
        
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        
        themeSwitch.theme_onTintColor = ["#303f9f", "#FDD835"]
        tierSwitch.theme_onTintColor = ["#303f9f", "#FDD835"]
        toastSwitch.theme_onTintColor = ["#303f9f", "#FDD835"]
        groupSwitch.theme_onTintColor = ["#303f9f", "#FDD835"]
        
        tableView.theme_backgroundColor = ["#fafafa", "#212121"]
        tableView.theme_separatorColor = ["#c8c7cc", "#4d4d4d"]
        
        nightText.theme_textColor = ["#000", "#FFF"]
        tierText.theme_textColor = ["#000", "#FFF"]
        stetchText.theme_textColor = ["#000", "#FFF"]
        mainText.theme_textColor = ["#000", "#FFF"]
        groupText.theme_textColor = ["#000", "#FFF"]
        
        for cell in tableView.visibleCells {
            decorateCell(cell: cell)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    //    characterRight = pickerDataSource[spinnerRight.selectedRow(inComponent: 0)]
    //    characterLeft = pickerDataSource[spinnerLeft.selectedRow(inComponent: 0)]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // selected value in Uipickerview in Swift
        let value = mainList[row]
        defaults.set(value, forKey: SettingsViewController.MAIN_PREF)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel = view as? UILabel
        
        if (pickerLabel == nil){
            pickerLabel = UILabel()
            
            pickerLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        pickerLabel?.text = mainList[row]
        pickerLabel?.theme_textColor = ["#000", "#FFF"]
        
        return pickerLabel!
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.theme_textColor = ["#000", "#FFF"]
        header.contentView.theme_backgroundColor = ["#c8c7cc", "#4d4d4d"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UINavigationBar.appearance().barTintColor = UIColor(red: 48.0/255.0, green: 63.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        let main = defaults.string(forKey: SettingsViewController.MAIN_PREF)
        if main != nil {
            print(main!)
            let row = mainList.index(of: main!)!
            mainView.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    @IBAction func themeToggle(_ sender: Any) {
        if (themeSwitch.isOn) {
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: SettingsViewController.THEME_PREF)
            ThemeManager.setTheme(index: 1)
        } else {
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: SettingsViewController.THEME_PREF)
            ThemeManager.setTheme(index: 0)
        }
    }
    
    @IBAction func tierClick(_ sender: Any) {
        setSetting(name: SettingsViewController.TIER_PREF, enabled: tierSwitch.isOn)
    }
    
    @IBAction func stretchClick(_ sender: Any) {
        setSetting(name: SettingsViewController.STRETCH_PREF, enabled: toastSwitch.isOn)
    }
    
    @IBAction func groupToggle(_ sender: Any) {
        setSetting(name: SettingsViewController.GROUP_PREF, enabled: groupSwitch.isOn)
    }
    
    func decorateCell(cell: UITableViewCell){
        cell.theme_backgroundColor = ["#fafafa", "#212121"]
        cell.textLabel?.theme_textColor = ["#000", "#FFF"]
        
        let bg = UIView()
        bg.theme_backgroundColor = ["#eee", "#303030"]
        cell.selectedBackgroundView = bg
    }
    
    func setSetting(name: String, enabled: Any) {
        defaults.set(enabled, forKey: name)
    }
}
