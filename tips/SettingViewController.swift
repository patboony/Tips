//
//  SettingViewController.swift
//  tips
//
//  Created by Pat Boonyarittipong on 3/21/15.
//  Copyright (c) 2015 patboony. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var defaultCurrencyControl: UISegmentedControl!
    @IBOutlet weak var darkBackgroundSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load default settings (I hope the scope is okay)
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTipPctIndex = defaults.integerForKey("defaultTipPct")
        var defaultCurrencyIndex = defaults.integerForKey("defaultCurrency")
        var defaultDarkBackgroundBool = defaults.boolForKey("darkBackground")

        defaultTipControl.selectedSegmentIndex = defaultTipPctIndex
        defaultCurrencyControl.selectedSegmentIndex = defaultCurrencyIndex
        darkBackgroundSwitch.setOn(defaultDarkBackgroundBool,  animated:false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onValueChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: "defaultTipPct")
        defaults.setInteger(defaultCurrencyControl.selectedSegmentIndex, forKey: "defaultCurrency")
        defaults.setBool(darkBackgroundSwitch.on, forKey: "darkBackground")
        defaults.synchronize()
    }
    
    @IBAction func saveSettings(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
