//
//  ArchiveCell.swift
//  SelectorView
//
//  Created by Saad Omar on 6/13/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import UIKit

class ArchiveCell: UITableViewCell {
    var archiveLabel: UILabel!
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: init                                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Create and Configure Archive Label
        archiveLabel = UILabel()
        archiveLabel.backgroundColor = UIColor.blackColor()
        
        //Set the Archive Image Icon
        let image = UIImage(named: "Folder")
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blackColor()
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        
        contentView.addSubview(archiveLabel)
        contentView.addSubview(imageView)
        
        let IMG_WIDTH:  CGFloat = contentView.bounds.height
        
        let d = ["img": imageView]
        let m = ["w": IMG_WIDTH]
        
        let cv: UIView = contentView
        
        // Set Exercise Name Label Constraints
        archiveLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Exercise Name and Sets Label Left Constraint
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[img(==w)]", options: NSLayoutFormatOptions.AlignAllTop,          metrics: m, views: d))
        cv.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[img]|"    , options: NSLayoutFormatOptions.AlignAllBottom, metrics: m, views: d))

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
