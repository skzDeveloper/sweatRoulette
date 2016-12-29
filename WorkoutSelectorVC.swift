//
//  WorkoutSelectorVC.swift
//  SelectorView
//
//  Created by Saad Omar on 5/17/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

@objc
protocol WorkoutSelectorVCDelegate {
    optional func toggleLeftPanel()
}

class WorkoutSelectorVC: UIViewController {
    
    var button: UIButton!
    var delegate: WorkoutSelectorVCDelegate?
    var request : WorkoutRequestVC?
    
    var muscleOptionControler: WorkoutOptionVC!
    var styleOptionControler:  WorkoutOptionVC!
    var levelOptionController: WorkoutOptionVC!
    
    let muscleGroupOptions: [WorkoutOptionData]  = [
        WorkoutOptionData(label: "Quads"       , param: "quads"),
        WorkoutOptionData(label: "Shoulders"   , param: "shoulders"),
        WorkoutOptionData(label: "Traps"       , param: "traps"),
        WorkoutOptionData(label: "Triceps"     , param: "triceps"),
        WorkoutOptionData(label: "Abs"         , param: "abs"),
        WorkoutOptionData(label: "Back"        , param: "back"),
        WorkoutOptionData(label: "Biceps"      , param: "biceps"),
        WorkoutOptionData(label: "Calves"      , param: "calves"),
        WorkoutOptionData(label: "Chest"       , param: "chest"),
        WorkoutOptionData(label: "Forearms"    , param: "forearms"),
        WorkoutOptionData(label: "Glutes"      , param: "glutes"),
        WorkoutOptionData(label: "Hamstrings"  , param: "hamstrings"),
        WorkoutOptionData(label: "Lats"        , param: "lats"),
        WorkoutOptionData(label: "Quads"       , param: "quads"),
        WorkoutOptionData(label: "Shoulders"   , param: "shoulders"),
        WorkoutOptionData(label: "Traps"       , param: "traps"),
        WorkoutOptionData(label: "Triceps"     , param: "triceps"),
        WorkoutOptionData(label: "Abs"         , param: "abs"),
        WorkoutOptionData(label: "Back"        , param: "back"),
        WorkoutOptionData(label: "Biceps"      , param: "biceps"),
        WorkoutOptionData(label: "Calves"      , param: "calves")]
    
    let workoutStyleOptions: [WorkoutOptionData] = [
        WorkoutOptionData(label: "Olympic"     , param: "olympic"),
        WorkoutOptionData(label: "Polymetrics" , param: "polymetrics"),
        WorkoutOptionData(label: "Strength"    , param: "strength"),
        WorkoutOptionData(label: "Stretching"  , param: "streching"),
        WorkoutOptionData(label: "BodyOnly"    , param: "body_only"),
        WorkoutOptionData(label: "CrossFit"    , param: "crossfit"),
        WorkoutOptionData(label: "Olympic"     , param: "olympic"),
        WorkoutOptionData(label: "Polymetrics" , param: "polymetrics"),
        WorkoutOptionData(label: "Strength"    , param: "strength"),
        WorkoutOptionData(label: "Stretching"  , param: "streching"),
        WorkoutOptionData(label: "BodyOnly"    , param: "body_only"),
        WorkoutOptionData(label: "CrossFit"    , param: "crossfit"),
        WorkoutOptionData(label: "Olympic"     , param: "olympic"),
        WorkoutOptionData(label: "Polymetrics" , param: "polymetrics")]
    
    let difficultyOptions: [WorkoutOptionData]   = [
        WorkoutOptionData(label: "Beginner"    , param: "beginner"),
        WorkoutOptionData(label: "Intermediate", param: "intermediate"),
        WorkoutOptionData(label: "Advanced"    , param: "advanced"),
        WorkoutOptionData(label: "Expert"      , param: "expert"),
        WorkoutOptionData(label: "Beginner"    , param: "beginner"),
        WorkoutOptionData(label: "Intermediate", param: "intermediate"),
        WorkoutOptionData(label: "Advanced"    , param: "advanced"),
        WorkoutOptionData(label: "Expert"      , param: "expert"),
        WorkoutOptionData(label: "Beginner"    , param: "beginner"),
        WorkoutOptionData(label: "Intermediate", param: "intermediate"),
        WorkoutOptionData(label: "Advanced"    , param: "advanced"),
        WorkoutOptionData(label: "Expert"      , param: "expert")]
    
    // MARK: - UI Configuration
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: loadView                                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        
        // Configure the Navigation Bar
        edgesForExtendedLayout = UIRectEdge.None
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.0, green: 0.20, blue: 0.20, alpha: 1.0)
        //print("The navigation bar height is \(self.navigationController?.navigationBar.bounds.height)")
        
        // Set the Logo on the navigation bar
        let image = UIImage(named: "SweatRouletteLogo")
        let LOGO_HEIGHT = (self.navigationController?.navigationBar.bounds.height)! * 0.90
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: LOGO_HEIGHT))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        navigationItem.titleView = imageView
        
        // Set Hamburger Icon Button on Right Navigation Bar
        let hamburgerButton: UIButton = UIButton()
        hamburgerButton.setImage(UIImage(named: "HamburgerIcon"), forState: .Normal)
        hamburgerButton.frame = CGRectMake(0, 0, 20, 20)
        hamburgerButton.addTarget(self, action: "slideNavigation:", forControlEvents: .TouchDown)
        let leftItem:UIBarButtonItem = UIBarButtonItem()
        leftItem.customView = hamburgerButton
        self.navigationItem.leftBarButtonItem = leftItem
        
        // Set Button Settings
        button = UIButton(type: .System)
        button.setTitle("SPIN", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchDown)
        
        muscleOptionControler = WorkoutOptionVC(titleText: "Muscle Group" , options: muscleGroupOptions)
        styleOptionControler  = WorkoutOptionVC(titleText: "Workout Style", options: workoutStyleOptions)
        levelOptionController = WorkoutOptionVC(titleText: "Difficulty"   , options: difficultyOptions)
        
        self.addChildViewController(muscleOptionControler)
        self.addChildViewController(styleOptionControler)
        self.addChildViewController(levelOptionController)
        
        // Add the Subviews to the Parent View
        self.view.addSubview(button)
        self.view.addSubview(muscleOptionControler.view)
        self.view.addSubview(styleOptionControler.view)
        self.view.addSubview(levelOptionController.view)
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let d = ["b":button, "m":muscleOptionControler.view, "s":styleOptionControler.view, "l":levelOptionController.view,"foo":view]
        
        // Set Auto Resizing Masks
        button.translatesAutoresizingMaskIntoConstraints                     = false
        muscleOptionControler.view.translatesAutoresizingMaskIntoConstraints = false
        styleOptionControler.view.translatesAutoresizingMaskIntoConstraints  = false
        levelOptionController.view.translatesAutoresizingMaskIntoConstraints = false

        // Add Vertical Constraints
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[m][s][l][b]|",options: NSLayoutFormatOptions.DirectionLeftToRight,metrics: nil, views: d))
        
        // Add Horizontal Constraints
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[b]|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[m]|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[s]|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[l]|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillLayoutSubviews                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillLayoutSubviews() {
        let VIEW_HEIGHT  : CGFloat = view.bounds.height
        let BUTTON_HEIGHT: CGFloat = VIEW_HEIGHT * 0.12
        let OPTION_HEIGHT: CGFloat = (VIEW_HEIGHT - BUTTON_HEIGHT) / 3
    
        //print("view height: \(VIEW_HEIGHT)  option height:\(OPTION_HEIGHT) button height: \(BUTTON_HEIGHT)")
    
    
        let d = ["b":button, "mo":muscleOptionControler.view, "so":styleOptionControler.view, "lo":levelOptionController.view,"foo":view]
        let m = ["bh": BUTTON_HEIGHT, "oh": OPTION_HEIGHT]
    
        // Set Button Constraints
        button.translatesAutoresizingMaskIntoConstraints                     = false
        muscleOptionControler.view.translatesAutoresizingMaskIntoConstraints = false
        styleOptionControler.view.translatesAutoresizingMaskIntoConstraints  = false
        levelOptionController.view.translatesAutoresizingMaskIntoConstraints = false
    
        // Set the heights of the button and the three Workout Option Views
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[b(==bh)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[mo(==oh)]", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[so(==oh)]", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lo(==oh)]", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: buttonPressed                                                                                                        //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func buttonPressed(sender: UIButton) {
        //print("request button pressed")
        self.navigationController?.pushViewController(request!, animated: true)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: slideNavigation                                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        //print("Slide Navigation Time")
        //delegate?.toggleLeftPanel?()
        if (delegate != nil) {
            delegate?.toggleLeftPanel!()
        }
        else {
            //print("delegate is nil")
        }
    }
}
