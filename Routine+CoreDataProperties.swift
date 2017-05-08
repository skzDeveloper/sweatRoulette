//
//  Routine+CoreDataProperties.swift
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

extension Routine {

    @NSManaged var name: String?
    @NSManaged var exercises: NSSet?
    @NSManaged var workout: Workout?

}
