//
//  WorkoutOptionVC.swift
//  SelectorView
//
//  Created by Saad Omar on 6/14/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class WorkoutOptionVC: UIViewController {
    
    // The Option View Component Views
    var titleView  : UIView!
    var titleLabel : UILabel!
    var titleString: String!
    
    // The Option View Component Properties
    var options: [WorkoutOptionData] = []
    
    // Instansiate the Option Controllers
    let flowLayout = UICollectionViewFlowLayout()
    var collectionOption: OptionCollectionVC!
    var collectionOptionView: UICollectionView!
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init(titleText: String, options: [WorkoutOptionData])
    {
        self.titleString = titleText
        self.options     = options

        //Call UIViewControllers designated class
        super.init(nibName: nil, bundle: nil)
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
    // Function: loadView                                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func loadView() {
        
        // Instsiate the Parent View
        view = UIView()
        
        // Create and Configure the Title View
        titleView                 = UIView()
        
        // Create and Configure the Title Label
        titleLabel               = UILabel()
        titleLabel.text          = titleString
        titleLabel.textAlignment = .Center
        
        //debug
        //let VIEW_HEIGHT       = view.bounds.height
        //let TITLE_VIEW_HEIGHT = VIEW_HEIGHT * 0.35
        
        //print("VIEW_HEIGHT: \(VIEW_HEIGHT)  VIEW_WIDTH: \(view.bounds.width) TITLE_VIEW_HEIGHT: \(TITLE_VIEW_HEIGHT)")

        
        // Create and Configure the Collection View

        collectionOption                   = OptionCollectionVC(collectionViewLayout: flowLayout, options: options)
        addChildViewController(collectionOption)
        collectionOptionView               = collectionOption.collectionView
        
        // Add the subviews
        titleView.addSubview(titleLabel)
        view.addSubview(titleView)
        view.addSubview(collectionOptionView)
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewDidLoad                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Turn Off Auto-Resizing
        titleView.translatesAutoresizingMaskIntoConstraints  = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionOptionView.translatesAutoresizingMaskIntoConstraints = false

        let d = ["tv":titleView, "l":titleLabel, "cv":collectionOptionView]

        // Add Constraints to Title View
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tv][cv]|" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tv]|"     , options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: d))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[cv]|"     , options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: d))
        
        titleView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[l]-2-|",options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        titleView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[l]-8-|",options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: viewWillLayoutSubviews                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func viewWillLayoutSubviews() {
        
        let VIEW_HEIGHT       = view.bounds.height
        let TITLE_VIEW_HEIGHT = VIEW_HEIGHT * 0.35
        let CELL_HEIGHT       = VIEW_HEIGHT - TITLE_VIEW_HEIGHT - 11
        let CELL_WIDTH        = CELL_HEIGHT * 0.80//(view.bounds.width * 0.90) / 4.25
        
        //print("VIEW_HEIGHT: \(VIEW_HEIGHT)  VIEW_WIDTH: \(view.bounds.width) TITLE_VIEW_HEIGHT: \(TITLE_VIEW_HEIGHT)")
        
        let d = ["tv":titleView]
        let m = ["tvh": TITLE_VIEW_HEIGHT]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[tv(==tvh)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        flowLayout.minimumLineSpacing      = (view.bounds.width * 0.10) / 4//2
        flowLayout.itemSize                = CGSize(width: CELL_WIDTH, height: CELL_HEIGHT)
        flowLayout.sectionInset            = UIEdgeInsetsMake(5, 0, 5, 0)
        flowLayout.scrollDirection         = .Horizontal
        
        self.collectionOption.fooArrayOp(4)
        
        print("Flow Layout: min Line Spacing \(flowLayout.minimumLineSpacing) : itemSize \(flowLayout.itemSize.width))")
    }
    

    

}
