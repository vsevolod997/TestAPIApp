//
//  SessionController.swift
//  TestAPIApp
//
//  Created by Всеволод Андрющенко on 20.10.2019.
//  Copyright © 2019 Всеволод Андрющенко. All rights reserved.
//

import UIKit
import CoreData
    

class SessionController{
    
    // Mark: Сохрвнение id текущей сессии
    final class func saveSesson(session: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Session", in: context)
        let newSession = NSManagedObject(entity: entity!, insertInto: context)
        newSession.setValue(session, forKey: "idSession")
        do {
            try context.save()
        } catch{
            print("FailSave")
        }
    }
    
    // Mark: Возвращение id сессий
    final class func getAllSession()->[String]?{
        var sessionString: [String] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Session")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                sessionString.append(data.value(forKey: "idSession") as! String)
            }
        } catch {
            print("Failed")
        }
        
        return sessionString
    }
}
