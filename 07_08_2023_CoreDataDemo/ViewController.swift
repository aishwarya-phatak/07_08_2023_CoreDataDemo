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
}
