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
    func getRoutine(sectionTitle: String) -> Routine? {
        
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
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - addRoutine                                                                                        //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addRoutine(sectionTitle: String) {
        print("Add Routine")
        // Unwrap the Routine Set
        if let routineSet:NSSet = self.routines {
            print("The routines is not null")
            // Convert the routine Set into an array
            var routines:[Routine] = routineSet.allObjects as! [Routine]
            
            //Create a managed object
            let routine:Routine = NSEntityDescription.insertNewObjectForEntityForName("Routine",
                inManagedObjectContext: LocalDatabaseController.managedObjectContext) as! Routine
            
            routine.name = sectionTitle
            routine.exercises = NSSet()
            
            //Add the routine to the array
            routines.append(routine)
            
            self.routines = NSSet(array: routines)
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - addExercises                                                                                      //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercises(sectionTitle: String, routineExercieses: [ExerciseData]) {
        //print("Time to add some exercieses")
        var routine : Routine? = self.getRoutine(sectionTitle)
        
        if routine == nil {
            self.addRoutine(sectionTitle)
            routine = self.getRoutine(sectionTitle)
        }
        
        if routine != nil {
            var exercises:[Exercise] = routine!.exercises!.allObjects as! [Exercise]
            
            for exData: ExerciseData in routineExercieses {
                
                let exercise:Exercise = NSEntityDescription.insertNewObjectForEntityForName("Exercise",
                    inManagedObjectContext: LocalDatabaseController.managedObjectContext) as! Exercise
                
                exercise.name      = exData.name
                exercise.hyperlink = exData.hyperlink
                exercise.sets      = exData.sets
                exercise.reps      = exData.reps
                
                exercises.append(exercise)
            }
            routine!.exercises = NSSet(array: exercises)
            //self.routines = NSSet(array: routines)
        }
        else {
            print("I need to see what's going on")
        }
    }
}
