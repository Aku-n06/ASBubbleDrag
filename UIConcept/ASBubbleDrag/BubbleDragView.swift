//
//  BubbleDragView.swift
//  
//
//  Created by Alberto Scampini on 27/01/2016.
//  Copyright © 2016 Alberto Scampini. All rights reserved.
//

import UIKit
import Darwin

protocol BubbleDragViewDelegate {
    func selectedIndex(index : NSInteger)
}

class BubbleDragView: UIView, UICollectionViewDataSource {

    var delegate : BubbleDragViewDelegate?
    @IBOutlet var collectionView : UICollectionView!
    
    override func drawRect(rect: CGRect) {
        
        //prepare collectionView
        let nib = UINib(nibName: "BubbleCollectionCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "BubbleCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .Horizontal
        //self.collectionView.collectionViewLayout = layout
        self.collectionView.dataSource = self
        
        //add gesture recognizers
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(BubbleDragView.handleDrag(_:)))
        dragGesture.maximumNumberOfTouches = 1
        self.addGestureRecognizer(dragGesture)
        
        self.initDragItem()
    }
    
    //MARK: public methods
    
    var mutableDataSource = Array<UIImage>()
    var indexDataSource = Array<NSInteger>()
    
    func populateWithData(data : Array<UIImage?>) {
        //check input images
        self.mutableDataSource = Array<UIImage>()
        self.mutableDataSource = Array<UIImage>()
        var indexCount = 0
        for image in data {
            if (image == nil) {
                self.mutableDataSource.append(UIImage(named: "MenuBubbleV.png")!)
            } else {
                self.mutableDataSource.append(image!)
            }
            self.indexDataSource.append(indexCount)
            indexCount += 1
        }
        self.collectionView.reloadData()
    }
    
    //MARK: collectionView DataSource adn Layout
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mutableDataSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BubbleCell", forIndexPath: indexPath) as! BubbleCollectionCell
        cell.picture.image = self.mutableDataSource[indexPath.row]
        return cell
    }
    
    //MARK : drag interaction
    
    var selectedItem : NSIndexPath?
    var dragItem = UIImageView()
    var dragEnabled = false
    @IBOutlet var target : UIView!
    
    internal func initDragItem () {
        self.dragItem.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.dragItem.layer.cornerRadius = 50
        self.dragItem.clipsToBounds = true
        self.dragItem.contentMode = .ScaleAspectFit
        self.dragItem.backgroundColor = UIColor.whiteColor()
        self.dragItem.alpha = 0
    }
    
    internal func handleDrag (pan : UIPanGestureRecognizer) {
        if pan.state == .Began { //start dragging
             //if not already animating
            if self.selectedItem == nil {
                
                //check if on scrollview
                let touch = pan.locationInView(self.collectionView)
                let indexPath = self.collectionView.indexPathForItemAtPoint(touch)
                
                //save selection informations
                selectedItem = indexPath
                if (indexPath != nil) {
                    
                    //add item
                    self.dragItem.image = self.mutableDataSource[selectedItem!.row]
                    self.addSubview(self.dragItem)
                    self.dragItem.center = pan.locationInView(self)
                    self.dragItem.alpha = 1
                    
                    //remove element from collection
                    self.collectionView.performBatchUpdates({ () -> Void in
                        self.mutableDataSource.removeAtIndex(indexPath!.row)
                        self.collectionView.deleteItemsAtIndexPaths([indexPath!])
                        }, completion: nil)
                    
                    //enable animation mode
                    dragEnabled = true
                    self.collectionView.userInteractionEnabled = false
                }
            }
        } else if pan.state == .Ended { //end dragging
            if dragEnabled == true {
                dragEnabled = false
                
                //check item position math
                let p1 = self.target.convertPoint(CGPointMake(50, 50), toView: self)
                let p2 = self.dragItem.center
                let distance = sqrt( pow(abs(p1.x - p2.x), 2) + pow(abs(p1.y - p2.y), 2) )
                if(distance < 100) {
                    //animation sucked on target
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.dragItem.center = p1
                    }, completion: { (flag) -> Void in
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            self.dragItem.alpha = 0
                            }, completion: { (flag) -> Void in
                                self.delegate?.selectedIndex(self.indexDataSource[self.selectedItem!.row])
                                self.indexDataSource.removeAtIndex(self.selectedItem!.row)
                                self.dragItem.removeFromSuperview()
                                self.selectedItem = nil
                                self.collectionView.userInteractionEnabled = true

                        })
                    })
                
                } else {
                    
                    //calculate position will have in collection view
                    var endPoint : CGPoint!
                    if (self.mutableDataSource.count == 0) { //empty collection
                        endPoint = CGPoint(x: 50, y: self.collectionView.center.y)
                    } else if (selectedItem!.item <= (self.mutableDataSource.count - 1)) {
                        let cellSelected = self.collectionView.cellForItemAtIndexPath(selectedItem!)
                        endPoint = cellSelected?.convertPoint(CGPointMake(50, 50), toView: self)
                    } else { //last element
                        let lastIndex = NSIndexPath(forItem: self.mutableDataSource.count - 1, inSection: 0)
                        let cellSelected = self.collectionView.cellForItemAtIndexPath(lastIndex)
                        endPoint = cellSelected?.convertPoint(CGPointMake(50, 50), toView: self)
                        endPoint?.x += 110
                    }
                
                    //animation sucked back to collection view
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        self.dragItem.center = endPoint
                    }, completion: { (flag) -> Void in

                        //insert element to collection
                        self.collectionView.performBatchUpdates({ () -> Void in
                            self.mutableDataSource.insert(self.dragItem.image!, atIndex: self.selectedItem!.row)
                            self.collectionView.insertItemsAtIndexPaths([self.selectedItem!])
                            }, completion: { (flag) -> Void in
                                self.dragItem.removeFromSuperview()
                                if self.selectedItem!.item == (self.mutableDataSource.count - 1) { // last item (show it)
                                    self.collectionView.scrollToItemAtIndexPath(self.selectedItem!, atScrollPosition: .Right, animated: true)
                                }
                                self.selectedItem = nil
                                self.collectionView.userInteractionEnabled = true
                        })
                    })
                }
            }
            
        } else if dragEnabled == true { //dragging
            self.dragItem.center = pan.locationInView(self)
        }
    }
    
}
