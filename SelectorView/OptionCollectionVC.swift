//
//  OptionCollectionVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/17/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "OptionCell"

class OptionCollectionVC: UICollectionViewController {
    
    var workoutOptionData:[WorkoutOptionData] = []
    
//    var SCROLL_CONTENT_WIDTH : CGFloat = self.collectionView!.contentSize.width
//    var SCROLL_PAGE_WIDTH    : CGFloat = self.collectionView!.bounds.width
//    
//    let flowLayout: UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
//    let ITEM_WIDTH   :CGFloat = flowLayout.itemSize.width
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init(collectionViewLayout layout: UICollectionViewLayout, options: [WorkoutOptionData]) {
        super.init(collectionViewLayout: layout)
        
        self.collectionView!.registerClass(WorkoutOptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.clearsSelectionOnViewWillAppear = false
        self.workoutOptionData = options
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did Load Option View")
        
        self.view.backgroundColor = UIColor.purpleColor()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(WorkoutOptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        //Debug
//        /let idx : NSIndexPath = NSIndexPath(forItem: 2, inSection: 0)
        //self.collectionView?.selectItemAtIndexPath(idx, animated: false, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
        //self.collectionView(self.collectionView!, didSelectItemAtIndexPath: idx)

    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("view Will Appear")
        super.viewWillAppear(animated)
        
        
    
        
        
        //let idx : NSIndexPath = NSIndexPath(index: 2)
        //self.collectionView?.selectItemAtIndexPath(idx, animated: true, scrollPosition: UICollectionViewScrollPosition.CenteredHorizontally)
    }


    // MARK: UICollectionViewDataSource
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: numberOfSectionsInCollectionView
    
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: numberOfItemsInSection
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutOptionData.count
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: cellForItemAtIndexPath
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? WorkoutOptionCell
        
        //Configure The cell
        cell?.optionText.text = workoutOptionData[indexPath.item].labelName
        cell?.iconImage.image = UIImage(named: workoutOptionData[indexPath.item].labelName)
        
        return cell!
    }
    
    
    // MARK: UIScrollViewDelegate
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewDidScroll
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scroll View Did Scroll to content offsetx \(scrollView.contentOffset.x)")

        let flowLayout: UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let SCROLL_CONTENT_WIDTH = self.collectionView!.contentSize.width
        let SCROLL_PAGE_WIDTH    = self.collectionView!.bounds.width
        let ITEM_SPACING         = (SCROLL_PAGE_WIDTH * 0.1) / 4
        let ITEM_WIDTH           = flowLayout.itemSize.width
        let ITEM_OFFSET          = ITEM_WIDTH + ITEM_SPACING
        
        print("Scroll Content Width \(SCROLL_CONTENT_WIDTH)")
        print("Scroll Page Width \(SCROLL_PAGE_WIDTH)")
        print("Item Width \(ITEM_WIDTH)")
        
//        let FAKE_PAGE_OFFSET:CGFloat  = 400.00
//        let REAL_SIZE                 = (CGFloat)((workoutOptionData.count - 8) * ITEM_WIDTH)
//        let END_OF_REAL_ARRAY         = REAL_SIZE + FAKE_PAGE_OFFSET
//        
//        
//        struct PreviousContentOffset {
//            static var x: CGFloat = 0.0
//        }
//        
//        let scrollOffsetX = scrollView.contentOffset.x
//        let scrollOffsetY = scrollView.contentOffset.y
//        
//        // Handle Scrolling Left Rollover
//        if (scrollOffsetX >= END_OF_REAL_ARRAY) {
//            scrollView.contentOffset = CGPointMake(FAKE_PAGE_OFFSET, scrollOffsetY)
//            self.scrollDirection = ScrollDirection.Left
//        }
//            
//            // Handle Scrolling Right Rollover
//        else if (scrollOffsetX <= 0) {
//            scrollView.contentOffset = CGPointMake(REAL_SIZE, scrollOffsetY)
//            self.scrollDirection = ScrollDirection.Right
//        }
//            // Normal Scroll
//        else {
//            if (scrollOffsetX > PreviousContentOffset.x) {
//                self.scrollDirection = ScrollDirection.Left
//            }
//            else {
//                self.scrollDirection = ScrollDirection.Right
//            }
//        }
//        PreviousContentOffset.x = scrollView.contentOffset.x
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewDidEndDecelerating
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scroll View Did End Decelerating")
//        let cells = collectionView?.visibleCells()
//        
//        for cell in cells! {
//            let collectionCell = cell as? WorkoutOptionCell
//            print("Option: \(collectionCell?.optionText.text)")
//        }
//        if let collectionView = scrollView as? UICollectionView {
//            let visbleIndexArray = collectionView.indexPathsForVisibleItems()
//            let numberOfVisibleItems = visbleIndexArray.count
//            var idx = numberOfVisibleItems / 2
//            
//            // There are 4 Visible Items
//            if (numberOfVisibleItems == 4) {
//                if (self.scrollDirection == ScrollDirection.Right) {
//                    idx--
//                }
//            }
//            
//            let indexPath = translateToRealIndex(visbleIndexArray[idx])
//            
//            setSelectedOpion(indexPath)
        
//            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
//        }
        var idxArray : [NSIndexPath] = (collectionView?.indexPathsForVisibleItems())!
        idxArray.sortInPlace( {$0.item < $1.item } )
        
        for idx in idxArray {
            print("The array index is \(self.workoutOptionData[idx.item].labelName)")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewShouldScrollToTop
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return false
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewWillEndDragging
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scroll view will end dragging")
        
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? WorkoutOptionCell
 
        
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewDidEndDragging
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scroll view did end dragging")

//
//        if (scrollView.dragging == false && scrollView.tracking == true) {
//            print("End Dragging")
//            
//            if let collectionView = scrollView as? UICollectionView {
//                let visbleIndexArray = collectionView.indexPathsForVisibleItems()
//                let numberOfVisibleItems = visbleIndexArray.count
//                var idx = numberOfVisibleItems / 2
//                
//                // There are 4 Visible Items
//                if (numberOfVisibleItems == 4) {
//                    if (self.scrollDirection == ScrollDirection.Right) {
//                        idx--
//                    }
//                }
//                
//                let indexPath = translateToRealIndex(visbleIndexArray[idx])
//                
//                setSelectedOpion(indexPath)
//                collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
//            }
//        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewWillBeginDragging
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("scroll View Will Begin Dragging")
//        if let currentlySelectedItem = self.selectedItem {
//            self.selectedItem = nil
//            selectOptionViewCell(currentlySelectedItem, isSelected: false)
//        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewWillBeginDecelerating
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("scroll View Did End Scrolling Animation")
//        
//        if let currentlySelectedItem = self.selectedItem {
//            selectOptionViewCell(currentlySelectedItem, isSelected: true)
//        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollViewWillBeginDecelerating
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        print("scroll view will begin decelerating")
    }
    
    
    // MARK: UICollectionViewDelegate
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: collectionView: shouldSelectItemAtIndexPath
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
// 
        print("Collection View Should Select Item At Index Path \(indexPath.item)")
        let selectNewItem: Bool = true
//        
//        // An Item is currently selected
//        if let previouslySelected = self.selectedItem {
//            // Deselect Currently Selected Item
//            selectOptionViewCell(previouslySelected, isSelected: false)
//            
//            // The Selected Item is the same as the Previously Selected Item
//            if (indexPath.item == previouslySelected.item) {
//                // Do not select an Item
//                selectNewItem = false
//                // Set to Nothing Selected
//                setSelectedOpion(nil)
//            }
//        }
        
        return selectNewItem
    }

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: collectionView: didSelectItemAtIndexPath
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did select index \(indexPath.item)")
        self.collectionView?.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.Left)
//        let selectedIndexPath: NSIndexPath = translateToRealIndex(indexPath)
//        
//        struct LastSelected {
//            static var indexPath: NSIndexPath? = nil
//        }
//        
//        // Scroll to Real Array Position
//        setSelectedOpion(selectedIndexPath)
//        
//        // The currently selected item was the last selected item
//        if let lastSelected = LastSelected.indexPath {
//            if (lastSelected == selectedIndexPath) {
//                selectOptionViewCell(selectedIndexPath, isSelected: true)
//            }
//        }
//        LastSelected.indexPath = selectedIndexPath
//        print("Did select item \(workoutOptionData[selectedIndexPath.item].optionName) scrolling to index \(selectedIndexPath.item)")
//        collectionView.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: collectionView: shouldDeselectItemAtIndexPath
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("Collection View Should De-Select Item At Index Path \(indexPath.item)")
        
        return true
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: add array ele
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func fooArrayOp(itemsPerPage:Int) {
        let beginIndex: Int = workoutOptionData.count - itemsPerPage
        let endIndex  : Int = workoutOptionData.count - 1

        let fooArray: [WorkoutOptionData] = Array(self.workoutOptionData[0...itemsPerPage])
        let tmpArray: [WorkoutOptionData] = Array(self.workoutOptionData[beginIndex...endIndex])
        
        self.workoutOptionData.insertContentsOf(tmpArray, at: 0)
        self.workoutOptionData.appendContentsOf(fooArray)
        
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection View Did De-Select Item At Index Path \(indexPath.item)")
    }
    
    func translateToRealIndex(indexPath: NSIndexPath) ->NSIndexPath {
//        let ITEM_WIDTH:            Int         = 100
//        let FAKE_PAGE_OFFSET:      CGFloat     = 400.00
//        let REAL_ARRAY_ITEM_COUNT: Int         = workoutOptionData.count - 8
//        let REAL_SIZE:             CGFloat     = (CGFloat)(REAL_ARRAY_ITEM_COUNT * ITEM_WIDTH)
//        let END_OF_REAL_ARRAY:     CGFloat     = REAL_SIZE + FAKE_PAGE_OFFSET
        let selectedIndexPath:     NSIndexPath = indexPath
//        
//        if let collectionView = self.collectionView {
//            let contentOffsetX: CGFloat = collectionView.contentOffset.x
//            
//            // Leading Fake Page Selection
//            if (indexPath.item < 4) {
//                print("The selection is in the leading fake page")
//                //traslate to real array
//                collectionView.setContentOffset(CGPointMake(contentOffsetX + REAL_SIZE, collectionView.contentOffset.y), animated: false)
//                selectedIndexPath = NSIndexPath(forItem: (REAL_ARRAY_ITEM_COUNT + indexPath.item), inSection: 0)
//            }
//            // Trailing Fake Page Selection
//            if (indexPath.item >= REAL_ARRAY_ITEM_COUNT + 4) {
//                print("The selection is in the trailing fake page")
//                // translate to real array
//                let trailingOffsetX = contentOffsetX - END_OF_REAL_ARRAY
//                collectionView.setContentOffset(CGPointMake(trailingOffsetX + FAKE_PAGE_OFFSET, collectionView.contentOffset.y), animated: false)
//                selectedIndexPath = NSIndexPath(forItem: (indexPath.item - REAL_ARRAY_ITEM_COUNT), inSection: 0)
//            }
//            
//        }
//        
        return selectedIndexPath
    }
    
    // MARK: UICollectionView - Scroll Animation
    /*************************************************************************************************************************************
    *
    * Function: collectionView: scrollAnimation
    *
    **************************************************************************************************************************************/
    func scrollAnimation(paramTimer: NSTimer) {
//        
//        if(elapsedTime < 30) {
//            ++elapsedTime
//            let collectionView = self.collectionView!
//            collectionView.setContentOffset(CGPointMake(collectionView.contentOffset.x + 1000.0, collectionView.contentOffset.y), animated: true)
//            //collectionView.contentOffset.x += 1000.0
//        }
//        else {
//            stopScrollAnimation()
//        }
        
    }
    
    /*************************************************************************************************************************************
     *
     * Function: startScrollAnimation
     *
     **************************************************************************************************************************************/
    func startScrollAnimation() {
//        print("Start Scroll Animation")
//        
//        
//        if let currentlySelectedItem = self.selectedItem {
//            selectOptionViewCell(currentlySelectedItem, isSelected: false)
//            self.selectedItem = nil
//        }
//        
//        //self.scrollAnimationTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "scrollAnimation:", userInfo: nil, repeats: true)
//        self.scrollAnimationTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "newScroll:", userInfo: nil, repeats: true)
    }
    
    /*************************************************************************************************************************************
     *
     * Function: collectionView: stopScrollAnimation
     *
     **************************************************************************************************************************************/
    func stopScrollAnimation() {
//        if let timer = scrollAnimationTimer {
//            print("Stop Scroll Animation")
//            self.selectedItem = self.getRandomIndex()
//            if let idx = self.selectedItem {
//                self.collectionView!.scrollToItemAtIndexPath(idx, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
//            }
//            timer.invalidate()
//            elapsedTime = 0
//            scrollAnimationTimer = nil
//        }
    }
    
    /*************************************************************************************************************************************
     *
     * Function: getRandomIndex
     *
     **************************************************************************************************************************************/
    func getRandomIndex() -> NSIndexPath {
        let REAL_ARRAY_ITEM_COUNT = workoutOptionData.count - 8
        let randomItem = Int(arc4random_uniform(UInt32(REAL_ARRAY_ITEM_COUNT))) + 4
        print("random Item \(randomItem)")
        return NSIndexPath(forItem: randomItem, inSection: 0)
    }
    
    /*************************************************************************************************************************************
     *
     * Function: setSelectedOpion
     *
     **************************************************************************************************************************************/
    func setSelectedOpion(selectedItem: NSIndexPath?) {
//        self.selectedItem = selectedItem
//        
//        // Signal Observer
//        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: self)
    }
    
    /*************************************************************************************************************************************
     *
     * Function: selectOptionViewCell
     *
     **************************************************************************************************************************************/
    func selectOptionViewCell(indexPath: NSIndexPath, isSelected: Bool) {
//        print("Select/Deselect the Option View Cell")
//        // Get the Cell
//        if let cell: WorkoutOptionCell = self.collectionView?.cellForItemAtIndexPath(indexPath) as? WorkoutOptionCell {
//            // Select the Cell
//            if (isSelected == true) {
//                print("Select option View Cell: \(indexPath.item)")
//                cell.select()
//            }
//                // Deselect the Cell
//            else {
//                print("Deselect option View Cell: \(indexPath.item)")
//                cell.deselect()
//            }
//        }
    }
    
    func newScroll() {
        //print("New Scroll")
        //        if(elapsedTime < 30) {
        //            ++elapsedTime
        //            let collectionView = self.collectionView!
        //            collectionView.setContentOffset(CGPointMake(collectionView.contentOffset.x + 1000.0, collectionView.contentOffset.y), animated: true)
        //            //collectionView.contentOffset.x += 1000.0
        //        }
        //        else {
        //            stopScrollAnimation()
        //        }
    }
}
