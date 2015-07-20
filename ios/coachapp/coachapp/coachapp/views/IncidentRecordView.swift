//
//  IncidentRecordView.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/10/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import UIKit

@IBDesignable class IncidentRecordView: UIView {

    // Our custom view from the XIB file
    weak var view: UIView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
    }

    func xibSetup() {
        
        view = loadViewFromNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "IncidentRecordView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }

    func getButtonAtPosition(position: Int) -> UIButton {
        switch(position) {
        case 0:
            return buttonOne
        case 1:
            return buttonTwo
        case 2:
            return buttonThree
        case 3:
            return buttonFour
        case 4:
            return buttonFive
        case 5:
            return buttonSix
        default:
            return buttonOne
        }
    }
}
