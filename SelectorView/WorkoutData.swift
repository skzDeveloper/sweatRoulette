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
// Class: ExerciseCacheItem                                                                                                       //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ExerciseCacheItem : NSObject {
    var section       : String
    var requestString : String!
    var exerciseList: [ExerciseData]
    
    init(section: String)
    {
        self.section       = section
        self.requestString = nil
        self.exerciseList  = [ExerciseData] ()
        
        super.init()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                    //
// Class: WorkoutSectionCacheItem                                                                                                     //
//                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ExerciseCache : NSObject {
    var cacheItems : [ExerciseCacheItem]
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - init                                                                                                 //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    override init()
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
        
        super.init()
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
    // Function: ExerciseCache - getRequestString                                                                                     //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRequestString(section: String) -> String? {
        
        for cacheItem in cacheItems {
            if cacheItem.section == section {
                return cacheItem.requestString
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
    func isLoadNeededFor(section: String) -> Bool{
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
    // Function: ExerciseCache - getExercise                                                                                          //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getExercise(section: String) -> ExerciseData? {
        var exData: ExerciseData? = nil
        
        if let cacheSection: ExerciseCacheItem = self.getCacheSection(section) {
            if !cacheSection.exerciseList.isEmpty {
                exData = cacheSection.exerciseList.removeFirst()
            }
        }
        return exData
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                                //
    // Function: ExerciseCache - getRoutineDataFromCache                                                                              //
    //                                                                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRoutineData(section: String) -> [ExerciseData]?{
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
// Struct: Exercise                                                                                                               //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Exercise : NSObject
{
    var name     : String
    var hyperlink: String
    var sets     : String
    var reps     : String
    
    init(exName: String, exHyperlink: String, exSets: String , exReps: String)
    {
        self.name      = exName
        self.hyperlink = exHyperlink
        self.sets      = exSets
        self.reps      = exReps
        
        super.init()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Class: Routine                                                                                                                 //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Routine : NSObject{
    var sectionTitle  : String
    var requestString : String
    var exercises     :[Exercise]

    init(sectionTitle: String, requestString: String)
    {
        self.sectionTitle  = sectionTitle
        self.requestString = requestString
        self.exercises     = [Exercise] ()
        
        super.init()
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
// Class: Workout                                                                                                                 //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Workout : NSObject {
    var title    : String  = "My Workout"
    var date     : NSDate? = nil
    var routines : [Routine]
    
    override init() {
        routines = [Routine] ()
        super.init()
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - doesSectionExist                                                                                  //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRoutine(sectionTitle: String) -> Routine? {
        for routine in routines {
            if routine.sectionTitle == sectionTitle {
                return routine
            }
        }
        return nil
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - addRoutine                                                                                        //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //func addRoutine(sectionTitle: String) {
    //    self.routines.append(Routine(sectionTitle: sectionTitle))
    //}
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                                                                                                       //
    // Function: Workout - addExercises                                                                                      //
    //                                                                                                                       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addExercises(sectionTitle: String, request: String, routineExercises: [ExerciseData]) {
        if let routine : Routine = self.getRoutine(sectionTitle) {
            // Update the request string
            routine.requestString = request
            
            for exData : ExerciseData in routineExercises {
                routine.exercises.append(Exercise(
                    exName      : exData.name,
                    exHyperlink : exData.hyperlink,
                    exSets      : exData.sets,
                    exReps      : exData.reps))
                
            }
        }
        else {
            let routine = Routine(sectionTitle: sectionTitle, requestString: request)
            
            for exData : ExerciseData in routineExercises {
                routine.exercises.append(Exercise(
                    exName      : exData.name,
                    exHyperlink : exData.hyperlink,
                    exSets      : exData.sets,
                    exReps      : exData.reps))
            }
            self.routines.append(routine)
        }
    }
}

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
