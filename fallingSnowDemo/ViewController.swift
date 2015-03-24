//
//  ViewController.swift
//  fallingSnowDemo
//
//  Created by Jonlin Pei on 3/23/15.
//  Copyright (c) 2015 Jonlin Pei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

//    @IBOutlet weak var snowView: UIView!
    
    var snowSpawnPoint: CGPoint!
    var snowSpawnX: Int!
    var animator: UIDynamicAnimator!
    
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior()
        animator.addBehavior(collision)
        
        collision.addBoundaryWithIdentifier("barrier", fromPoint: CGPoint(x: 0, y: self.view.frame.height/2), toPoint: CGPointMake(self.view.frame.width/2, self.view.frame.height/1.7))
        collision.addBoundaryWithIdentifier("ground", fromPoint: CGPoint(x: 0, y: self.view.frame.height), toPoint: CGPointMake(self.view.frame.width, self.view.frame.height))
        collision.collisionDelegate = self


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    func onTimer() {
        snowSpawnX = Int(arc4random_uniform(320))
//        snowSpawnPoint = CGPoint(x: snowSpawnX, y: 0)
        var snowView = UIView(frame: CGRect(x: snowSpawnX, y: 0, width: 5, height: 5))
        snowView.backgroundColor = UIColor.whiteColor()
        snowView.layer.cornerRadius = 2.5
        
        view.addSubview(snowView)
        gravity.addItem(snowView)
        collision.addItem(snowView)
        
        delay(2) {
            self.meltSnow(snowView)
        }

    }
    
    func meltSnow(view: UIView!) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            view.alpha = 0
        }) { (Bool) -> Void in
            view.removeFromSuperview()
        }
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
    
    // You have to convert the identifier to a string
    var boundary = "ground" as String?
    
    // The view that collided with the boundary has to be converted to a view
//    var view = snowView as UIView
    
    if boundary == "ground" {
    println("collided with ground")
    } else if (boundary == nil) {
    // Detected collision with bounds of reference view
    }
    }
    
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    
    
    
}

