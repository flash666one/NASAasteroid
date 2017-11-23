//
//  NASAViewController.swift
//  NASAproject
//
//  Created by Артём Горюнов on 05.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit
import Alamofire

class NASAViewController: UIViewController {
    
    static var main: NASAViewController?
    
    var maxDistance = 0
    var selectedDate: DateSingleton?
    
    @IBAction func asteroidInfo(sender: AsteroidView) {
        let alertView = UIAlertController(title: "\(sender.asteroid?.name ?? 0)", message: "Estimated diameter:\(sender.asteroid?.sizeAsDouble ?? 0) kilometers, Distance to Earth: \(sender.asteroid?.distance ?? 0) kilometers ", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertView.addAction(action)
        present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func earthInfo(){
        let alertView = UIAlertController(title: "Earth", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertView.addAction(action)
        present(alertView, animated: true, completion: nil)
    }
    
    
    @IBAction func up(_ sender: UISwipeGestureRecognizer) {
        datePickerManager.main.show()
    }
    
    @IBAction func down(_ sender: UISwipeGestureRecognizer) {
        datePickerManager.main.hide()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NASAViewController.main = self
        let earthButton = UIButton(type: UIButtonType.custom) as UIButton
        earthButton.frame = CGRect(x: 0, y: view.center.y - 25, width: 50, height: 50)
        earthButton.setImage(#imageLiteral(resourceName: "earth"), for: UIControlState.normal)
        earthButton.addTarget(self, action: #selector(earthInfo), for: UIControlEvents.touchUpInside)
        self.view.addSubview(earthButton)
        updateAsteroids()
    }
    
    func updateAsteroids() {
        clearAsteroids()
        RequestManager.main.getAsteroids { (asteroids) in
            for asteroid in asteroids {
                if asteroid.distance > self.maxDistance {
                    self.maxDistance = asteroid.distance
                }
            }
            for asteroid in asteroids {
                self.adding(new: asteroid)
            }
        }
    }
    
    func clearAsteroids() {
        for sub in view.subviews {
            if sub is AsteroidView {
                sub.removeFromSuperview()
            }
        }
    }
    
    let frames = [
        AsteroidSize.small: 30,
        AsteroidSize.avarage: 40,
        AsteroidSize.big: 50
    ]
    
    func adding(new asteroid: Asteroid) {
        let x = frames[asteroid.size] ?? 50
        let button = AsteroidView()
        button.asteroid = asteroid
        button.frame = CGRect(
            x: Int(view.frame.width * CGFloat(asteroid.distance) / CGFloat(maxDistance)) - x/2,
            y: Int(view.frame.height/2) - x/3,
            width: x/2,
            height: x/2)
        button.setImage(#imageLiteral(resourceName: "asteroid1"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(asteroidInfo), for: UIControlEvents.touchUpInside)
        view.addSubview(button)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
