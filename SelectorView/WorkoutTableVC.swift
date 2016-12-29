//
//  WorkoutTableVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/2/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class WorkoutTableVC: UITableViewController {
    
    var delegate: WorkoutSelectorVCDelegate?
    
    var workoutModel:Workout = Workout()
    
    let cellID:          String = "ExerciseCell"
    let routineHeaderID: String = "RoutineHeaderCell"

    // MARK: - UI Configuration
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the Logo on the navigation barb
        let image = UIImage(named: "SweatRouletteLogo")
        let LOGO_HEIGHT = (self.navigationController?.navigationBar.bounds.height)! * 0.90
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: LOGO_HEIGHT))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        navigationItem.titleView = imageView
        
        //Set Hamburger Icon Button on Right Navigation Bar
        let hamburgerButton: UIButton = UIButton()
        hamburgerButton.setImage(UIImage(named: "HamburgerIcon"), forState: .Normal)
        hamburgerButton.frame = CGRectMake(0, 0, 20, 20)
        hamburgerButton.addTarget(self, action: "slideNavigation:", forControlEvents: .TouchDown)
        let leftItem:UIBarButtonItem = UIBarButtonItem()
        leftItem.customView = hamburgerButton
        self.navigationItem.leftBarButtonItem = leftItem
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        //tableView.separatorColor = UIColor.blackColor()
        //tableView.separatorEffect = UIVisualEffect.
        //tableView.separatorInset = UIEdgeInsetsMake(15.0, 15.0, 15.0, 15.0)
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins  = UIEdgeInsetsZero
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Register Routine Header and Exercise Cells
        tableView.registerClass(RoutineHeaderCell.self, forCellReuseIdentifier: routineHeaderID)
        tableView.registerClass(ExerciseCell.self     , forCellReuseIdentifier: cellID)
        
        //Set up the Workout Data Model
        workoutModel.title = "Chest and Back Workout"
        
        var r1:Routine = Routine(routineForMuscle: "Chest")
        let ex1:Exercise = Exercise(exName: "Push-Ups"   , exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        let ex2:Exercise = Exercise(exName: "Pull-Ups"   , exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        let ex3:Exercise = Exercise(exName: "Bench Press", exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        let ex4:Exercise = Exercise(exName: "Flyes"      , exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        r1.exerciseList.append(ex1)
        r1.exerciseList.append(ex2)
        r1.exerciseList.append(ex3)
        r1.exerciseList.append(ex4)
        
        var r2:Routine = Routine(routineForMuscle: "Back")
        let ex5:Exercise = Exercise(exName: "Lat Pulldowns"   , exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        let ex6:Exercise = Exercise(exName: "Rows"   , exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        let ex7:Exercise = Exercise(exName: "Good Mornings", exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        let ex8:Exercise = Exercise(exName: "Flyes"      , exHyperlink: "Fake.com", exSets: "4", exReps: "12")
        r2.exerciseList.append(ex5)
        r2.exerciseList.append(ex6)
        r2.exerciseList.append(ex7)
        r2.exerciseList.append(ex8)
        
        workoutModel.routines.append(r1)
        workoutModel.routines.append(r2)
        
        // Set the Workout Table Header
        let hv: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 60))
        //hv.backgroundColor = UIColor.yellowColor()
        let hLabel: UILabel = UILabel(frame: CGRectInset(hv.bounds, 5, 5))
        //hLabel.backgroundColor = UIColor.whiteColor()
        hLabel.text = workoutModel.title
        hLabel.textAlignment = .Center
        hLabel.textColor = UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0)
        hv.addSubview(hLabel)
        self.tableView.tableHeaderView = hv
        
        
        // Setup the Table View Footer
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 25))
        
        let deleteImage  = UIImage(named: "Delete_Box")
        let deleteButton = UIButton()
        deleteButton.setBackgroundImage(deleteImage, forState: .Normal)
        deleteButton.addTarget(self, action: "deleteButtonHandler:", forControlEvents: .TouchDown)
        
        let shareImage  = UIImage(named: "Share_Post")
        let shareButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        shareButton.setBackgroundImage(shareImage, forState: .Normal)
        shareButton.addTarget(self, action: "shareButtonHandler:", forControlEvents: .TouchDown)
        
        let archiveImage  = UIImage(named: "Heart_Archives")
        let archiveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        archiveButton.setBackgroundImage(archiveImage, forState: .Normal)
        archiveButton.addTarget(self, action: "archiveButtonHandler:", forControlEvents: .TouchDown)
        
        let addImage  = UIImage(named: "Add_Workout")
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        addButton.setBackgroundImage(addImage, forState: .Normal)
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
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: addButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        // Add Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: addButton, attribute: .Top, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Top, multiplier: 1, constant: 0))
        // Add Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: addButton, attribute: .Bottom, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Bottom, multiplier: 1, constant: 0))
        // Add Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: addButton, attribute: .Right, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Right, multiplier: 1, constant: -10))
        
        // Archive Button Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: archiveButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        // Archive Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: archiveButton, attribute: .Top, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Top, multiplier: 1, constant: 0))
        // Archive Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: archiveButton, attribute: .Bottom, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Bottom, multiplier: 1, constant: 0))
        // Archive Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: archiveButton, attribute: .Right, relatedBy: .Equal, toItem: addButton, attribute: .Left, multiplier: 1, constant: -10))
        
        // Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: shareButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        // Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: shareButton, attribute: .Top, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Top, multiplier: 1, constant: 0))
        // Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: shareButton, attribute: .Bottom, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Bottom, multiplier: 1, constant: 0))
        // Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: shareButton, attribute: .Right, relatedBy: .Equal, toItem: archiveButton, attribute: .Left, multiplier: 1, constant: -10))
        
        // Width
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 25))
        // Button Top Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .Top, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Top, multiplier: 1, constant: 0))
        // Button Bottom Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .Bottom, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Bottom, multiplier: 1, constant: 0))
        // Button Right Constraint
        tableView.tableFooterView?.addConstraint(NSLayoutConstraint(item: deleteButton, attribute: .Left, relatedBy: .Equal, toItem: tableView.tableFooterView, attribute: .Left, multiplier: 1, constant: 10))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: slideNavigation                                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        delegate?.toggleLeftPanel?()
    }


    // MARK: - Table view data source
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: numberOfSectionsInTableView                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return workoutModel.routines.count
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: numberOfRowsInSection                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutModel.routines[section].exerciseList.count
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: cellForRowAtIndexPath                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ExerciseCell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! ExerciseCell
        
        cell.exNameLabel.text  = workoutModel.routines[indexPath.section].exerciseList[indexPath.row].name
        cell.exerciseHyperlink = workoutModel.routines[indexPath.section].exerciseList[indexPath.row].hyperlink
        cell.exSetsLabel.text  = "Sets: " + workoutModel.routines[indexPath.section].exerciseList[indexPath.row].sets
        cell.exRepsLabel.text  = "Reps: " + workoutModel.routines[indexPath.section].exerciseList[indexPath.row].reps
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
        
        sectionHeader.sectionTitle.text = workoutModel.routines[section].forMuscle + " Routines"
        
        return sectionHeader
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
        return 80.0
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: heightForFooterInSection                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    // MARK: - Table Footer Button Handlers
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: deleteButtonHandler                                                                                                   //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func deleteButtonHandler(sender: UIButton)
    {
//        for var section in theRealWorkout.routines {
//            section.exerciseList.removeAll()
//        }
//        
//        theRealWorkout.routines.removeAll()
//        
//        self.tableView.reloadData()
//        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: shareButtonHandler                                                                                                    //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func shareButtonHandler(sender: UIButton)
    {
        
//        let activityViewController = UIActivityViewController(activityItems: [UIActivityTypePostToFacebook, UIActivityTypeSaveToCameraRoll], applicationActivities: nil)
//        navigationController?.presentViewController(activityViewController, animated: true) {
//            
//        }
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                 //
    // Function: archiveButtonHandler                                                                                                  //
    //                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func archiveButtonHandler(sender: UIButton)
    {
        //print("Handle Archive")
        let saveVC = WorkoutSaveVC()
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        self.modalTransitionStyle = .CoverVertical
        
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
    func addButtonHandler(sender: UIButton)
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}




