//
//  RoutineHeaderCell.swift
//  SelectorView
//
//  Created by Saad Omar on 6/5/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class RoutineHeaderCell: UITableViewCell {
    var sectionTitle: UILabel!

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(colorLiteralRed: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        // Create and configure Section Title
        sectionTitle = UILabel()
        sectionTitle.textColor = UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0)
        
        contentView.addSubview(sectionTitle)
        
        let CELL_HEIGHT: CGFloat = contentView.bounds.height
        let INSETS     : CGFloat = CELL_HEIGHT * 0.04
        
        let d = ["st":sectionTitle]
        let m = ["i": INSETS]
        
        let cv: UIView = contentView
        
        // Set Exercise Name Label Constraints
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        // Exercise Name and Sets Label Left Constraint
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-i-[st]-i-|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-i-[st]-i-|", options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
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
        // Initialization code
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: setSelected                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
