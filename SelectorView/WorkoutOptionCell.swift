//
//  WorkoutOptionCell.swift
//  SelectorView
//
//  Created by Saad Omar on 6/17/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class WorkoutOptionCell: UICollectionViewCell {
    var iconView:      UIView!
    var selectedView:  UIView!
    var checkImage:    UIImageView!
    var iconImage:     UIImageView!
    var optionTextView:UIView!
    var optionText:    UILabel!
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //print("initializing the Collection Cells")
        // Create and Configure the Option Icon View
        iconView = UIView()
        iconView.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.68, blue: 0.94, alpha: 1.0)
        
        // Create and Configure the Option Text View
        optionTextView = UIView()
        optionTextView.backgroundColor = UIColor.whiteColor()

        // Create and Configure the Option Text Label
        optionText = UILabel()
        optionText.numberOfLines = 1
        optionText.font = optionText.font.fontWithSize(10)
        optionText.textAlignment = NSTextAlignment.Center
        optionText.backgroundColor = UIColor.whiteColor()
        
        // Add the Subviews
        contentView.addSubview(iconView)
        contentView.addSubview(optionTextView)
        optionTextView.addSubview(optionText)
        
        iconView.translatesAutoresizingMaskIntoConstraints       = false
        optionTextView.translatesAutoresizingMaskIntoConstraints = false
        optionText.translatesAutoresizingMaskIntoConstraints     = false
        
        let IMAGE_VIEW_HEIGHT = frame.height * 0.8
        
        let cv:UIView = contentView
        let d = ["iv":iconView, "lv":optionTextView]
        let m = ["ivh": IMAGE_VIEW_HEIGHT]
        
        
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[iv(==ivh)]" , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: m, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[iv][lv]|"  , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[iv]|"      , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[lv]|"      , options: NSLayoutFormatOptions.DirectionLeftToRight, metrics: nil, views: d))

        
        // Constrain Center of Title Label
        optionTextView.addConstraint(NSLayoutConstraint(item: optionText, attribute: .CenterX, relatedBy: .Equal, toItem: optionTextView, attribute: .CenterX, multiplier: 1, constant: 0))
        //
        optionTextView.addConstraint(NSLayoutConstraint(item: optionText, attribute: .Top, relatedBy: .Equal, toItem: optionTextView, attribute: .Top, multiplier: 1, constant: 0))
        // Constrain Bottom of Title View
        optionTextView.addConstraint(NSLayoutConstraint(item: optionText, attribute: .Bottom, relatedBy: .Equal, toItem: optionTextView, attribute: .Bottom, multiplier: 1, constant: 0))
        // Constrain Left of Title View
        optionTextView.addConstraint(NSLayoutConstraint(item: optionText, attribute: .Left, relatedBy: .Equal, toItem: optionTextView, attribute: .Left, multiplier: 1, constant: 0))
        // Constrain Right of Title View
        optionTextView.addConstraint(NSLayoutConstraint(item: optionText, attribute: .Right, relatedBy: .Equal, toItem: optionTextView, attribute: .Right, multiplier: 1, constant: 0))
        
        
        // Create and Configure the Image View
        iconImage = UIImageView()
        iconImage.contentMode = .ScaleAspectFit
        iconView.addSubview(iconImage)
        
        iconImage.translatesAutoresizingMaskIntoConstraints  = false
        
        // Constrain Top of Title View
        iconView.addConstraint(NSLayoutConstraint(item: iconImage, attribute: .Top, relatedBy: .Equal, toItem: iconView, attribute: .Top, multiplier: 1, constant: 8))
        // Constrain Bottom of Title View
        iconView.addConstraint(NSLayoutConstraint(item: iconImage, attribute: .Bottom, relatedBy: .Equal, toItem: iconView, attribute: .Bottom, multiplier: 1, constant: -8))
        // Constrain Left of Title View
        iconView.addConstraint(NSLayoutConstraint(item: iconImage, attribute: .Left, relatedBy: .Equal, toItem: iconView, attribute: .Left, multiplier: 1, constant: 8))
        // Constrain Right of Title View
        iconView.addConstraint(NSLayoutConstraint(item: iconImage, attribute: .Right, relatedBy: .Equal, toItem: iconView, attribute: .Right, multiplier: 1, constant: -8))

        selectedView = UIView()
        selectedView.backgroundColor = UIColor.whiteColor()
        selectedView.alpha = 0.8
        contentView.addSubview(selectedView)
        selectedView.hidden = true
        selectedView.translatesAutoresizingMaskIntoConstraints  = false
        //
        selectedView.addConstraint(NSLayoutConstraint(item: selectedView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: frame.height * 0.8))
        // Constrain Top of Title View
        contentView.addConstraint(NSLayoutConstraint(item: selectedView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0))
        // Constrain Left of Title View
        contentView.addConstraint(NSLayoutConstraint(item: selectedView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0))
        // Constrain Right of Title View
        contentView.addConstraint(NSLayoutConstraint(item: selectedView, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: 0))
        
        checkImage = UIImageView()
        checkImage.image = UIImage(named: "checkwhite")
        checkImage.contentMode = .ScaleAspectFit
        iconView.addSubview(checkImage)
        checkImage.hidden = true
        
        checkImage.translatesAutoresizingMaskIntoConstraints  = false
        
        // Constrain Top of Title View
        iconView.addConstraint(NSLayoutConstraint(item: checkImage, attribute: .Top, relatedBy: .Equal, toItem: iconView, attribute: .Top, multiplier: 1, constant: 24))
        // Constrain Bottom of Title View
        iconView.addConstraint(NSLayoutConstraint(item: checkImage, attribute: .Bottom, relatedBy: .Equal, toItem: iconView, attribute: .Bottom, multiplier: 1, constant: -24))
        // Constrain Left of Title View
        iconView.addConstraint(NSLayoutConstraint(item: checkImage, attribute: .Left, relatedBy: .Equal, toItem: iconView, attribute: .Left, multiplier: 1, constant: 24))
        // Constrain Right of Title View
        iconView.addConstraint(NSLayoutConstraint(item: checkImage, attribute: .Right, relatedBy: .Equal, toItem: iconView, attribute: .Right, multiplier: 1, constant: -24))
        

        
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
    // Function: select                                                                                                               //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func select() {
        self.selectedView.hidden = false
        self.checkImage.hidden = false
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: deselect                                                                                                             //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func deselect() {
        self.selectedView.hidden = true
        self.checkImage.hidden = true
    }

    
}
