//
//  WorkoutTableVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/2/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableVC: UITableViewController, UIGestureRecognizerDelegate {
    
    var delegate : WorkoutSelectorVCDelegate?
    var request  : WorkoutRequestVC!
    var workout  : Workout = Workout()
    
    var swipe: UISwipeGestureRecognizer!
    
    let cellID:          String = "ExerciseCell"
    let routineHeaderID: String = "RoutineHeaderCell"
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override init(style: UITableViewStyle) {
        //Call UIViewControllers designated class
        super.init(style: style)
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - UI Configuration
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Logo
        let image = UIImage(named: "SweatRouletteLogo")
        let LOGO_HEIGHT = (self.navigationController?.navigationBar.bounds.height)! * 0.90
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: LOGO_HEIGHT))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        navigationItem.titleView = imageView
        
        // Navigation Bar Hamburger Icon
        let hamburgerButton: UIButton = UIButton()
        hamburgerButton.setImage(UIImage(named: "HamburgerIcon"), forState: .Normal)
        hamburgerButton.frame = CGRectMake(0, 0, 20, 20)
        hamburgerButton.addTarget(self, action: "slideNavigation:", forControlEvents: .TouchDown)
        let leftItem:UIBarButtonItem = UIBarButtonItem()
        leftItem.customView = hamburgerButton
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsSelectionDuringEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true

        self.view.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins  = UIEdgeInsetsZero
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Register Routine Header and Exercise Cells
        tableView.registerClass(RoutineHeaderCell.self, forCellReuseIdentifier: routineHeaderID)
        
        tableView.separatorStyle = .SingleLine
        tableView.registerNib(UINib(nibName: "ExerciseCell", bundle: nil), forCellReuseIdentifier: "ExerciseCell")

        // Set the Workout Table Header
        let hv     : UIView  = UIView (frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        let hLabel : UILabel = UILabel(frame: CGRectInset(hv.bounds, 5, 5))

        hLabel.text          = workout.title
        hLabel.textAlignment = .Center
        hLabel.textColor     = UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0)
        hv.addSubview(hLabel)
        self.tableView.tableHeaderView = hv
        
        
        // Setup the Table View Footer
        let screenSize  : CGRect  = UIScreen.mainScreen().bounds
        let headerWidth : CGFloat = screenSize.width
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: headerWidth, height: 40))
        //self.tableView.tableFooterView?.backgroundColor = UIColor.yellowColor()
        
        let deleteImage  = UIImage(named: "Delete_Box")
        let deleteButton = UIButton()
        //deleteButton.backgroundColor = UIColor.purpleColor()
        deleteButton.setImage(deleteImage, forState: .Normal)
        deleteButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 16.0, right: 8.0)
        deleteButton.addTarget(self, action: "deleteButtonHandler:", forControlEvents: .TouchDown)
        
        let shareImage  = UIImage(named: "Share_Post")
        let shareButton = UIButton()
        //shareButton.backgroundColor = UIColor.brownColor()
        shareButton.setImage(shareImage, forState: .Normal)
        shareButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 16.0, right: 8.0)
        shareButton.addTarget(self, action: "shareButtonHandler:", forControlEvents: .TouchDown)
        
        let archiveImage  = UIImage(named: "Heart_Archives")
        let archiveButton = UIButton()
        //archiveButton.backgroundColor = UIColor.blueColor()
        archiveButton.setImage(archiveImage, forState: .Normal)
        archiveButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 16.0, right: 8.0)
        archiveButton.addTarget(self, action: "archiveButtonHandler:", forControlEvents: .TouchDown)
        
        let addImage  = UIImage(named: "Add_Workout")
        let addButton = UIButton()
        //addButton.backgroundColor = UIColor.redColor()
        addButton.setImage(addImage, forState: .Normal)
        addButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 16.0, right: 12.0)
        addButton.addTarget(self, action: "addButtonHandler:", forControlEvents: .TouchDown)
        
        self.tableView.tableFooterView?.addSubview(deleteButton)
        self.tableView.tableFooterView?.addSubview(shareButton)
        self.tableView.tableFooterView?.addSubview(archiveButton)
        self.tableView.tableFooterView?.addSubview(addButton)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints  = false
        shareButton.translatesAutoresizingMaskIntoConstraints   = false
        archiveButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints     = false
        
        // Add Button Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : addButton,
            attribute  : .Width,
            relatedBy  : .Equal,
            toItem     : nil,
            attribute  : .NotAnAttribute,
            multiplier : 1,
            constant   : 44))
        
        // Add Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : addButton,
            attribute  : .Top,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Top,
            multiplier : 1,
            constant   : 0))
        
        // Add Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : addButton,
            attribute  : .Bottom,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Bottom,
            multiplier : 1,
            constant   : 0)) //-10
        
        // Add Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : addButton,
            attribute  : .Right,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Right,
            multiplier : 1,
            constant   : 0))
        
        // Archive Button Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : archiveButton,
            attribute  : .Width,
            relatedBy  : .Equal,
            toItem     : nil,
            attribute  : .NotAnAttribute,
            multiplier : 1,
            constant   : 40)) //constant   : 25))
        
        // Archive Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : archiveButton,
            attribute  : .Top,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Top,
            multiplier : 1,
            constant   : 0))
        
        // Archive Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : archiveButton,
            attribute  : .Bottom,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Bottom,
            multiplier : 1,
            constant   : 0))
        
        // Archive Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : archiveButton,
            attribute  : .Right,
            relatedBy  : .Equal,
            toItem     : addButton,
            attribute  : .Left,
            multiplier : 1,
            constant   : 0))
        
        // Share Button Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : shareButton,
            attribute  : .Width,
            relatedBy  : .Equal,
            toItem     : nil,
            attribute  : .NotAnAttribute,
            multiplier : 1,
            constant   : 40))
        
        // Share Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item: shareButton,
            attribute  : .Top,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Top,
            multiplier : 1,
            constant   : 0))
        
        // Share Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item: shareButton,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Bottom,
            multiplier : 1,
            constant   : 0)) //-10
        
        // Share Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item: shareButton,
            attribute  : .Right,
            relatedBy  : .Equal,
            toItem     : archiveButton,
            attribute  : .Left,
            multiplier : 1,
            constant   : 0))
        
        // Delete Button Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : deleteButton,
            attribute  : .Width,
            relatedBy  : .Equal,
            toItem     : nil,
            attribute  : .NotAnAttribute,
            multiplier : 1,
            constant   : 44))
        
        // Delete Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item       : deleteButton,
            attribute  : .Top,
            relatedBy  : .Equal,
            toItem     : tableView.tableFooterView,
            attribute  : .Top,
            multiplier : 1,
            constant   : 0))
        
        // Delete Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item: deleteButton,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: tableView.tableFooterView,
            attribute: .Bottom,
            multiplier: 1,
            constant:   0))
        
        // Delete Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(
            item: deleteButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: tableView.tableFooterView,
            attribute: .Left,
            multiplier: 1,
            constant: 0))
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .Left)
        {
            print("Swiped Left")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillAppear                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: numberOfSectionsInTableView                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return self.workout.routines.count
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: numberOfRowsInSection                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workout.routines[section].exercises.count
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: cellForRowAtIndexPath                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell     : ExerciseCell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! ExerciseCell
        let routine  : Routine      = self.workout.routines[indexPath.section]
        let exercise : Exercise     = routine.exercises[indexPath.row]
        
        cell.exNameLabel.text  = exercise.name
        cell.exerciseHyperlink = exercise.hyperlink
        cell.exSetsLabel.text  = exercise.sets
        cell.exRepsLabel.text  = exercise.reps
        cell.layoutMargins     = UIEdgeInsetsZero

        return cell
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewForHeaderInSection                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader: RoutineHeaderCell = tableView.dequeueReusableCellWithIdentifier(routineHeaderID) as! RoutineHeaderCell
        let routine      : Routine           = self.workout.routines[section]

        sectionHeader.sectionTitle.text = routine.sectionTitle + " Routines"
   
        return sectionHeader.contentView
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: heightForHeaderInSection                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: heightForRowAtIndexPath                                                                                              //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66.0
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: heightForFooterInSection                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: editActionsForRowAtIndexPath                                                                                //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            // Handle Deletion of Exercise
            self.workout.routines[indexPath.section].exercises.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
        
        let switchClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            // Handle Switching out an Exercise
            let routine : Routine = self.workout.routines[indexPath.section]
            self.request.switchExercise(routine.sectionTitle, indexPath: indexPath)
        }
        
        let addClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            // Handle Adding of an Exercise
            let routine : Routine     = self.workout.routines[indexPath.section]
            let path    : NSIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: indexPath.section)
            self.request.addExercise(routine.sectionTitle, indexPath: path)
        }
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: deleteClosure)
        deleteAction.backgroundColor = UIColor.redColor()
        
        let switchAction = UITableViewRowAction(style: .Default, title: "Switch", handler: switchClosure)
        switchAction.backgroundColor = UIColor.orangeColor()
        
        let addAction = UITableViewRowAction(style: .Default, title: "  Add  ", handler: addClosure)
        addAction.backgroundColor = UIColor.lightGrayColor()
        
        return [deleteAction, switchAction, addAction]
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: accessoryButtonTappedForRowWithIndexPath                                                                              //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let exercise: Exercise = self.workout.routines[indexPath.section].exercises[indexPath.row]
        
        if let requestUrl = NSURL(string: exercise.hyperlink) {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
        else {
            print("could not open the hyperlink")
        }
    }

    // MARK: - Table Footer Button Handlers
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: deleteButtonHandler                                                                                                   //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func deleteButtonHandler(sender: UIButton) {
        for  routine: Routine in self.workout.routines {
            routine.exercises.removeAll()
        }
        
        self.workout.routines.removeAll()
        
        self.tableView.reloadData()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: shareButtonHandler                                                                                                    //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func shareButtonHandler(sender: UIButton) {
        
        let activityViewController = UIActivityViewController(
            activityItems         : [UIActivityTypePostToFacebook, UIActivityTypeSaveToCameraRoll],
            applicationActivities : nil)
        
        navigationController?.presentViewController(activityViewController, animated: true) {
        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: archiveButtonHandler                                                                                                  //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func archiveButtonHandler(sender: UIButton) {
        let saveVC            = WorkoutSaveVC()
        saveVC.currentWorkout = self.workout
        
        self.definesPresentationContext                 = true
        self.providesPresentationContextTransitionStyle = true
        self.modalTransitionStyle                       = .CoverVertical
        
        // Configure Modal Settings
        saveVC.modalPresentationStyle = .OverCurrentContext
        saveVC.modalTransitionStyle   = .CoverVertical
        
        self.presentViewController(saveVC, animated: true, completion: nil)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: addButtonHandler                                                                                                      //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addButtonHandler(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: slideNavigation                                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        delegate?.toggleLeftPanel?()
    }
}
