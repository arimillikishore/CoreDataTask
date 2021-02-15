//
//  User+CoreDataProperties.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var userId: Int32
    @NSManaged public var email: String
    @NSManaged public var avatar: String
    @NSManaged public var imageData: Data?

}
