//
//  ViewController.swift
//  Magnitude
//
//  Created by Trip Phillips on 5/24/16.
//  Copyright © 2016 JFP Apps. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var magnitudeLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    var currentMag : Double = 0.0
    var maxMag : Double = 0.0
    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.accelerometerUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: { (accelerometerData: CMAccelerometerData?, error: NSError?) -> Void
            in
            
            self.dataOutput(accelerometerData!.acceleration)
            if error != nil {
                
                print(error)
                
            }
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func dataOutput(acceleration: CMAcceleration) {
        
        let x = acceleration.x
        let y = acceleration.y
        let z = acceleration.z
        
        let magnitude = sqrt( (pow(x, 2.0)) + (pow(y, 2.0)) + (pow(z, 2.0)) )
        
        self.currentMag = magnitude
        
        if fabs(maxMag) < fabs(currentMag) {
            
            maxMag = currentMag
            
        }

        self.magnitudeLabel.text = "\(magnitude)"
        self.maxLabel.text = "\(maxMag)"
        
    }
    
    @IBAction func Reset(sender: AnyObject) {
        
        maxMag = 0.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

