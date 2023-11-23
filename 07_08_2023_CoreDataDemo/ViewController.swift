//
//  ViewController.swift
//  07_08_2023_CoreDataDemo
//
//  Created by Vishal Jagtap on 22/11/23.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addPersonRecords()
        retriveRecords()
        deletePersonRecord()
        retriveRecords()
        updatePersonRecord()
        retriveRecords()
    }
    
    
    func addPersonRecords(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let personEntity = NSEntityDescription.entity(
            forEntityName: "Person",
            in: managedContext)
        
        for i in 1...3{
            let person = NSManagedObject(
                entity: personEntity!,
                insertInto: managedContext)
            
            person.setValue("Person\(i)", forKey: "name")
            person.setValue("Person\(i)@gmail.com", forKey: "email")
        }
        
        do{
           try managedContext.save()
        }catch{
            print("Error while saving")
        }
    }
    
    func retriveRecords(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do{
           let results = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for eachResult in results{
                print(eachResult.value(forKey: "name") as! String)
                print(eachResult.value(forKey: "email") as! String)
            }
            
        } catch {
            print("Failed catching results")
        }
    }
    
    func deletePersonRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Person1")
        do{
            let fetchedResults = try managedContext.fetch(fetchRequest)
            let objectToBeDeleted = fetchedResults[0] as! NSManagedObject
            managedContext.delete(objectToBeDeleted)
            do{
                try managedContext.save()
            }catch{
                print("Error")
            }
        }catch{
            print("Error")
        }
    }
    
    func updatePersonRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Person2")
        do{
            let fetchedResults = try managedContext.fetch(fetchRequest)
            let objectToBeUpdated = fetchedResults[0] as! NSManagedObject
            objectToBeUpdated.setValue("Tushar", forKey: "name")
            objectToBeUpdated.setValue("Tushar@bitcode.in", forKey: "email")
            do{
                try managedContext.save()
            }catch{
                print("Error")
            }
        }catch{
            print("Error")
        }
    }
}
