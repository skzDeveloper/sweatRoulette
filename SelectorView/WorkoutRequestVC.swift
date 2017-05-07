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

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillAppear                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //print("View Will Appear")
        //Set the Logo on the navigation bar
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
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        
        navigationItem.titleView = imageView
        indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        
        // Acitvity Indicator
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addConstraint(NSLayoutConstraint(item: indicator, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: indicator, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        navigationController?.pushViewController(workoutTable!, animated: false)
        
        loadData()
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: loadData                                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //func loadData(cacheItem: WorkoutSectionCacheItem, muscle: String, info: [String:String], handlerString: String) {
    func loadData() {
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
            
            // This will be replaced by loading a prasing XML data
            //cacheItem.exerciseList += self.getCannedData()
            //self.workoutCache.updateValue(cacheItem, forKey: muscle)
            //NSNotificationCenter.defaultCenter().postNotificationName(handlerString, object: self, userInfo: info)
            
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
            print("Workout Element")
        }
            
        else if (elementName == "status") {
            //Handle status
        }
            // Handle Exercise Element
        else if (elementName == "exercise") {
            // Create Exercise
            print("Exercise Element")
            //loop through Attributes dictonary
            for (key, value) in attributeDict {
                //
                // Handle Name Attribute
                if (key == "name") {
                    name = value as String
                    print("Exercise Name: \(name!)")
                }
                    // Handle Hyperlink Element
                else if (key == "hyperlink") {
                    hyperlink = value as String
                    print("Exercise Hyperlink: \(hyperlink!)")
                }
                    // Handle Sets Attribute
                else if (key == "sets") {
                    sets = value as String
                    print("Exercise Sets: \(sets!)")
                }
                    // Handle Reps Attribute
                else if (key == "reps") {
                    reps = value as String
                    print("Exercise Sets: \(reps!)")
                }
                    // Handle Unexpected Attribute
                else {
                    print("Unknown Attribute")
                }
            }// end for loop
            let ex: Exercise = Exercise(exName: name!, exHyperlink: hyperlink!, exSets: sets!, exReps: reps!)
            //addExerciseToCache(bodyPart!, erercise: ex)
        }
            // Handle Unexpected Element
        else {
            print("unexpeced element: \(elementName)")
        }
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
