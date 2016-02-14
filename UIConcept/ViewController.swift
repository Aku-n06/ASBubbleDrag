//
//  ViewController.swift
//  UIConcept
//
//  Created by Alberto Scampini on 14/02/16.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ASBubbleDragDelegate {

    @IBOutlet var bubbleDragView : ASBubbleDrag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let icons : Array<UIImage?> = [
            UIImage(named: "icon1"),
            UIImage(named: "icon2"),
            UIImage(named: "icon3"),
            UIImage(named: "icon4"),
            UIImage(named: "icon5"),
            UIImage(named: "icon6"),
            UIImage(named: "icon7"),
            UIImage(named: "icon8"),
            UIImage(named: "icon9"),
            UIImage(named: "icon10"),
            UIImage(named: "icon11")
        ]
        self.bubbleDragView.populate(icons)
        self.bubbleDragView.delegate = self
    }

    //MARK : ASMenuBubble Delegate
    
    func ASBubbleDragSelectedMenuItemAtIndex(index: NSInteger) {
        let colors : Array<UIColor> = [
            UIColor(red:0.24, green:0.59, blue:0.96, alpha:1),
            UIColor(red:0.91, green:0.29, blue:0.27, alpha:1),
            UIColor(red:0.45, green:0.86, blue:0.42, alpha:1),
            UIColor(red:1, green:0.89, blue:0.22, alpha:1),
            UIColor(red:0.93, green:0.52, blue:0.2, alpha:1),
            UIColor(red:0.78, green:0.35, blue:1, alpha:1),
            UIColor(red:0.39, green:0.8, blue:0.71, alpha:1),
            UIColor(red:0.06, green:0.19, blue:0.69, alpha:1),
            UIColor(red:0.7, green:0.81, blue:0.9, alpha:1),
            UIColor(red:0.92, green:0.51, blue:0.2, alpha:1),
            UIColor(red:0.39, green:0.69, blue:0.01, alpha:1)
        ]
        self.view.backgroundColor = colors[index]
    }
}

