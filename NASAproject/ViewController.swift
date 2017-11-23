//
//  ViewController.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var NASAView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerManager.main.NASAViewController = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

