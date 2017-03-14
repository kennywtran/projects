//
//  ViewController.swift
//  tippy
//
//  Created by Kenny Tran on 3/12/17.
//  Copyright © 2017 Kenny Tran. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet var tipView: UIView!
    @IBOutlet var userInputView: UIView!
    
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var regular : Double = 0.0;
    var medium : Double = 0.0;
    var high : Double = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Making sure the keyboard is always visible for the bill input
        self.inputField.becomeFirstResponder();
        
        // Display the tip values
        let defaults = UserDefaults.standard
        
        regular = defaults.double(forKey: "regular")
        medium = defaults.double(forKey: "medium")
        high = defaults.double(forKey: "high")
        
        let regularTip = String(format: "%.0f", regular)
        let mediumTip = String(format: "%.0f", medium)
        let highTip = String(format: "%.0f", high)
    
        tipControl.setTitle(regularTip + "%", forSegmentAt: 0)
        tipControl.setTitle(mediumTip + "%", forSegmentAt: 1)
        tipControl.setTitle(highTip + "%", forSegmentAt: 2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // Re-display the user input view
        self.userInputView.alpha = 1
        self.tipView.alpha = 1
        UIView.animate(withDuration: 0.5, animations: {
            // This causes first view to fade in and second view to fade out
            self.userInputView.alpha = 1
            self.tipView.alpha = 1
        })    }

    // Calculate the tips
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        // Fade in to tip calculator view
        if self.userInputView.alpha == 1 {
            self.userInputView.alpha = 1
            self.tipView.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                // This causes first view to fade in and second view to fade out
                self.userInputView.alpha = 0
                self.tipView.alpha = 1
            })
        }

        let tipPercentages = [regular/100, medium/100, high/100]
    
        // Get user input
        let bill = Double(inputField.text!) ?? 0
        displayCalculations(bill: bill, tipPercentages: tipPercentages)
      }
    
    // Create a new bill
    @IBAction func createNewBill(_ sender: AnyObject) {
        // Fade out to user input view
        if self.userInputView.alpha == 0 {
            self.userInputView.alpha = 0
            self.tipView.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                // This causes first view to fade in and second view to fade out
                self.userInputView.alpha = 1
                self.tipView.alpha = 1
            })
        }
    }
    
    // Display the calculations with locale specific
    func displayCalculations( bill : Double, tipPercentages:Array<Double>) {
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Convert total and tip ammount to locale specific
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let languageCode = Locale.current.languageCode! as String
        let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as! String
        formatter.locale = Locale(identifier: languageCode + "_" + countryCode)
        
        billLabel.text = formatter.string(from: NSNumber(value: bill))
        tipLabel.text = formatter.string(from: NSNumber(value:tip))
        totalLabel.text = formatter.string(from: NSNumber(value:total))
    }
}
