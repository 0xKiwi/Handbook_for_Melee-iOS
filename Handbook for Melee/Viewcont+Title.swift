//
//  Viewcontroller+Extension.swift
//  Handbook for Melee
//
//  Created by Ivan Martinez on 1/1/17.
//  Copyright © 2017 Ivan Martinez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    var visibleVC: UIViewController {
        if self is UINavigationController{
            if let cvc = (self as! UINavigationController).visibleViewController { return cvc }
        }
        return self
    }
    
    func changeTitle(title : String?) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func getFileName(title: String) -> String {
        return title.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "&", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "")
    }
    
    func scaleUIImageToSize(image: UIImage,size: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    func showToast(message : String) {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: SettingsViewController.STRETCH_PREF) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-100, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "HelveticaNeue", size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption2).pointSize)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        }
    }
}
