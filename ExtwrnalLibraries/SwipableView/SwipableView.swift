//
//  SwipableView.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 14/05/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class SwipableView: UIView {
    
    var previousView: SwipableMovie?
    var currentView: SwipableMovie?
    var nextView: SwipableMovie?
    var pangr: UIPanGestureRecognizer?
    var tapgr: UITapGestureRecognizer?
    
     var dataSource: SwipableViewDataSource?{
        didSet{
            guard let dataSource = dataSource else {
                return
            }
            self.dataSource = dataSource
            if (self.dataSource != nil) {
                    reloadData()
                }
            }
        }
    
    var delegate: SwipableViewDelegate?
    var numberOfItems: Int = 0
    var currentItemIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        previousView = nil
        currentView = nil
        nextView = nil
        pangr = nil
        tapgr = nil
        numberOfItems = 0
        currentItemIndex = 0
        dataSource = nil
        delegate = nil
    }
    
    func reloadData() {
        if (currentView != nil) {
            currentView!.removeGestureRecognizer(pangr!)
            currentView!.removeGestureRecognizer(tapgr!)
            currentView!.removeFromSuperview()
        }
        if (previousView != nil) {
            previousView!.removeFromSuperview()
        }
        if (nextView != nil) {
            nextView!.removeFromSuperview()
        }
        
        if (dataSource != nil) {
            numberOfItems = dataSource?.numberOfItems(in: self) ?? 0
            if numberOfItems > 0 {
                if (currentItemIndex >= 0) && (currentItemIndex < numberOfItems) {
                    currentView = ((dataSource?.swipableView(self, viewForItemAt: currentItemIndex, reusing: currentView)) as! SwipableMovie)
                    if (currentView != nil) {
                        pangr = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
                        currentView!.addGestureRecognizer(pangr!)
                        tapgr = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
                        currentView!.addGestureRecognizer(tapgr!)
                    }
                }
                if ((currentItemIndex - 1) >= 0) && ((currentItemIndex - 1) < numberOfItems) {
                    previousView! = (dataSource?.swipableView(self, viewForItemAt: currentItemIndex - 1, reusing: previousView!))! as! SwipableMovie
                    if (previousView != nil) {
                        previousView!.transform = CGAffineTransform(translationX: 0, y: -previousView!.frame.size.height)
                    }
                }
                if ((currentItemIndex + 1) >= 0) && ((currentItemIndex + 1) < numberOfItems) {
                    nextView = ((dataSource?.swipableView(self, viewForItemAt: currentItemIndex + 1, reusing: nextView))! as! SwipableMovie)
                    if (nextView != nil) {
                        nextView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    }
                }
                if (nextView != nil) {
                    addSubview(nextView!)
                }
                if (currentView != nil) {
                    addSubview(currentView!)
                }
                if (previousView != nil) {
                    addSubview(previousView!)
                }
            }

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func viewPanned(_ sender: Any?) {
        let pangr = sender as? UIPanGestureRecognizer
        let translationInView: CGPoint? = pangr?.translation(in: pangr?.view)
        
        let velocityY: CGFloat = 0.2 * ((sender as? UIPanGestureRecognizer)?.velocity(in: self).y ?? 0.0)
        
        if pangr?.state == .began {
            let animationDuration: CGFloat = (abs(velocityY) * 0.0002) + 0.15
            
            UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, options: .curveEaseOut, animations: {
                if translationInView!.y < 0 {
                    if (self.nextView != nil) {
                        self.currentView!.transform = CGAffineTransform(translationX: 0, y: translationInView!.y)
                        self.nextView!.transform = CGAffineTransform(scaleX: 0.9 - (translationInView!.y) / (10 * self.nextView!.frame.size.height), y: 0.9 - (translationInView!.y) / (10 * self.nextView!.frame.size.height))
                    } else {
                        self.currentView!.transform = CGAffineTransform(translationX: 0, y: translationInView!.y / 3)
                    }
                } else {
                    if (self.previousView != nil) {
                        self.currentView!.transform = CGAffineTransform(scaleX: 1.0 - (translationInView!.y) / (10 * self.currentView!.frame.size.height), y: 1.0 - (translationInView!.y) / (10 * self.currentView!.frame.size.height))
                        self.previousView!.transform = CGAffineTransform(translationX: 0, y: translationInView!.y - self.previousView!.frame.size.height)
                    } else {
                        self.currentView!.transform = CGAffineTransform(scaleX: 1.0 - (translationInView!.y / 3) / (10 * self.currentView!.frame.size.height), y: 1.0 - (translationInView!.y / 3) / (10 * self.currentView!.frame.size.height))
                    }
                }
                
            }) { finished in
                
            }
        }
        
        if pangr?.state == .ended{
            if translationInView!.y < 0 {
                // user was swiping up and the gesture has now ended
                if (nextView != nil) && ((translationInView!.y < -currentView!.frame.size.height / 2) || (velocityY < -200)) {
                    // treat the swipe-up gesture as completed
                    // CurrentIndex has now increased by one
                    let animationDuration: CGFloat = 0.25
                    UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, options: .curveEaseOut, animations: {
                        self.currentView!.transform = CGAffineTransform(translationX: 0, y: -self.currentView!.frame.size.height)
                        self.nextView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }) { finished in
                       // self.sendSubviewToBack(self.previousView!)
                        self.currentView!.removeGestureRecognizer(self.pangr!)
                        self.currentView!.removeGestureRecognizer(self.tapgr!)
                        
                        var temp: UIView? = self.previousView ?? nil
                        self.previousView = self.currentView
                        self.currentView = self.nextView
                        self.nextView = temp as? SwipableMovie
                        
                        self.nextView?.removeFromSuperview()
                        self.currentItemIndex += 1
                        if self.currentItemIndex >= self.numberOfItems {
                            self.currentItemIndex = self.numberOfItems - 1
                        }
                        temp = nil
                        if self.dataSource != nil {
                            if (self.currentItemIndex + 1) < self.numberOfItems {
                                temp = self.dataSource?.swipableView(self, viewForItemAt: self.currentItemIndex + 1, reusing: self.nextView)
                            }
                        }
                        self.nextView = temp as? SwipableMovie
                        if (self.nextView != nil) {
                            self.insertSubview(self.nextView!, at: 0)
                            self.nextView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        }
                        self.previousView!.transform = CGAffineTransform(translationX: 0, y: -self.previousView!.frame.size.height)
                        self.currentView!.addGestureRecognizer(pangr!)
                        self.currentView!.addGestureRecognizer(self.tapgr!)
                        if (self.delegate != nil) {
                            self.delegate?.swipableViewCurrentItemIndexDidChange!(self)
                            self.delegate?.swipeUPFinished!(self)
                        }
                    }
        }
                else{
                    let animationDuration: CGFloat = 0.25
                    
                    UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, options: .curveEaseOut, animations: {
                        self.currentView!.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.nextView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    }) { finished in
                        if (self.delegate != nil) {
                            self.delegate?.swipeUPFinished!(self)
                        }
                    }
                }
            }
            
            else{
                if !(previousView != nil) || (translationInView!.y < (currentView!.frame.size.height / 2) && (velocityY < 200)) {
                    // treat the swipe-down gesture as cancelled
                    // Restore
                    let animationDuration: CGFloat = 0.25
                    
                    UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, options: .curveEaseOut, animations: {
                        self.currentView!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        self.previousView?.transform = CGAffineTransform(translationX: 0, y: -self.previousView!.frame.size.height)
                    }) { finished in
                        //                    NSLog(@"complete");
                        
                    }
                }
                else{
                    // treat the swipe-down gesture as completed
                    //  CurrentIndex has now decreased by one
                    let animationDuration: CGFloat = 0.25
                    
                    UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, options: .curveEaseOut, animations: {
                        self.currentView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.previousView!.transform = CGAffineTransform(translationX: 0, y: 0)
                    }) { finished in
                        //                    NSLog(@"complete");
                        self.nextView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        //self.bringSubviewToFront(self.nextView!)
                        self.currentView!.removeGestureRecognizer(self.pangr!)
                        self.currentView!.removeGestureRecognizer(self.tapgr!)
                        
                        var temp: UIView? = self.nextView ?? nil
                        self.nextView = self.currentView
                        self.currentView = self.previousView
                        self.previousView = temp as? SwipableMovie
                        
                        self.previousView?.removeFromSuperview()
                        
                        self.currentItemIndex -= 1
                        if self.currentItemIndex < 0 {
                            self.currentItemIndex = 0
                        }
                        temp = nil
                        if self.dataSource != nil {
                            if (self.currentItemIndex - 1) >= 0 {
                                temp = self.dataSource?.swipableView(self, viewForItemAt: self.currentItemIndex - 1, reusing: self.previousView)
                            }
                        }
                        self.previousView = temp as? SwipableMovie
                        if (self.previousView != nil) {
                            self.insertSubview(self.previousView!, at: 2)
                            self.previousView!.transform = CGAffineTransform(translationX: 0, y: -self.previousView!.frame.size.height)
                        }
                        
                        self.nextView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.currentView!.addGestureRecognizer(pangr!)
                        self.currentView!.addGestureRecognizer(self.tapgr!)
                        if (self.delegate != nil) {
                            self.delegate?.swipableViewCurrentItemIndexDidChange!(self)
                            self.delegate?.swipeDownFinished!(self)
                        }
                    }
                }
            }
    }
        
        if pangr!.state == .changed {
            //        NSLog(@"UIGestureRecognizerStateChanged");
            let animationDuration: CGFloat = (abs(velocityY) * 0.0002) + 0.15
            
            UIView.animate(withDuration: TimeInterval(animationDuration), delay: 0, options: .curveEaseOut, animations: {
                if translationInView!.y < 0 {
                    if (self.nextView != nil) {
                        self.currentView!.transform = CGAffineTransform(translationX: 0, y: translationInView!.y)
                        self.nextView!.transform = CGAffineTransform(scaleX: 0.9 - (translationInView!.y) / (10 * self.nextView!.frame.size.height), y: 0.9 - (translationInView!.y) / (10 * self.nextView!.frame.size.height))
                        self.previousView?.transform = CGAffineTransform(translationX: 0, y: -self.previousView!.frame.size.height)
                    } else {
                        self.currentView!.transform = CGAffineTransform(translationX: 0, y: translationInView!.y / 3)
                        self.previousView!.transform = CGAffineTransform(translationX: 0, y: -self.previousView!.frame.size.height)
                    }
                    
                }
                
                else {
                    if (self.previousView != nil) {
                        self.currentView!.transform = CGAffineTransform(scaleX: 1.0 - (translationInView!.y) / (10 * self.currentView!.frame.size.height), y: 1.0 - (translationInView!.y) / (10 * self.currentView!.frame.size.height))
                        self.previousView!.transform = CGAffineTransform(translationX: 0, y: translationInView!.y - self.previousView!.frame.size.height)
                        self.nextView?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    } else {
                        self.currentView!.transform = CGAffineTransform(scaleX: 1.0 - (translationInView!.y / 3) / (10 * self.currentView!.frame.size.height), y: 1.0 - (translationInView!.y / 3) / (10 * self.currentView!.frame.size.height))
                        self.nextView!.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    }
                }
                
            }) { finished in
                
            }
            
    }
    }
    @objc func viewTapped(_ sender: Any?) {
        //    NSLog(@"viewTapped");
        if (delegate != nil) {
            delegate?.swipableView!(self, didSelectItemAt: currentItemIndex)
        }
    }
    
}

protocol SwipableViewDataSource: NSObjectProtocol {
    func numberOfItems(in swipableView: SwipableView?) -> Int
    func swipableView(_ swipableView: SwipableView?, viewForItemAt index: Int, reusing view: UIView?) -> UIView?
}

@objc protocol SwipableViewDelegate: NSObjectProtocol {
    @objc optional func swipableViewCurrentItemIndexDidChange(_ swipableView: SwipableView?)
    @objc optional func swipableView(_ swipableView: SwipableView?, didSelectItemAt index: Int)
    @objc optional func swipeDownFinished(_ swipableView: SwipableView?)
    @objc optional func swipeUPFinished(_ swipableView: SwipableView?)
}
