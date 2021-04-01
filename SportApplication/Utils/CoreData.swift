//
//  CoreData.swift
//  SportApplication
//
//  Created by Hala on 01/04/2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataBuilder {
    
    
    class func saveToCoreData(delegate: AppDelegate, entityName: String, dataArray: [Any], KeysArray: [String], removeDataInSameTime: inout NSManagedObject){

        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let entityRow = NSManagedObject(entity: entity!, insertInto: context)
        
        for i in 0..<dataArray.count{
            entityRow.setValue(dataArray[i], forKey: KeysArray[i])
        }
        
        removeDataInSameTime = entityRow
        
        do{
            try context.save()
            print("Data added successfully")
        }catch let error as NSError{
            print(error)
        }
        
        delegate.saveContext()
    }
    
    
    class func fetchFromCoreData(delegate: AppDelegate, view: SuperClass, fetchedDataArray : inout [NSManagedObject], entityName: String) {
        
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do{
            fetchedDataArray = try context.fetch(fetchRequest)
            view.reloadData()
            
        }catch let error as NSError{
            print(error)
        }
        
        
    }
    

    
    
    class func deletefromCoreData(delegate: AppDelegate, index: Int, view: SuperClass, dataDeletedArray : inout [NSManagedObject]){
        
        let context = delegate.persistentContainer.viewContext
        context.delete(dataDeletedArray[index])
        dataDeletedArray.remove(at: index)
        
        do{
            try context.save()
            view.reloadData()
            
            print("Data deleted successfully")
        }catch let error as NSError{
            print(error)
        }
        delegate.saveContext()
    }
    
}


