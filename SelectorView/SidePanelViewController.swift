//
//  SidePanelViewController.swift
//  SelectorView
//
//  Created by Saad Omar on 5/31/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class SidePanelViewController: UIViewController {
    var containerVC      : ContainerViewController?
    var spinnerButton    : UIButton!
    var archivesButton   : UIButton!
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init(container: ContainerViewController) {
        super.init(nibName: nil, bundle: nil)
        
        containerVC = container
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Spinner Navigation Button Settings
        spinnerButton = UIButton(type: .System)
        spinnerButton.setTitle("Spinner", forState: .Normal)
        spinnerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        spinnerButton.backgroundColor = UIColor.blackColor()
        spinnerButton.addTarget(self, action: "spinnerButtonPressed:", forControlEvents: .TouchDown)
        
        //Set Spinner Navigation Button Settings
        archivesButton = UIButton(type: .System)
        archivesButton.setTitle("Archives", forState: .Normal)
        archivesButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        archivesButton.backgroundColor = UIColor.blackColor()
        archivesButton.addTarget(self, action: "archiveButtonPressed:", forControlEvents: .TouchDown)
        
        // Add buttons to Subview
        self.view.addSubview(spinnerButton)
        self.view.addSubview(archivesButton)
        
        // Add Constraints
        let BUTTON_HEIGHT = 20
        let d = ["sb":spinnerButton, "ab":archivesButton]
        let m = ["bh": BUTTON_HEIGHT]
        
        //Set Spinner Navigation Button Constraints
        spinnerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[ab(==bh)]", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[ab]-100-|", options: NSLayoutFormatOptions.AlignAllBottom, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[ab]|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        
        //Set Spinner Navigation Button Constraints
        archivesButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[sb(==bh)]", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[sb]-10-[ab]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[sb]|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: spinnerButtonPressed                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func spinnerButtonPressed(sender: UIButton) {
        print("Spinner Button Pressed")
        self.containerVC?.pushSelectorView()
        
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: archiveButtonPressed                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func archiveButtonPressed(sender: UIButton) {
        print("Archive Button Pressed")
        self.containerVC?.pushArchiveView()
    }

    // MARK: - Navigation
}
