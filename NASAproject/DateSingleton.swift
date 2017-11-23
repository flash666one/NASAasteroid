//
//  DateSingleton.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
class DateSingleton {
    static let current = DateSingleton()
    var date: Date?
}
