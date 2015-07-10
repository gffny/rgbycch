//
//  GameRecordViewController.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/7/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import UIKit

class GameRecordViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var touchView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        var tapGesture = UITapGestureRecognizer(target: self, action: Selector("respondToTapGesture:"))
        touchView.addGestureRecognizer(tapGesture)
        UIScreen.mainScreen().bounds
    }


    func respondToTapGesture(gesture: UIGestureRecognizer) {
        NSLog("tap tap")
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if(touch.view .isKindOfClass(FieldView)) {
            return true;
        }
        return false;
    }
}

