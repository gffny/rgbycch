//
//  DetailViewController.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/7/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import UIKit

class GameRecordViewController: UIViewController {
    
    weak var kickOffView : UIView!
    weak var imageView : UIImageView!

    override func viewDidLayoutSubviews() {
        loadFieldRepresentationView()
    }
    
    func loadFieldRepresentationView() {

        if (kickOffView == nil && imageView == nil) {
        
            var screenBounds = UIScreen.mainScreen().bounds
            var image: UIImage = UIImage(named: "field-representation")!
            var xPos: CGFloat = screenBounds.width - image.size.width - 10
            var frame: CGRect = CGRect(origin: CGPoint(x: xPos, y: 28), size: CGSize(width: image.size.width, height: image.size.height))
        
            // the field image
            var imageViewHolder: UIImageView = UIImageView(image: image)
            imageView = imageViewHolder
            imageView.frame = frame
            // the kickoff button view
            var kickOffViewHolder: UIView = UIView(frame: frame)
            kickOffView = kickOffViewHolder
            kickOffView.alpha = 0.6;
            kickOffView.backgroundColor = UIColor.blackColor();
            kickOffView.frame = frame;
            // the kickoff label
            var button: UIButton = UIButton(frame: CGRectMake(200, 200, 315, 140))
            button.backgroundColor=UIColor.whiteColor()
            button.setTitle("Kick Off", forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState:UIControlState.Normal)
            button.addTarget(self, action: "kickOff:", forControlEvents: UIControlEvents.TouchUpInside)

            view.addSubview(imageView)
            kickOffView.addSubview(button)
            view.addSubview(kickOffView);
        }
        //TODO handle orientation change?
    }

    @IBAction func kickOff(sender: UIButton!) {
        var alertView = UIAlertView();
        alertView.addButtonWithTitle("Ok");
        alertView.title = "title";
        alertView.message = "message";
        alertView.show();

        let subViews = view.subviews
        for subview in subViews{

            if(subview as UIView == kickOffView) {
                subview.removeFromSuperview()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blueColor()
    }
}

