//
//  User+CoreDataClass.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//
//

import Foundation
import SwiftyJSON
import CoreData

//{
//  "id": 1,
//  "email": "george.bluth@reqres.in",
//  "first_name": "George",
//  "last_name": "Bluth",
//  "avatar": "https://reqres.in/img/faces/1-image.jpg"
//}

@objc(User)
public class User: NSManagedObject {
    convenience init(data:JSON,manager:CoreDataManager) {
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: manager.managedContext)!
        self.init(entity: userEntity, insertInto: manager.managedContext)
        self.name = data["first_name"].stringValue + data["last_name"].stringValue
        self.userId = data["id"].int32Value
        self.email = data["email"].stringValue
        self.avatar = data["avatar"].stringValue
    }
    
    class func prepareUserData(jsonData:JSON) -> [User]{
        var userArray:[User] = []
        for obj in jsonData.array ?? [] {
            userArray.append(User(data: obj, manager: CoreDataManager.shared))
        }
        return userArray
    }
}
