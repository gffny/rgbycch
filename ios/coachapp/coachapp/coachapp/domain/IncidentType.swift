//
//  IncidentType.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/12/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import Foundation

enum IncidentType {
    
    case Penalty
    case Foul
    case Score
    case TurnOver

    static var penaltyResultList: [IncidentResult] {
        return [IncidentResult.Advantage, IncidentResult.KickAtGoal, IncidentResult.KickToTouch, IncidentResult.Scrum, IncidentResult.TapAndGo]
    }
    
    static var foulResultList: [IncidentResult] {
        return [IncidentResult.Advantage, IncidentResult.Scrum, IncidentResult.Lineout]
    }
    
    static func getResultList (incidentType: IncidentType) -> [IncidentResult] {
        switch(incidentType) {
        case .Penalty:
            return penaltyResultList
        case .Foul:
            return foulResultList
        case .Score:
            return []
        case .TurnOver:
            return []
        }
    }

}