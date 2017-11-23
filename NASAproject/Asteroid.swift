//
//  Asteroid.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
struct Asteroid {
    var name: Any
    var size: AsteroidSize
    var sizeAsDouble: Double
    var distance: Int
}

enum AsteroidSize {
    case small
    case avarage
    case big
}
