//
//  Exercise+CoreDataProperties.swift
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

extension Exercise {

    @NSManaged var name: String?
    @NSManaged var hyperlink: String?
    @NSManaged var sets: String?
    @NSManaged var reps: String?
    @NSManaged var routine: Routine?

}
