//
//  FieldView.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/8/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import UIKit

@IBDesignable class FieldView: UIView {

    // Our custom view from the XIB file
    weak var view: UIView!
    @IBOutlet weak var actionLabel: UILabel!

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
        
        renderKickOffDisplay()

        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "FieldRepresentation", bundle: bundle)

        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }
    
    func renderKickOffDisplay() {
        // hide any none used controls
        actionLabel.hidden = false
        actionLabel.text = "Tap for Kick Off"
    }
    
    func clearDisplay() {
        actionLabel.hidden = true
    }

}
