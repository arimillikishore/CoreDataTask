//
//  CustomAPIRequest.swift
//  Tark
//
//  Created by venkata rama kishore arimilli on 28/01/21.
//

import Foundation
import UIKit

protocol RequestObject {
    var endURL:String{get}
    var method:RequestType{get}
    var body:[String:Any]?{get}
    var headers:[String:Any]?{get}
}

enum RequestType:String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

typealias APIResponseHandler = (_ success: Bool,_ data: Data?,_ error: Error?) -> Void

class NetworkHandler {
    class func sendRequest<T:RequestObject>(req:T,responseHandler:@escaping(APIResponseHandler)) {
        var request = URLRequest(url: URL(string: req.endURL)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = req.method.rawValue
        request.timeoutInterval = 200
        if req.headers != nil {
            for (key,val) in req.headers ?? [:] {
                if let headerVal = val as? String {
                    request.setValue(headerVal, forHTTPHeaderField: key)
                }
            }
        }
        if let reqBody = req.body,let bodyData = try? JSONSerialization.data(withJSONObject: reqBody){
            if var bodyStr = String(data: bodyData, encoding: .utf8) {
                bodyStr = bodyStr.replacingOccurrences(of: "\\", with: "")
                request.httpBody = bodyStr.data(using: .utf8)!
            }
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let resp = response as? HTTPURLResponse else {
                responseHandler(false,data,error)
                return
            }
            guard error == nil else {
                responseHandler(false,nil,error)
                return
            }
            guard data != nil else {
                responseHandler(false,nil,error)
                return
            }
            guard resp.statusCode == 200 && error == nil else {
                responseHandler(false,nil,error)
                return
            }
            responseHandler(true, data, error)
        }
        task.resume()
    }
}
