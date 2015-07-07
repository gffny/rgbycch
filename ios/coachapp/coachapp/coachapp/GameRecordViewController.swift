//
//  DetailViewController.swift
//  coachapp
//
//  Created by John D. Gaffney on 7/7/15.
//  Copyright (c) 2015 gffny.com. All rights reserved.
//

import UIKit

class GameRecordViewController: UIViewController {

    @IBOutlet weak var fieldView: UIView!

    func configureView() {
    }
    
    override func viewDidLayoutSubviews() {

        var screenBounds = UIScreen.mainScreen().bounds;
        var image: UIImage = UIImage(named: "field-representation")!;
        let imageView = UIImageView(image: image)
        var xPos : CGFloat = screenBounds.width - image.size.width - 10
        imageView.frame = CGRect(origin: CGPoint(x: xPos, y: 28), size: CGSize(width: image.size.width, height: image.size.height))
        view.addSubview(imageView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blueColor()
    }

    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

