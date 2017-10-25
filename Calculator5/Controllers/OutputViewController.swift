//
//  OutputViewController.swift
//  Calculator5
//
//  Created by Victoriia Rohozhyna on 10/10/17.
//  Copyright © 2017 Victoriia Rohozhyna. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController, OutputInterface {
    
    func cleanLabel() {
        label.text = "0"
    }
    func clearLast() {
        if label.text != nil || label.text != "0" {
            label.text?.removeLast()
        } else {
            label.text = "0"
        }
    }
    func display(_ result: String) {
        if label.text == "0" {
            label.text = result
        } else {
            label.text = label.text! + "\(result)"
        }
    }
    func currentOutput() -> String? {
        return label.text
    }
    
    
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byTruncatingHead
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



