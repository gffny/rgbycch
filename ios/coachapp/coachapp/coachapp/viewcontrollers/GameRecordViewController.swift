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
    @IBOutlet weak var fieldView: FieldView!
    @IBOutlet weak var incidentRecordView: IncidentRecordView!

    //TODO add two lists of players, i.e. home and opposition

    var matchInProgress: Bool = false

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated);

        var fieldTapGesture = UITapGestureRecognizer(target: self, action: Selector("respondToFieldTapGesture:"))
        touchView.addGestureRecognizer(fieldTapGesture)
        var incidentRecordGesture = UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:"))
        incidentRecordView.alpha = 0;
    }

    func respondToFieldTapGesture(gesture: UIGestureRecognizer) {

        if(matchInProgress) {
            displayIncidentRecordModal()
        } else {
            fieldView.clearDisplay()
            self.matchInProgress = true
        }
    }
    
    func respondToIncidentRecordTapGesture(gesture: UIGestureRecognizer) {
        
    }

    func displayIncidentRecordModal() {

        incidentRecordView.alpha = 1;
        incidentRecordView.hidden = false;
        incidentRecordView.renderIncidentRecordButtons()

    }
}

