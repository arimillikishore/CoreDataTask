//
//  UserRequest.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//

import Foundation
import UIKit

class UserRequest:RequestObject {
    var endURL: String = "https://reqres.in/api/users?page=1"
    var method: RequestType = .get
    var body: [String : Any]?
    var headers: [String : Any]?
}
