//
//  WorkoutData.swift
//  SelectorView
//
//  Created by Saad Omar on 6/2/16.
//  Copyright © 2016 Saad Omar. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Struct: WorkoutOptionData                                                                                                      //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct WorkoutOptionData {
    var labelName  : String
    var paramName  : String
    var isSelected : Bool
    
    init(label: String, param: String, selected: Bool) {
        labelName  = label
        paramName  = param
        isSelected = selected
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Struct: Exercise                                                                                                               //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct ExerciseData
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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Struct: Routine                                                                                                                //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//struct Routine {
//    var forMuscle   : String
//    var exerciseList: [Exercise]
//    
//    init(routineForMuscle: String)
//    {
//        forMuscle    = routineForMuscle
//        exerciseList = [Exercise] ()
//    }
//}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Class: ExerciseCacheItem                                                                                                       //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ExerciseCacheItem {
    var section       : String
    var requestString : String!
    var exerciseList: [ExerciseData]
    
    init(section: String)
    {
        self.section       = section
        self.requestString = nil
        self.exerciseList  = [ExerciseData] ()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Class: WorkoutSectionCacheItem                                                                                                 //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ExerciseCache {
    var cacheItems : [ExerciseCacheItem]
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - init                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init()
    {
        self.cacheItems = [ExerciseCacheItem] ()
        self.cacheItems.append(ExerciseCacheItem(section:"Abs"))
        self.cacheItems.append(ExerciseCacheItem(section:"Back"))
        self.cacheItems.append(ExerciseCacheItem(section:"Biceps"))
        self.cacheItems.append(ExerciseCacheItem(section:"Calves"))
        self.cacheItems.append(ExerciseCacheItem(section:"Chest"))
        self.cacheItems.append(ExerciseCacheItem(section:"Forearms"))
        self.cacheItems.append(ExerciseCacheItem(section:"Glutes"))
        self.cacheItems.append(ExerciseCacheItem(section:"Hamstrings"))
        self.cacheItems.append(ExerciseCacheItem(section:"Lats"))
        self.cacheItems.append(ExerciseCacheItem(section:"Quads"))
        self.cacheItems.append(ExerciseCacheItem(section:"Shoulders"))
        self.cacheItems.append(ExerciseCacheItem(section:"Traps"))
        self.cacheItems.append(ExerciseCacheItem(section:"Triceps"))
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - getCacheSection                                                                                      //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getCacheSection(section: String) -> ExerciseCacheItem? {
        
        for cacheItem in cacheItems {
            if cacheItem.section == section {
                return cacheItem
            }
        }
        return nil
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - setRequestString                                                                                     //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func setRequestString(section: String, request: String) {
        if let cacheSection: ExerciseCacheItem = self.getCacheSection(section) {
            cacheSection.requestString = request
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - isLoadNeeded                                                                                         //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func isLoadNeeded(section: String) -> Bool{
        var loadNeeded = false
        
        if let cacheSection: ExerciseCacheItem = self.getCacheSection(section) {
            if cacheSection.exerciseList.count < 4 {
                loadNeeded = true
            }
        }
        return loadNeeded
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - addToCache                                                                                           //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addToCache(section: String, exercise: ExerciseData) {
        
        if let cacheSection: ExerciseCacheItem = self.getCacheSection(section) {
            cacheSection.exerciseList.append(exercise)
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - getRoutineDataFromCache                                                                              //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRoutineDataFromCache(section: String) -> [ExerciseData]?{
        var routineData : [ExerciseData]? = nil
        
        if let cacheSection: ExerciseCacheItem = self.getCacheSection(section) {
            if cacheSection.exerciseList.count > 0 {
                routineData = [ExerciseData]()
                let resultCount = min(cacheSection.exerciseList.count, 4)
                
                var i: Int  = 0
                while i < resultCount {
                    routineData!.append(cacheSection.exerciseList.first!)
                    cacheSection.exerciseList.removeFirst()
                    ++i
                }
            }
        }
        return routineData
    }
    
} //End Class



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Class: Workout                                                                                                                 //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//class Workout: NSObject {
//    var title    : String = "My Workout"
//    var routines: [Routine]
//    
//    override init() {
//        routines = [Routine] ()//
//    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: doesRoutineExist                                                                                                     //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    func doesRoutineExist(muscle: String) -> Int? {
//        // Loop through Array of sections (Routines)
//        for (index, ​routine) in routines.enumerate() {
//            // Check if there is a routine for the mucsle
//            if ​routine.forMuscle == muscle {
//                return index
//            }
//        }
//        // A Routine does not exist for the muscle
//        return nil
 //   }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addRoutine                                                                                                           //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    func addRoutine(muscle: String, var exercises:[Exercise]) {
//        // Add Exercises to existing Routine
//        if let routineIndex = doesRoutineExist(muscle) {
//            routines[routineIndex].exerciseList.append(exercises.removeFirst())
//            routines[routineIndex].exerciseList.append(exercises.removeFirst())
//            routines[routineIndex].exerciseList.append(exercises.removeFirst())
//            routines[routineIndex].exerciseList.append(exercises.removeFirst())
//            
//            print("The number for Routine \(routineIndex) is \(routines[routineIndex].exerciseList.count)")
//        }
//        // Create new Routine
//        else {
//            var newRoutine: Routine = Routine(routineForMuscle: muscle)
//            
//            //Populate the Routine with Exercises
//            newRoutine.exerciseList.append(exercises.removeFirst())
//            newRoutine.exerciseList.append(exercises.removeFirst())
//            newRoutine.exerciseList.append(exercises.removeFirst())
//            newRoutine.exerciseList.append(exercises.removeFirst())
//            
//            //Add the routines array
//            routines.append(newRoutine)
//        }
//    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: addExercise                                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //   func addExercise(exercise:Exercise, section: Int, row: Int) {
//        routines[section].exerciseList.insert(exercise, atIndex: row)
 //   }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: switchExercise                                                                                                       //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   // func switchExercise(exercise:Exercise, section: Int, row: Int) {
//        // Get Exercise to Switch out
//        var exerciseToSwitch = routines[section].exerciseList[row]
//        
//        // Switch out exercise data
//        exerciseToSwitch.name      = exercise.name
//        exerciseToSwitch.hyperlink = exercise.hyperlink
//        exerciseToSwitch.sets      = exercise.sets
//        exerciseToSwitch.reps      = exercise.reps
    //}
//}
