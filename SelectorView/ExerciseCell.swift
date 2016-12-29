//
//  ExerciseCell.swift
//  SelectorView
//
//  Created by Saad Omar on 6/5/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
    var exNameLabel      : UILabel!
    var exSetsLabel      : UILabel!
    var exRepsLabel      : UILabel!
    var exerciseHyperlink: String?
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("Init Exercise Cell")
        backgroundColor = UIColor.whiteColor()
        contentView.backgroundColor = UIColor.yellowColor()
        
        // Add Views to the contenet view
        // Create and configure the Exercise Name Label
        exNameLabel = UILabel()
        exNameLabel.backgroundColor = UIColor.purpleColor()
        
        // Create and configure the Exercise Sets Label
        exSetsLabel = UILabel()
        exSetsLabel.backgroundColor = UIColor.lightGrayColor()
        
        // Create and configure the Exercise Sets Label
        exRepsLabel = UILabel()
        exRepsLabel.backgroundColor = UIColor.greenColor()
        
        // Add views to the content view
        contentView.addSubview(exNameLabel)
        contentView.addSubview(exSetsLabel)
        contentView.addSubview(exRepsLabel)
        
        self.accessoryType = .DetailButton
        
        preservesSuperviewLayoutMargins = false
        
        let CELL_HEIGHT   : CGFloat = contentView.bounds.height
        let EX_NAME_HEIGHT: CGFloat = CELL_HEIGHT * 0.80
        let LBL_SPACING   : CGFloat = CELL_HEIGHT * 0.10
        let INSETS        : CGFloat = CELL_HEIGHT * 0.05
        
        print("Cell Height: \(CELL_HEIGHT)")
        
        let d = ["nl":exNameLabel, "sl": exSetsLabel, "rl": exRepsLabel]
        let m = ["i": INSETS, "nh": EX_NAME_HEIGHT, "s": LBL_SPACING]
        
        let cv: UIView = contentView
        
        // Set Exercise Name Label Constraints
        exNameLabel.translatesAutoresizingMaskIntoConstraints = false
        exSetsLabel.translatesAutoresizingMaskIntoConstraints = false
        exRepsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Exercise Name Label Height
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[nl(==nh)]"  , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        // Exercise Name and Sets Label Left Constraint
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-i-[nl]-i-|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        // Exercise Name Label Top Contstraint
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-i-[nl]"    , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        // Set and Rep Label spacer Constraints
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[nl]-s-[sl]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[nl]-s-[rl]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        // Sets and Reps Label Bottom Contraints
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[sl]-i-|"    , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[rl]-i-|"    , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        
        // Sets and Reps Label Horizontal Contsraints
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[sl(==rl)]"    , options: NSLayoutFormatOptions.AlignAllTop, metrics: m, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-i-[sl][rl]-i-|"    , options: NSLayoutFormatOptions.AlignAllTop, metrics: m, views: d))
        
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
    // Function: awakeFromNib                                                                                                         //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: setSelected                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
