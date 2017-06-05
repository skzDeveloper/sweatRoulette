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
    var cache           : ExerciseCache = ExerciseCache()
    var section         : String?
    var delegate        : WorkoutSelectorVCDelegate?

    // MARK: - UIViewController Overrides
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.section = self.workoutSelector!.getSectionString()
        self.cache.setRequestString(self.section!, request: self.workoutSelector!.getRequestString())
        
        addExercises(self.section!)
    }
    
    // MARK: - Data loading Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: loadData                                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //func loadData(cacheItem: WorkoutSectionCacheItem, muscle: String, info: [String:String], handlerString: String) {
    func loadData(handlerString: String, info: [NSObject : AnyObject]?) {
        // Set the HTTP parameters
        let requestString: String = workoutSelector!.getRequestString()
        let url = NSURL(string: requestString)
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
    private func addExercises(sectionTitle: String) {
        
        if self.cache.isLoadNeeded(sectionTitle) {
            print("We need to load routine data")
            loadData("addExercises", info: nil)
        }
        else
        {
            print("We have routine data")
            self.addExercisesToModel(sectionTitle)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercisesHandler                                                                                                  //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercisesHandler(notification: NSNotification) {
        self.addExercisesToModel(self.section!)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercisesToModel                                                                                                  //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func addExercisesToModel(sectionTitle: String) {
        //Get the exercise data from the routine cache
        print("Add exercises to model")
        if let exercises : [ExerciseData] = self.cache.getRoutineData(sectionTitle) {
            // Add the exercises to the model
            print("We got exercise data from the cache")
            self.workoutTable!.workout.addExercises(sectionTitle, routineExercises: exercises)
        }
        self.navigationController?.pushViewController(self.workoutTable!, animated: false)
    }
    
    // MARK: - Switch Exercise Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExercise                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func switchExercise(sectionTitle: String, indexPath: NSIndexPath) {
        
        // Request data from server
        if self.cache.isLoadNeeded(sectionTitle) {
            // Set paramters for updating the model
            let paramData : [String : AnyObject] = [ "section" : sectionTitle, "path" : indexPath]
            loadData("switchExericse", info: paramData)
        }
        // Data is avaiable locally
        else {
            self.switchExerciseInModel(sectionTitle, indexPath: indexPath)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExerciseHandler                                                                                                //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func switchExerciseHandler(notification: NSNotification) {
        
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
        // Get caches routine data
        if var routineData: [ExerciseData] = self.cache.getRoutineData(sectionTitle) {
            if routineData.isEmpty == false {
                // Remove data from the cache
                let exData  : ExerciseData = routineData.removeFirst()
                if let exercise: Exercise = self.workoutTable!.workout.routines[indexPath.section].exercises[indexPath.row] {
                    exercise.name      = exData.name
                    exercise.hyperlink = exData.hyperlink
                    exercise.sets      = exData.sets
                    exercise.reps      = exData.reps
                    self.workoutTable!.tableView!.reloadData()
                }
            }
        }
    }
    
    // MARK: - Add Exercise Methods
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercise                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercise(sectionTitle: String, indexPath: NSIndexPath) {
        
        if self.cache.isLoadNeeded(sectionTitle) {
            let paramData : [String : AnyObject] = [ "section" : sectionTitle, "path" : indexPath]
            loadData("addExericse", info: paramData)
        }
        else
        {
            print("We have add exercise data")
            self.addExerciseToModel(sectionTitle, indexPath: indexPath)
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
        // Get caches routine data
        if var routineData: [ExerciseData] = self.cache.getRoutineData(sectionTitle) {
            if routineData.isEmpty == false {
                // Remove data from the cache
                let exData : ExerciseData = routineData.removeFirst()
                
                let exercise    : Exercise = Exercise(
                    exName      : exData.name,
                    exHyperlink : exData.hyperlink,
                    exSets      : exData.sets,
                    exReps      : exData.reps)
                
                self.workoutTable!.workout.routines[indexPath.section].exercises.insert(exercise, atIndex: indexPath.row)
                self.workoutTable!.tableView!.reloadData()
            }
        }
    }
    
    // MARK: - Slide Navigation Method
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: slideNavigation                                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func slideNavigation (sender: UIButton) {
        delegate?.toggleLeftPanel?()
    }
}
