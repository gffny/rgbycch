//
//  IncidentResult.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/12/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import Foundation

enum IncidentResult {
    
    case KickAtGoal
    case KickToTouch
    case Scrum
    case TapAndGo
    case Conversion
    case Advantage
    case KickOff
    case Dropout
    case Lineout
    
    static var allResultList [IncidentResult] {
        return []
    }
    
    func getName() -> String {
        
        switch(self) {
        case .KickAtGoal:
            return "Kick at Goal"
        case .KickToTouch:
            return "Kick to Touch"
        case .Scrum:
            return "Scrum"
        case .TapAndGo:
            return "Tap and Go"
        case .Conversion:
            return "Conversion"
        case .Advantage:
            return "Advantage"
        case .KickOff:
            return "Kick Off"
        case .Dropout:
            return "22 Dropout"
        case .Lineout:
            return "Lineout"
        default:
            return " "
        }
    }
}