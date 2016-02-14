//
//  ASBubbleDrag.swift
//
//
//  Created by Alberto Scampini on 26/01/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import UIKit

protocol ASBubbleDragDelegate {
    func ASBubbleDragSelectedMenuItemAtIndex(index : NSInteger)
}

class ASBubbleDrag: UIView, BubbleDragViewDelegate {
    
    var mainView : BubbleDragView!
    var delegate : ASBubbleDragDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainViewInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.mainViewInit()
    }

    func mainViewInit() {
        //load mainView from xib
        let subviewArray = NSBundle.mainBundle().loadNibNamed("BubbleDragView", owner: self, options: nil)
        self.mainView = subviewArray.first as! BubbleDragView
        self.mainView.delegate = self
        self.addSubview(mainView)
        //add layout to mainView
        mainView.translatesAutoresizingMaskIntoConstraints = false
        let selfTop = NSLayoutConstraint(item: mainView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        let selfBottom = NSLayoutConstraint(item: mainView,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        let selfLeft = NSLayoutConstraint(item: mainView,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1,
            constant: 0)
        let selfRight = NSLayoutConstraint(item: mainView,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        self.addConstraints([selfTop, selfBottom, selfLeft, selfRight])
    }
    
    //MARK: public methods
    
    func populate(iconsArray : Array<UIImage?>) {
        self.mainView.populateWithData(iconsArray)
    }
    
    //MARK: bubbleDragView delegate
    
    func selectedIndex(index: NSInteger) {
        self.delegate?.ASBubbleDragSelectedMenuItemAtIndex(index)
    }
    
}