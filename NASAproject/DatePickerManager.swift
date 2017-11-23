//
//  DatePickerManager.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import UIKit

class datePickerManager {
    var menuIsShown = true
    var NASAViewController: ViewController?
    
    func show () {
        UIView.animate(withDuration: 0.3) {
            self.NASAViewController?.NASAView.frame.origin.y = 200
        }
        menuIsShown = true
        NASAViewController?.viewDidLoad()
    }
    
    func hide () {
        UIView.animate(withDuration: 0.3){
            self.NASAViewController?.NASAView.frame.origin.y = 0
        }
        menuIsShown = false
        NASAViewController?.viewDidLoad()
    }
    
    private init () {}
    static let main = datePickerManager()

}
