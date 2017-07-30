//
//  WorkoutRequestVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/2/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class WorkoutRequestVC: UIViewController , NSXMLParserDelegate {
    
    var indicator       : UIActivityIndicatorView! = nil
    var workoutTable    : WorkoutTableVC?
    var workoutSelector : WorkoutSelectorVC?
    var delegate        : WorkoutSelectorVCDelegate?
    var cache           : ExerciseCache = ExerciseCache()
    var section         : String?
    var request         : String?

    // MARK: - UIViewController Overrides
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init() {
        //Call UIViewControllers designated class
        super.init(nibName: nil, bundle: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector : "addExercisesHandler:",
            name     : "addExercises",
            object   : self)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector : "switchExerciseHandler:",
            name     : "switchExericse",
            object   : self)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector : "addExerciseHandler:",
            name     : "addExericse",
            object   : self)
        
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
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillAppear                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // Set the Logo 
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "SweatRouletteLogo")
        imageView.image = image
        
        // Hide the Back Button
        self.navigationItem.hidesBackButton = true
        
        //Set Hamburger Icon Button on Right Navigation Bar
        let hamburgerButton: UIButton = UIButton()
        hamburgerButton.setImage(UIImage(named: "HamburgerIcon"), forState: .Normal)
        hamburgerButton.frame = CGRectMake(0, 0, 20, 20)
        hamburgerButton.addTarget(self, action: "slideNavigation:", forControlEvents: .TouchDown)
        let leftItem:UIBarButtonItem = UIBarButtonItem()
        leftItem.customView = hamburgerButton
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.leftBarButtonItem!.enabled = false
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        
        navigationItem.titleView = imageView
        indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        
        // Acitvity Indicator
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(
            item       : indicator,
            attribute  : .CenterX,
            relatedBy  : .Equal,
            toItem     : self.view,
            attribute  : .CenterX,
            multiplier : 1,
            constant   : 0))
        
        view.addConstraint(NSLayoutConstraint(
            item       : indicator,
            attribute  : .CenterY,
            relatedBy  : .Equal,
            toItem     : self.view,
            attribute  : .CenterY,
            multiplier : 1,
            constant   : 0))
        
        if self.request != nil && self.section != nil {
            //TODO: Need to get rid of setting cache string
            self.cache.setRequestString(self.section!, request: self.request!)
            addExercises(self.section!, request: self.request!)
        }
    }
    
    // MARK: - Data loading Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: loadData                                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func loadData(handlerString: String, info: [NSObject : AnyObject]?, request: String) {
        // Set the HTTP parameters
        //let requestString: String = workoutSelector!.getRequestString()
        let url = NSURL(string: request)
        let urlRequest = NSMutableURLRequest(URL: url!)
        urlRequest.HTTPMethod = "GET"
        urlRequest.setValue("application/xml ", forHTTPHeaderField: "Accept")
        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            
            if response != nil {
                let httpResponse  = response as! NSHTTPURLResponse
                print ("HTTP Status Code: \(httpResponse.statusCode)")
            }
            
            if let responseData: NSData = data {
                let parser = NSXMLParser(data: responseData)
                parser.delegate = self
                parser.parse()
            }
            else {
                print("There was no data returned from the session")
            }
            
            dispatch_async(dispatch_get_main_queue(), { [] in
                // Update the model
                print("About to post notification")
                NSNotificationCenter.defaultCenter().postNotificationName(handlerString, object: self, userInfo: info)
            })
            
        } // end completion block
        
        task.resume()
        print("Loading Data...")
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: parser                                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        var name      :String? = nil
        var hyperlink :String? = nil
        var sets      :String? = nil
        var reps      :String? = nil
        
        // Handle Workout Element
        if (elementName == "workout") {
            // Start a new set a Exercises
            //print("Workout Element")
        }
            
        else if (elementName == "status") {
            //Handle status
        }
            // Handle Exercise Element
        else if (elementName == "exercise") {
            // Create Exercise
            //print("Exercise Element")
            //loop through Attributes dictonary
            for (key, value) in attributeDict {
                //
                // Handle Name Attribute
                if (key == "name") {
                    name = value as String
                    //print("Exercise Name: \(name!)")
                }
                    // Handle Hyperlink Element
                else if (key == "hyperlink") {
                    hyperlink = value as String
                    //print("Exercise Hyperlink: \(hyperlink!)")
                }
                    // Handle Sets Attribute
                else if (key == "sets") {
                    sets = value as String
                    //print("Exercise Sets: \(sets!)")
                }
                    // Handle Reps Attribute
                else if (key == "reps") {
                    reps = value as String
                    //print("Exercise Sets: \(reps!)")
                }
                    // Handle Unexpected Attribute
                else {
                    print("Unknown Attribute")
                }
            }// end for loop
            let ex: ExerciseData = ExerciseData(exName: name!, exHyperlink: hyperlink!, exSets: sets!, exReps: reps!)
            self.cache.addToCache(self.section!, exercise: ex)
        }
            // Handle Unexpected Element
        else {
            print("unexpeced element: \(elementName)")
        }
    }
    
    // MARK: - Add Routine Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercises                                                                                                         //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func addExercises(section: String, request: String) {
        // Exercises need to be loaded from the server
        if self.cache.isLoadNeededFor(section) {
            // Set Class section for parser
            self.section = section
            
            // Load Exercies from the Server
            let paramData : [String : AnyObject] = [ "section" : section, "request" : request]
            loadData("addExercises", info: paramData, request: request)
            
        }
        // Exercises are available locally
        else
        {
            self.addExercisesToModel(section, request)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercisesHandler                                                                                                  //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercisesHandler(notification: NSNotification) {
        // Extract Prameters
        if let params: [NSObject : AnyObject] = notification.userInfo {
            if let section : String = params["section"] as? String {
                if let request : String = params["request"] as? String {
                    self.addExercisesToModel(section, request)
                }
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercisesToModel                                                                                                  //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func addExercisesToModel(section: String, _ requestString: String) {
        // Exercises are available from the cache
        if let exercises : [ExerciseData] = self.cache.getRoutineData(section) {
            // Add the exercises to the model
            self.workoutTable!.workout.addExercises(section, request: requestString, routineExercises: exercises)
        }
        self.navigationController?.pushViewController(self.workoutTable!, animated: false)
    }
    
    // MARK: - Switch Exercise Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExercise                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func switchExercise(section: String, indexPath: NSIndexPath) {
        // Exercise need to be loaded from the server
        if self.cache.isLoadNeededFor(section) {
            self.section = section
            
            //if let requestString:  String = self.cache.getRequestString(section) {
            if let requestString:  String = self.workoutTable?.workout.getRoutine(section)?.requestString {
                // Load Exercise from Server
                let paramData : [String : AnyObject] = [ "section" : section, "path" : indexPath]
                loadData("switchExericse", info: paramData, request: requestString)
            }
            
        }
        // Exercise is available locally
        else {
            self.switchExerciseInModel(section, indexPath: indexPath)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExerciseHandler                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func switchExerciseHandler(notification: NSNotification) {
        print("In switch Handler")
        if let params: [NSObject : AnyObject] = notification.userInfo {
            if let section : String = params["section"] as? String {
                if let path : NSIndexPath = params["path"] as? NSIndexPath {
                    self.switchExerciseInModel(section, indexPath: path)
                }
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExerciseInModel                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func switchExerciseInModel(sectionTitle: String, indexPath: NSIndexPath) {
        // Get Exercise Data from cache
        if let exData  : ExerciseData = self.cache.getExercise(sectionTitle) {
            // Replace Model Data with Exercise Data from the cache
            if let exercise: Exercise = self.workoutTable!.workout.routines[indexPath.section].exercises[indexPath.row] {
                    exercise.name      = exData.name
                    exercise.hyperlink = exData.hyperlink
                    exercise.sets      = exData.sets
                    exercise.reps      = exData.reps
                    self.workoutTable!.tableView!.reloadData()
            }
        }
    }
    
    // MARK: - Add Exercise Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercise                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercise(section: String, indexPath: NSIndexPath) {
        // Exercise need to be loaded from the server
        if self.cache.isLoadNeededFor(section) {
            self.section = section
            
            //if let requestString:  String = self.cache.getRequestString(section) {
            if let requestString:  String = self.workoutTable?.workout.getRoutine(section)?.requestString {
                // Load Exercise from the Server
                let paramData : [String : AnyObject] = [ "section" : section, "path" : indexPath]
                loadData("addExericse", info: paramData, request: requestString)
            }
        }
        // Exercise is available locally
        else {
            self.addExerciseToModel(section, indexPath: indexPath)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExerciseHandler                                                                                                   //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExerciseHandler(notification: NSNotification) {
        
        if let params: [NSObject : AnyObject] = notification.userInfo {
            if let section : String = params["section"] as? String {
                if let path : NSIndexPath = params["path"] as? NSIndexPath {
                    self.addExerciseToModel(section, indexPath: path)
                }
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExerciseToModel                                                                                                   //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func addExerciseToModel(sectionTitle: String, indexPath: NSIndexPath) {
        // Get Exercise Data from cache
        if let exData : ExerciseData = self.cache.getExercise(sectionTitle) {
                
            let exercise    : Exercise = Exercise(
                exName      : exData.name,
                exHyperlink : exData.hyperlink,
                exSets      : exData.sets,
                exReps      : exData.reps)
                
            self.workoutTable!.workout.routines[indexPath.section].exercises.insert(exercise, atIndex: indexPath.row)
            self.workoutTable!.tableView!.reloadData()
        }
    }
    
    // MARK: - Slide Navigation Method
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: slideNavigation                                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        delegate?.toggleLeftPanel?(self)
    }
}
