//
//  Workout+CoreDataProperties.swift
//  SweatRoulette
//
//  Created by Saad Omar on 5/7/17.
//  Copyright © 2017 Saad Omar. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Workout {
    
    @nonobjc internal class func  fetchRequest() -> NSFetchRequest {
        return NSFetchRequest(entityName: "Workout")
    }

    @NSManaged var title   : String?
    @NSManaged var date    : NSDate?
    @NSManaged var routines: NSSet?

}
