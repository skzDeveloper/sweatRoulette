//
//  Workout.swift
//  SweatRoulette
//
//  Created by Saad Omar on 5/7/17.
//  Copyright © 2017 Saad Omar. All rights reserved.
//

import Foundation
import CoreData


class Workout: NSManagedObject {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - setTitle                                                                                          //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func setTitle() -> String{
       return "My Workout"
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - doesSectionExist                                                                                  //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRoutine(sectionTitle: String) -> Routine?{
        
        if let routineSet:NSSet = self.routines {
            //Get the routines from NSSet
            let routines:[Routine] = routineSet.allObjects as! [Routine]
            
            for routine in routines {
                if routine.name == sectionTitle {
                    return routine
                }
            }
        }
        
        return nil
    }
    
    

}
