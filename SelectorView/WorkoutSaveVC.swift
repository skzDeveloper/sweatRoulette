//
//  WorkoutSaveVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/20/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class WorkoutSaveVC: UIViewController, UITextFieldDelegate {
    
    var saveView        : UIView!      = nil
    var textField       : UITextField! = nil
    var cancelButton    : UIButton!    = nil
    var saveButton      : UIButton!    = nil
    var saveWorkoutLabel: UILabel!     = nil
    
    var bottomConstraint: NSLayoutConstraint!
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Main View Background Settings
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.20, blue: 0.20, alpha: 1.0)
        self.view.alpha           = 1.0
        self.view.opaque          = false
        
        // Create and configure the Save View
        saveView = UIView()
        saveView.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        saveView.alpha           = 1.0
        saveView.opaque          = true
        
        // Create and configure Cancel Button Settings
        cancelButton = UIButton(type: .System)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.sizeToFit()
        cancelButton.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0) //UIColor.yellowColor()
        cancelButton.setTitleColor(UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0), forState: .Normal)
        cancelButton.addTarget(self, action: "cancelButtonPressed:", forControlEvents: .TouchDown)
        
        // Create and configure Save Workout Label
        saveWorkoutLabel = UILabel()
        saveWorkoutLabel.text = "Save Workout"
        saveWorkoutLabel.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0) //UIColor.brownColor()
        saveWorkoutLabel.textAlignment = .Center
        
        // Create and configure Save Button Settings
        saveButton = UIButton(type: .System)
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.sizeToFit()
        saveButton.backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0) //UIColor.purpleColor()
        saveButton.setTitleColor(UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0), forState: .Normal)
        saveButton.addTarget(self, action: "saveButtonPressed:", forControlEvents: .TouchDown)
        
        // Create and configure the Text Field
        textField = UITextField()
        textField.borderStyle              = .RoundedRect
        textField.contentVerticalAlignment = .Center
        textField.textAlignment            = .Left
        textField.center                   = self.view.center
        textField.autocorrectionType       = UITextAutocorrectionType.No
        textField.placeholder              = "Name Your Workout"
        
        saveView.addSubview(textField)
        saveView.addSubview(cancelButton)
        saveView.addSubview(saveWorkoutLabel)
        saveView.addSubview(saveButton)
        self.view.addSubview(saveView)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillAppear                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
       textField.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        let d = ["sv":saveView, "tf":textField, "cb":cancelButton, "wl":saveWorkoutLabel, "sb":saveButton]
        
        saveView.translatesAutoresizingMaskIntoConstraints         = false
        textField.translatesAutoresizingMaskIntoConstraints        = false
        cancelButton.translatesAutoresizingMaskIntoConstraints     = false
        saveWorkoutLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints       = false
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[sv]|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        
        saveView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[cb]-4-[tf]-4-|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        
        saveView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[sb]-4-[tf]-4-|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        
        saveView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-4-[wl]-4-[tf]-4-|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        

        saveView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-4-[tf]-4-|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))

        bottomConstraint = NSLayoutConstraint(item:saveView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillDisappear                                                                                                    //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: keyboardWillShow                                                                                                     //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func keyboardWillShow(notification: NSNotification) {
        //print("keyboard will show")
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                //print("Keyboard Height = \(keyboardSize.height)")
                bottomConstraint.constant = -keyboardSize.height
            }
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: keyboardWillHide                                                                                                     //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0
        //print("keyboard will hide")
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: Designated Initializer                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //print("Return Pressed,should dismiss the Modal VC")
        if let presentingVC = self.presentingViewController {
            textField.resignFirstResponder()
            presentingVC.dismissViewControllerAnimated(true, completion: nil)
            
        }
        return true
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillLayoutSubviews                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillLayoutSubviews() {
        let VIEW_HEIGHT      : CGFloat = view.bounds.height
        let SAVE_HEIGHT      : CGFloat = VIEW_HEIGHT * 0.15
        let SAVE_WIDTH       : CGFloat = view.bounds.width
        let TEXT_FIELD_HEIGHT: CGFloat = SAVE_HEIGHT * 0.40
        let WIDTH_INSET      : CGFloat = SAVE_WIDTH * 0.01
        let WIDTH_VIEWS      : CGFloat = SAVE_WIDTH - WIDTH_INSET - WIDTH_INSET
        let SAVE_LABEL_WIDTH : CGFloat = WIDTH_VIEWS * 0.60
        let SAVE_BUTTON_WIDTH: CGFloat = WIDTH_VIEWS * 0.20
        
        
//        print("Main View Height : \(VIEW_HEIGHT)")
//        print("Save View Height : \(SAVE_HEIGHT)")
//        print("Save View Width  : \(SAVE_WIDTH)")
//        print("Text Field Height: \(TEXT_FIELD_HEIGHT)")
        
        let d = ["sv":saveView, "tf":textField, "sl":saveWorkoutLabel, "sb":saveButton, "cb":cancelButton]
        let m = ["sh": SAVE_HEIGHT, "tfh": TEXT_FIELD_HEIGHT, "i": WIDTH_INSET,  "slw": SAVE_LABEL_WIDTH, "sbw": SAVE_BUTTON_WIDTH]

        saveView.translatesAutoresizingMaskIntoConstraints  = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        saveWorkoutLabel.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints       = false
        cancelButton.translatesAutoresizingMaskIntoConstraints     = false
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[sv(==sh)]"  , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tf(==tfh)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[cb(==sbw)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[sl(==slw)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[sb(==sbw)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        //"H:|-i-[cb][sl][sb]-i-|"
        saveView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-i-[cb][sl][sb]-i-|" ,options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: cancelButtonPressed                                                                                                  //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func cancelButtonPressed(sender: UIButton) {
        //print("Cancel Button Pressed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: saveButtonPressed                                                                                                    //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func saveButtonPressed(sender: UIButton) {
        print("Save Button Pressed")
        LocalDatabaseController.saveContext()
    }
}
