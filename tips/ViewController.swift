//
//  ViewController.swift
//  tips
//
//  Created by Pat Boonyarittipong on 3/21/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentages = [0.18, 0.2, 0.22]
        var tipPctSelected = tipPercentages[tipControl.selectedSegmentIndex]
        
        // Bridge to ObjectiveC no longer works
        // Cast as NSString and use doubleValue instead
        var billAmount = (billField.text as NSString).doubleValue
        var tipAmount = billAmount * tipPctSelected
        var totalAmount = billAmount + tipAmount
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
        
    }

    @IBAction func onTap(sender: AnyObject) {
        // Dismiss the keyboard
        view.endEditing(true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Update default value
        var defaults = NSUserDefaults.standardUserDefaults()

        tipControl.selectedSegmentIndex = defaults.integerForKey("defaultTipPct")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

    }
    
    
    
}

