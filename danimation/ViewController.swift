//
//  ViewController.swift
//  danimation
//
//  Created by Julia Samoshchenko on 31.03.17.
//  Copyright © 2017 JS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var squareView: UIView!
    var barierView: UIView!
    
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var collision:UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        setupAnimationTools()
    }

    
    func setupView() {
        squareView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        squareView.backgroundColor = UIColor.purple
        self.view.addSubview(squareView)
        
        barierView = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barierView.backgroundColor = UIColor.blue
        self.view.addSubview(barierView)
    }
    
    func setupAnimationTools(){
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [ squareView ])
        gravity.magnitude = 1
        animator.addBehavior(gravity)
        collision = UICollisionBehavior(items: [ squareView ])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        
        
        let barrierRightPoint = CGPoint(x: self.barierView.frame.origin.x + self.barierView.frame.size.width, y: self.barierView.frame.origin.y + self.barierView.frame.size.height)
        collision.addBoundary(withIdentifier: "barrier" as NSCopying, from: self.barierView.frame.origin, to: barrierRightPoint)
//        collision.setTranslatesReferenceBoundsIntoBoundary(with: UIEdgeInsetsMake(0, 0, 50, 0))
//        collision.addBoundary(withIdentifier: "CollistionTest" as NSCopying, from: self.view.center, to: CGPoint(x: self.view.center.x - 50, y: self.view.center.y + 100))
        collision.collisionDelegate = self
        animator.addBehavior(collision)
    }

}

extension ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        self.squareView.backgroundColor = UIColor.purple
        self.barierView.backgroundColor = UIColor.blue
        UIView.animate(withDuration: 0.2) {
            self.squareView.backgroundColor = UIColor.red
            self.barierView.backgroundColor = UIColor.darkGray
        }
//        gravity.gravityDirection.dy = -gravity.gravityDirection.dy
//        gravity.gravityDirection.dx = -gravity.gravityDirection.dx
    }
}
