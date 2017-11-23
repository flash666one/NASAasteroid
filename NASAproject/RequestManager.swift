//
//  RequestManager.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import Alamofire



class RequestManager {
    static let main = RequestManager()
    
    func getAsteroids (completion: @escaping ([Asteroid]) -> ()) {
        
        let dateString = getDateString()
        let link = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(dateString)&end_date=\(dateString)&api_key=mnRXibKwjv8IKogwxu4ITik4lKy8B2ADyUBZpc13"
        Alamofire.request(link).responseJSON { (response) in
            if let dict = response.value as? [String: Any] {
                if let dates = dict["near_earth_objects"] as? [String: Any] {
                    if let asteroids = dates[dateString] as? [Any] {
                        completion(self.parseAsteroids(unparsed: asteroids))
                    }
                }
            }
        }
    }
    
    func parseAsteroids(unparsed asteroids: [Any]) -> [Asteroid] {
        var newAsteroids: [Asteroid] = []
        for asteroid in asteroids {
            print("-----")
            var newAsteroid = Asteroid(name: "", size: .avarage, sizeAsDouble: 0, distance: 0)
            if let dict = asteroid as? [String: Any] {
                if let asteroidName = dict["name"] as? String {
                    newAsteroid.name = asteroidName
                }
                if let dm = (dict["estimated_diameter"] as? [String: Any])?["kilometers"] as? [String: Double] {
                    if let max = dm["estimated_diameter_max"],
                        let min = dm["estimated_diameter_min"] {
                        let size = max + min / 2
                        newAsteroid.sizeAsDouble = size
                        if size < 0.5 {
                            newAsteroid.size = .small
                        } else if size < 1 {
                            newAsteroid.size = .avarage
                        } else {
                            newAsteroid.size = .big
                        }
                    }
                }
                if let km = ((dict["close_approach_data"] as? [Any])?.first as? [String: Any])?["miss_distance"] as? [String: String] {
                    newAsteroid.distance = Int(km["kilometers"] ?? "") ?? 0
                }
                
            }
            if newAsteroid.distance != 0 {
                newAsteroids.append(newAsteroid)
                
            }
        }
        return newAsteroids
        
    }
    
    private func getDateString() -> String {
        let date = DateSingleton.current.date ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let string = dateFormatter.string(from: date)
        return string
    }
    
}
