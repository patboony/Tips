//
//  ViewController.swift
//  tips
//
//  Created by Pat Boonyarittipong on 3/21/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var darkRec: UIView!
    @IBOutlet weak var greenRec: UIView!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billFieldBackgroundLabel: UILabel!
    @IBOutlet weak var totalForTwo: UILabel!
    @IBOutlet weak var totalForThree: UILabel!
    @IBOutlet weak var totalForFour: UILabel!
    
    let currencySymbols = ["$", "€", "¥", "£"]
    var currencyInUse = 0
    var darkBackgroundBool = false
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.becomeFirstResponder()
        animateClean(0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        if billField.text.isEmpty {
            animateClean(0.5)
        } else {
            updateAllFields()
            animateShowAmount(0.5)
        }
    }
    
    // Helper function to update all fields
    func updateAllFields() {
        let tipPercentages = [0.18, 0.2, 0.22]
        var tipPctSelected = tipPercentages[tipControl.selectedSegmentIndex]
        
        // Cast as NSString and use doubleValue instead
        var billAmount = (billField.text as NSString).doubleValue
        var tipAmount = billAmount * tipPctSelected
        var totalAmount = billAmount + tipAmount
        
        // Update the labels
        tipLabel.text = currencySymbols[currencyInUse] + String(format: "%.2f", tipAmount)
        totalLabel.text = currencySymbols[currencyInUse] + String(format: "%.2f", totalAmount)
        totalForTwo.text = currencySymbols[currencyInUse] + String(format: "%.2f", totalAmount/2)
        totalForThree.text = currencySymbols[currencyInUse] + String(format: "%.2f", totalAmount/3)
        totalForFour.text = currencySymbols[currencyInUse] + String(format: "%.2f", totalAmount/4)
    }
    
    // Clean the screen when no bill amount is entered
    func animateClean(timeToAnimate: NSTimeInterval) {
        UIView.animateWithDuration(timeToAnimate, animations: {
            // This causes the dark rec to recede
            self.darkRec.frame.origin.y = 1000
            self.greenRec.frame.size.height = 1000
            self.greenRec.alpha = 0.7
            self.billField.frame.origin.y = 200
            self.billFieldBackgroundLabel.frame.origin.y = 200
            // Fade in the "enter bill amount" label
            self.billFieldBackgroundLabel.alpha = 0.4
        })
    }
    
    func animateShowAmount(timeToAnimate: NSTimeInterval) {
        // Suddenly hide the "enter bill amount" label
        billFieldBackgroundLabel.alpha = 0
        UIView.animateWithDuration(timeToAnimate, animations: {
            // This causes the dark green rec to expand
            self.darkRec.frame.origin.y = 150
            self.greenRec.frame.size.height = 150
            self.greenRec.alpha = 0.4
            self.billField.frame.origin.y = 79
            self.billFieldBackgroundLabel.frame.origin.y = 79
        })
    }

    func refreshTheme(){
        
        if darkBackgroundBool {
            darkRec.backgroundColor = UIColor(red: 87/255, green: 38/255, blue: 127/255, alpha: 1.0)
        }
        else {
             darkRec.backgroundColor = UIColor(red: 173/255, green: 121/255, blue: 165/255, alpha: 1.0)
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        // Dismiss the keyboard
        view.endEditing(true)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Update default value
        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPct")
        currencyInUse = defaults.integerForKey("defaultCurrency")
        darkBackgroundBool = defaults.boolForKey("darkBackground")
        
        updateAllFields()
        refreshTheme()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshTheme()


    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    
    
}

