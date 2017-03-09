//
//  ViewController.swift
//  CatTracker
//
//  Created by LING Leong on 9/3/2017.
//  Copyright © 2017 LING Leong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UILabel!
    @IBOutlet weak var catNameLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        catNameLabel.text = "CSCI4120"
    }
    

}

