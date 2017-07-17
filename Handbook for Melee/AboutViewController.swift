//
//  AboutViewController.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 4/6/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class AboutViewController: HandbookViewController {
    
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var removeAds: UIButton!
    
    @IBOutlet weak var restore: UIButton!
    
    var transactionInProgress = false
    
    var productIDs: [String?] = []
    var productsArray: [SKProduct?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if adsAreRemoved() {
            removeAds.setTitle("Thank you!", for: .normal)
            removeAds.setTitle("Thank you!", for: .disabled)
        }
        
        self.title = "About"
        
        let text = "<b>Based on information from:</b><br>www.ssbwiki.com/<br>www.smashboards.com/<br>Super Smash Bros. Melee<br>www.supersmashbros.wikia.com/<br>www.reddit.com/r/smashbros/wiki/bkam/<br><br><b>All thanks to:</b><br>Zhu<br>Vesne<br>ssbwiki<br>Wobbles<br>Nintendo<br>Mew2King<br>SSBMKira<br>/u/djloreddit<br>schmooblidon<br>/u/DigitalAge98<br>supersmashwikia<br>HAL Laboratory<br>My friends and testers<br>Stratocaster\'s Hitbox System<br>Tristan, Ernesto, Tyler, Luis and Juan<br><br><b>Libraries used:</b><br>AEXML<br>Player<br>XLPagerTabStrip"
        
        textView.setHTMLFromString(htmlText: text)
        textView.theme_textColor = ["#000", "#FFF"]
        textView.theme_backgroundColor = ["#fafafa", "#212121"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRestore(_ sender: Any) {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
            }
            else if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoreFailedPurchases)")
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "adsRemoved")
                let alertController = UIAlertController(title: "Thank you!!", message: "Thank you so much for supporting Handbook for Melee!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textView.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    @IBAction func click(_ sender: Any) {
        let url = (NSURL(string:"http://www.twitter.com/ThatKawaiiGuy") as URL?)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func clickRemove(_ sender: Any) {
        if !adsAreRemoved() {
        SwiftyStoreKit.purchaseProduct("remove_ads", atomically: true) { result in
            switch result {
            case .success(let product):
                print("Purchase Success: \(product.productId)")
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "adsRemoved")
                SwiftyStoreKit.finishTransaction(product.transaction)
                let alertController = UIAlertController(title: "Thank you!!", message: "Thank you so much for supporting Handbook for Melee!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                default:
                    print("uhh")
                }
            }
        }
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
