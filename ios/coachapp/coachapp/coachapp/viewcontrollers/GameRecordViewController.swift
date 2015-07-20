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
    var matchIncident: MatchIncident!
    var matchIncidentList: NSArray!

    //TODO add two lists of players, i.e. home and opposition

    var matchInProgress: Bool = false

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated);

        touchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToFieldTapGesture:")))
        incidentRecordView.buttonOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:")))
        incidentRecordView.buttonTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:")))
        incidentRecordView.buttonThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:")))
        incidentRecordView.buttonFour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:")))
        incidentRecordView.buttonFive.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:")))
        incidentRecordView.buttonSix.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentRecordTapGesture:")))
        incidentRecordView.alpha = 0;
    }

    func respondToFieldTapGesture(gesture: UIGestureRecognizer) {

        if(matchInProgress) {
            startNewMatchIncident();
            //TODO record tap location
            displayIncidentRecordModal()
        } else {
            fieldView.clearDisplay()
            self.matchInProgress = true
        }
    }

    func startNewMatchIncident() {
        matchIncident = MatchIncident()
    }

    func displayIncidentRecordModal() {

        incidentRecordView.alpha = 1;
        incidentRecordView.hidden = false;
    }

    func displayIncidentResultModal(incidentType: IncidentType) {
        
        var count : Int = 0
        
        for incidentResult in IncidentType.getResultList(incidentType) {
            incidentRecordView.getButtonAtPosition(count).setTitle(incidentResult.getName(), forState: UIControlState.Normal)
            for existingGR in incidentRecordView.getButtonAtPosition(count).gestureRecognizers as [UITapGestureRecognizer] {
                incidentRecordView.getButtonAtPosition(count).removeGestureRecognizer(existingGR)
            }
            incidentRecordView.getButtonAtPosition(count).addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("respondToIncidentResultapGesture:")))
            count++
        }
        for count; count < 6; count++ {
             incidentRecordView.getButtonAtPosition(count).setTitle("", forState: UIControlState.Normal)
            for existingGR in incidentRecordView.getButtonAtPosition(count).gestureRecognizers as [UITapGestureRecognizer] {
                incidentRecordView.getButtonAtPosition(count).removeGestureRecognizer(existingGR)
            }
            incidentRecordView.getButtonAtPosition(count).enabled = false
        }
    }
    
    func respondToIncidentRecordTapGesture(gesture: UIGestureRecognizer) {
        
        var triggerButton : UIButton = gesture.view as UIButton
        NSLog(triggerButton.titleForState(UIControlState.Normal)!)

        if(triggerButton == incidentRecordView.buttonOne) {
            startNewMatchIncident()
            matchIncident.incidentType = IncidentType.Penalty
            displayIncidentResultModal(IncidentType.Penalty)
        } else if(triggerButton == incidentRecordView.buttonTwo) {
            startNewMatchIncident()
            matchIncident.incidentType = IncidentType.Foul
            displayIncidentResultModal(IncidentType.Foul)

        } else if(triggerButton == incidentRecordView.buttonThree) {
            startNewMatchIncident()
            matchIncident.incidentType = IncidentType.Score
        } else if(triggerButton == incidentRecordView.buttonFour) {
            startNewMatchIncident()
            matchIncident.incidentType = IncidentType.TurnOver
        }
    }

    func respondToIncidentResultapGesture(gesture: UIGestureRecognizer) {

        var triggerButton : UIButton = gesture.view as UIButton
        NSLog(triggerButton.titleForState(UIControlState.Normal)!)
        for incidentResult in IncidentResult {
            
        }
    }
}

