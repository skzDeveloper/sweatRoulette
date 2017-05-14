/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  WorkoutSelectorVC.swift                                                                                                    //
//  SelectorView                                                                                                     var       //
//                                                                                                                             //
//  Created by Saad Omar on 5/17/16.                                                                                           //
//  Copyright © 2016 Saad Omar. All rights reserved.                                                                           //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import UIKit

@objc
protocol WorkoutSelectorVCDelegate {
    optional func toggleLeftPanel()
}

class WorkoutSelectorVC: UIViewController {
    
    var button: UIButton!
    
    var muscleGroupSelection: NSIndexPath? = nil
    var styleSelection      : NSIndexPath? = nil
    var difficultySelection : NSIndexPath? = nil
    
    var delegate: WorkoutSelectorVCDelegate?
    var request : WorkoutRequestVC?
    
    var muscleOptionControler: WorkoutOptionVC!
    var styleOptionControler:  WorkoutOptionVC!
    var levelOptionController: WorkoutOptionVC!
    
    var muscleGroupOptions: [WorkoutOptionData]  = [
        WorkoutOptionData(label: "Quads"       , param: "quads",       selected:false),
        WorkoutOptionData(label: "Shoulders"   , param: "shoulders",   selected:false),
        WorkoutOptionData(label: "Traps"       , param: "traps",       selected:false),
        WorkoutOptionData(label: "Triceps"     , param: "triceps",     selected:false),
        WorkoutOptionData(label: "Abs"         , param: "abs",         selected:false),
        WorkoutOptionData(label: "Back"        , param: "back",        selected:false),
        WorkoutOptionData(label: "Biceps"      , param: "biceps",      selected:false),
        WorkoutOptionData(label: "Calves"      , param: "calves",      selected:false),
        WorkoutOptionData(label: "Chest"       , param: "chest",       selected:false),
        WorkoutOptionData(label: "Forearms"    , param: "forearms",    selected:false),
        WorkoutOptionData(label: "Glutes"      , param: "glutes",      selected:false),
        WorkoutOptionData(label: "Hamstrings"  , param: "hamstrings",  selected:false),
        WorkoutOptionData(label: "Lats"        , param: "lats",        selected:false),
        WorkoutOptionData(label: "Quads"       , param: "quads",       selected:false),
        WorkoutOptionData(label: "Shoulders"   , param: "shoulders",   selected:false),
        WorkoutOptionData(label: "Traps"       , param: "traps",       selected:false),
        WorkoutOptionData(label: "Triceps"     , param: "triceps",     selected:false),
        WorkoutOptionData(label: "Abs"         , param: "abs",         selected:false),
        WorkoutOptionData(label: "Back"        , param: "back",        selected:false),
        WorkoutOptionData(label: "Biceps"      , param: "biceps",      selected:false),
        WorkoutOptionData(label: "Calves"      , param: "calves",      selected:false)]
    
    var workoutStyleOptions: [WorkoutOptionData] = [
        WorkoutOptionData(label: "Olympic"     , param: "olympic",     selected:false),
        WorkoutOptionData(label: "Polymetrics" , param: "polymetrics", selected:false),
        WorkoutOptionData(label: "Strength"    , param: "strength",    selected:false),
        WorkoutOptionData(label: "Stretching"  , param: "streching",   selected:false),
        WorkoutOptionData(label: "BodyOnly"    , param: "body_only",   selected:false),
        WorkoutOptionData(label: "CrossFit"    , param: "crossfit",    selected:false),
        WorkoutOptionData(label: "Olympic"     , param: "olympic",     selected:false),
        WorkoutOptionData(label: "Polymetrics" , param: "polymetrics", selected:false),
        WorkoutOptionData(label: "Strength"    , param: "strength",    selected:false),
        WorkoutOptionData(label: "Stretching"  , param: "streching",   selected:false),
        WorkoutOptionData(label: "BodyOnly"    , param: "body_only",   selected:false),
        WorkoutOptionData(label: "CrossFit"    , param: "crossfit",    selected:false),
        WorkoutOptionData(label: "Olympic"     , param: "olympic",     selected:false),
        WorkoutOptionData(label: "Polymetrics" , param: "polymetrics", selected:false)]
    
    var difficultyOptions: [WorkoutOptionData]   = [
        WorkoutOptionData(label: "Beginner"    , param: "beginner",    selected:false),
        WorkoutOptionData(label: "Intermediate", param: "intermediate",selected:false),
        WorkoutOptionData(label: "Advanced"    , param: "advanced",    selected:false),
        WorkoutOptionData(label: "Expert"      , param: "expert",      selected:false),
        WorkoutOptionData(label: "Beginner"    , param: "beginner",    selected:false),
        WorkoutOptionData(label: "Intermediate", param: "intermediate",selected:false),
        WorkoutOptionData(label: "Advanced"    , param: "advanced",    selected:false),
        WorkoutOptionData(label: "Expert"      , param: "expert",      selected:false),
        WorkoutOptionData(label: "Beginner"    , param: "beginner",    selected:false),
        WorkoutOptionData(label: "Intermediate", param: "intermediate",selected:false),
        WorkoutOptionData(label: "Advanced"    , param: "advanced",    selected:false),
        WorkoutOptionData(label: "Expert"      , param: "expert",      selected:false)]
    
    // MARK: - UIViewController Overrides
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: loadView                                                                                                    //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: viewDidLoad                                                                                                 //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let d = ["b":button,
                 "m":muscleOptionControler.view,
                 "s":styleOptionControler.view,
                 "l":levelOptionController.view,
                 "foo":view]
        
        // Set Auto Resizing Masks
        button.translatesAutoresizingMaskIntoConstraints                     = false
        muscleOptionControler.view.translatesAutoresizingMaskIntoConstraints = false
        styleOptionControler.view.translatesAutoresizingMaskIntoConstraints  = false
        levelOptionController.view.translatesAutoresizingMaskIntoConstraints = false

        // Add Vertical Constraints
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[m][s][l][b]|",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: d))
        
        // Add Horizontal Constraints
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[b]|" ,
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[m]|",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[s]|",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[l]|",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: nil,
            views: d))
    
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshMuscleOption:",
            name:"refresh",
            object: self.muscleOptionControler.collectionOption)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshStyleOption:",
            name:"refresh",
            object: self.styleOptionControler.collectionOption)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshDifficultyOption:",
            name:"refresh",
            object: self.levelOptionController.collectionOption)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: : viewWillLayoutSubviews                                                                                    //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillLayoutSubviews() {
        let VIEW_HEIGHT  : CGFloat = view.bounds.height
        let BUTTON_HEIGHT: CGFloat = VIEW_HEIGHT * 0.12
        let OPTION_HEIGHT: CGFloat = (VIEW_HEIGHT - BUTTON_HEIGHT) / 3
    
        //print("view height: \(VIEW_HEIGHT)  option height:\(OPTION_HEIGHT) button height: \(BUTTON_HEIGHT)")
    
    
        let d = ["b":button,
                 "mo":muscleOptionControler.view,
                 "so":styleOptionControler.view,
                 "lo":levelOptionController.view,"foo":view]
        
        let m = ["bh": BUTTON_HEIGHT,
                 "oh": OPTION_HEIGHT]
    
        // Set Button Constraints
        button.translatesAutoresizingMaskIntoConstraints                     = false
        muscleOptionControler.view.translatesAutoresizingMaskIntoConstraints = false
        styleOptionControler.view.translatesAutoresizingMaskIntoConstraints  = false
        levelOptionController.view.translatesAutoresizingMaskIntoConstraints = false
    
        // Set the heights of the button and the three Workout Option Views
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[b(==bh)]" ,
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: m,
            views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[mo(==oh)]",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: m,
            views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[so(==oh)]",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: m,
            views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[lo(==oh)]",
            options: NSLayoutFormatOptions.DirectionLeftToRight,
            metrics: m,
            views: d))
    }
    
    // MARK: - WorkoutSelectorVC Logic
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: buttonPressed                                                                            //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func buttonPressed(sender: UIButton) {
    
        // Not all Options are selected
        if sender.titleForState(.Normal) == "SPIN"
        {
            // Need to do the spin animation here
            // spinOptions()
        }
        // Get Workout
        else
        {
            self.navigationController?.pushViewController(request!, animated: true)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: refreshMuscleOption                                                                      //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func refreshMuscleOption(notification: NSNotification){
        
        print("Muscle Observer Notified")
        self.muscleGroupSelection = self.muscleOptionControler.collectionOption.getSelectedIndexPath()
        
        refreshButton()
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: refreshStyleOption                                                                       //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func refreshStyleOption(notification: NSNotification) {
        
        print("Style Observer Notified")
        self.styleSelection = self.styleOptionControler.collectionOption.getSelectedIndexPath()

        refreshButton()
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: refreshStyleOption(notification                                                          //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func refreshDifficultyOption(notification: NSNotification){
        
        print("Difficlty Observer Notified")
        self.difficultySelection = self.levelOptionController.collectionOption.getSelectedIndexPath()
        
        refreshButton()
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: refreshButton                                                                            //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func refreshButton() -> Void {
        // All options are selected
        if muscleGroupSelection != nil && styleSelection != nil  && difficultySelection != nil {
            let sectionTitle  : String = self.getSectionString()
            let requestString : String = self.getRequestString()
            
            self.request!.cache.setRequestString(sectionTitle, request: requestString)
            button.setTitle("GET WORKOUT", forState: .Normal)
        }
        else {
            button.setTitle("SPIN", forState: .Normal)
        }
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: getRequestString                                                                         //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRequestString() -> String
    {
        let request: String =
            "http://ec2-34-208-245-186.us-west-2.compute.amazonaws.com:8080/SweatRoulette/resources/WorkoutResult?" +
                "bodyPart=\(muscleGroupOptions[muscleGroupSelection!.item].paramName)&"  +
                "style=\(workoutStyleOptions[styleSelection!.item].paramName)&"    +
                "intensity=\(difficultyOptions[difficultySelection!.item].paramName)"
        
        return request
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: WorkoutSelectorVC: getSectionString                                                                         //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getSectionString() -> String
    {
        let sectionString: String = muscleGroupOptions[muscleGroupSelection!.item].labelName
        
        return sectionString
        
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: slideNavigation                                                                                             //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        if (delegate != nil) {
            delegate?.toggleLeftPanel!()
        }
    }
}
