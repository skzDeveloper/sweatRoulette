//
//  WorkoutData.swift
//  SelectorView
//
//  Created by Saad Omar on 6/2/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import Foundation

struct WorkoutOptionData {
    var labelName: String
    var paramName: String
    
    
    init(label: String, param: String) {
        labelName = label
        paramName = param
    }
    
}


struct Exercise
{
    var name     : String
    var hyperlink: String
    var sets     : String
    var reps     : String
    
    init(exName: String, exHyperlink: String, exSets: String , exReps: String)
    {
        name      = exName
        hyperlink = exHyperlink
        sets      = exSets
        reps      = exReps
    }
    
}


struct Routine {
    var forMuscle   : String
    var exerciseList: [Exercise]
    
    init(routineForMuscle: String)
    {
        forMuscle    = routineForMuscle
        exerciseList = [Exercise] ()
    }
}


class WorkoutSectionCacheItem {
    var requestString : String!
    var exerciseList: [Exercise]
    
    init()
    {
        requestString = nil
        exerciseList = [Exercise] ()
    }
}

enum RequestType
{
    case Block, Single
}

class Workout: NSObject {
    var title    : String = "My Workout"
    var routines: [Routine]
    
    override init() {
        routines = [Routine] ()
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: doesRoutineExist                                                                                                     //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func doesRoutineExist(muscle: String) -> Int? {
        // Loop through Array of sections (Routines)
        for (index, ​routine) in routines.enumerate() {
            // Check if there is a routine for the mucsle
            if ​routine.forMuscle == muscle {
                return index
            }
        }
        // A Routine does not exist for the muscle
        return nil
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addRoutine                                                                                                           //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addRoutine(muscle: String, var exercises:[Exercise]) {
        // Add Exercises to existing Routine
        if let routineIndex = doesRoutineExist(muscle) {
            routines[routineIndex].exerciseList.append(exercises.removeFirst())
            routines[routineIndex].exerciseList.append(exercises.removeFirst())
            routines[routineIndex].exerciseList.append(exercises.removeFirst())
            routines[routineIndex].exerciseList.append(exercises.removeFirst())
            
            print("The number for Routine \(routineIndex) is \(routines[routineIndex].exerciseList.count)")
        }
        // Create new Routine
        else {
            var newRoutine: Routine = Routine(routineForMuscle: muscle)
            
            //Populate the Routine with Exercises
            newRoutine.exerciseList.append(exercises.removeFirst())
            newRoutine.exerciseList.append(exercises.removeFirst())
            newRoutine.exerciseList.append(exercises.removeFirst())
            newRoutine.exerciseList.append(exercises.removeFirst())
            
            //Add the routines array
            routines.append(newRoutine)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercise                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercise(exercise:Exercise, section: Int, row: Int) {
        routines[section].exerciseList.insert(exercise, atIndex: row)
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExercise                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func switchExercise(exercise:Exercise, section: Int, row: Int) {
        // Get Exercise to Switch out
        var exerciseToSwitch = routines[section].exerciseList[row]
        
        // Switch out exercise data
        exerciseToSwitch.name      = exercise.name
        exerciseToSwitch.hyperlink = exercise.hyperlink
        exerciseToSwitch.sets      = exercise.sets
        exerciseToSwitch.reps      = exercise.reps
    }
}
