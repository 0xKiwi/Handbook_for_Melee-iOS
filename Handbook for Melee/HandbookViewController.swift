
import UIKit
import Appodeal

class HandbookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.theme_backgroundColor = ["#fafafa", "#212121"]
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 48.0/255.0, green: 63.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UINavigationBar.appearance().barTintColor = UIColor(red: 48.0/255.0, green: 63.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    
    func adsAreRemoved() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "adsRemoved")
    }
    
    func decorateTableView(tableView: UITableView) {
        tableView.theme_backgroundColor = ["#fafafa", "#212121"]
        tableView.theme_separatorColor = ["#c8c7cc", "#4d4d4d"]
    }
    
    func decorateCell(cell: UITableViewCell){
        cell.theme_backgroundColor = ["#fafafa", "#212121"]
        cell.textLabel?.theme_textColor = ["#000", "#FFF"]
        
        let bg = UIView()
        bg.theme_backgroundColor = ["#eee", "#303030"]
        cell.selectedBackgroundView = bg
    }
}
