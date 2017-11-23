//
//  DateViewController.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func tryDatePicker(_ sender: Any) {
        DateSingleton.current.date = self.datePicker.date
        NASAViewController.main?.updateAsteroids()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .date
    }

}
