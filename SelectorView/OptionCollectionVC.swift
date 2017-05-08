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
    var selectedItem     : NSIndexPath!
    
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
        cell?.optionText.text     = workoutOptionData[indexPath.item].labelName
        cell?.iconImage.image     = UIImage(named: workoutOptionData[indexPath.item].labelName)
        cell?.selectedView.hidden = true
        cell?.checkImage.hidden   = true
        
        return cell!
    }
    
    // MARK: UIScrollViewDelegate
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
    // Function: scrollViewDidScroll
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        //print("scroll View Did Scroll to content offsetx \(scrollView.contentOffset.x)")
        let flowLayout: UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let SCROLL_CONTENT_WIDTH = self.collectionView!.contentSize.width
        let SCROLL_PAGE_WIDTH    = self.collectionView!.bounds.width
        let ITEM_SPACING         = (SCROLL_PAGE_WIDTH * 0.1) / 4
        let ITEM_WIDTH           = flowLayout.itemSize.width
        let ITEM_OFFSET          = ITEM_WIDTH + ITEM_SPACING

        
        //print("Scroll Content Width \(SCROLL_CONTENT_WIDTH)")
        //print("Scroll Page Width \(SCROLL_PAGE_WIDTH)")
        //print("Item Width \(ITEM_WIDTH)")
        
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
        
        let collectionView = scrollView as! UICollectionView
        
        //Get the visible Index Paths
        if var idxArray : [NSIndexPath] = collectionView.indexPathsForVisibleItems() {
            // Put the Index Paths in order
            idxArray.sortInPlace( {$0.item < $1.item } )
            // Select the middle Index Path
            let i:Int = idxArray.count/2
            let selectedIndexPath:NSIndexPath = idxArray[i]
        
            collectionView.selectItemAtIndexPath(selectedIndexPath,
                animated       : true,
                scrollPosition : UICollectionViewScrollPosition.CenteredHorizontally)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollView: WillBeginDragging
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("scroll View Will Begin Dragging")
        
        let collectionView = scrollView as! UICollectionView
        
        if let selectedIndex: NSIndexPath = self.getSelectedIndexPath() {
            self.deselectItem(collectionView, indexPath: selectedIndex)
        }
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: scrollView: DidEndScrollingAnimation
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("Scroll View Did End Scrolling Animation")
        let collectionView = scrollView as! UICollectionView
        
        if let selectedIndex: NSIndexPath = self.getSelectedIndexPath() {
            self.selectItem(collectionView, indexPath: selectedIndex)
        }
    }
    
    // MARK: UICollectionViewDelegate
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: collectionView: didSelectItemAtIndexPath
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection View Did Select Item at Index Path \(indexPath.item)")
        
        collectionView.selectItemAtIndexPath(indexPath,
            animated       : true,
            scrollPosition : UICollectionViewScrollPosition.CenteredHorizontally)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: collectionView: didDeselectItemAtIndexPath
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("Collection View Did De-Select Item At Index Path \(indexPath.item)")
        
        self.deselectItem(collectionView, indexPath: indexPath)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: OptionCollectionVC: selectItem
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        var shouldSelect = true
        
        //Get the current selection
        if let currentSelection: NSIndexPath = self.getSelectedIndexPath() {
            //The Selected Item is already selected
            if currentSelection.item == indexPath.item {
                shouldSelect = false
                self.deselectItem(collectionView, indexPath: indexPath)
            }
        }
        
        return shouldSelect
    }

    // MARK: OptionCollectionVC - Logic
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: OptionCollectionVC: getSelectedItem
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getSelectedIndexPath() -> NSIndexPath?
    {
        var selectedIndexPath: NSIndexPath? = nil
        //Get any selected Index Paths
        if self.collectionView!.indexPathsForSelectedItems() != nil {
            //DEBUG
            if (collectionView!.indexPathsForSelectedItems()!.count > 1) {
                print("ERROR: There should only be one selected item at a time")
            }
            
            selectedIndexPath = collectionView!.indexPathsForSelectedItems()!.first
        }
        return selectedIndexPath
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: OptionCollectionVC: selectItem
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func selectItem(collectionView: UICollectionView, indexPath: NSIndexPath) -> Void {
        
            
        //Highlight the cell
        if let cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) {
            let workoutOptionCell: WorkoutOptionCell = cell as! WorkoutOptionCell
            workoutOptionCell.select()
            NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: self)
        }

        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: OptionCollectionVC: deselectItem
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func deselectItem(collectionView: UICollectionView, indexPath: NSIndexPath) -> Void {
        if collectionView.indexPathsForSelectedItems() != nil {
            //DEBUG
            if (collectionView.indexPathsForSelectedItems()!.count > 1) {
                print("ERROR: There should only be one selected item at a time")
            }
            //Un-Highlight the cell
            if let cell: UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) {
                let workoutOptionCell: WorkoutOptionCell = cell as! WorkoutOptionCell
                workoutOptionCell.deselect()
            }
            
            collectionView.deselectItemAtIndexPath(indexPath, animated: false)
            NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: self)
        }
    }
    
    // MARK: MISC Functions
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Function: add array ele
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func fooArrayOp(itemsPerPage:Int) {
        //let beginIndex: Int = workoutOptionData.count - itemsPerPage
        //let endIndex  : Int = workoutOptionData.count - 1
        
        //let fooArray: [WorkoutOptionData] = Array(self.workoutOptionData[0...itemsPerPage])
        //let tmpArray: [WorkoutOptionData] = Array(self.workoutOptionData[beginIndex...endIndex])
        
        //self.workoutOptionData.insertContentsOf(tmpArray, at: 0)
        //self.workoutOptionData.appendContentsOf(fooArray)
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
