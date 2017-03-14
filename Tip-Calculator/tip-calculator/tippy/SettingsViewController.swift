//
//  SettingsViewController.swift
//  tippy
//
//  Created by Kenny Tran on 3/13/17.
//  Copyright © 2017 Kenny Tran. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var regularField: UITextField!
    @IBOutlet weak var mediumField: UITextField!
    @IBOutlet weak var highField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    // Get and save the tips settings
    @IBAction func onClickSave(_ sender: Any) {
        
        // Get the tips settings
        let regular = Double(regularField.text!) ?? 0
        let medium = Double(mediumField.text!) ?? 0
        let high = Double(highField.text!) ?? 0
        
        // Save the tips settings
        let defaults = UserDefaults.standard
        
        defaults.set(regular, forKey: "regular")
        defaults.set(medium, forKey: "medium")
        defaults.set(high, forKey: "high")
        defaults.synchronize()
        
        // Confirm message to user
        confirm (title: "Success", message: "Tip percentages updated successfully")
        
    }
    
    /// Display the confirmation message
    func confirm (title: String, message: String) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
    }
}
