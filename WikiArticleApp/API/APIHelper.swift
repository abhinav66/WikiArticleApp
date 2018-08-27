//
//  APIHelper.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/27/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import Foundation

enum HTTPVerb : String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

class APIHelper {
    
    //MARK: - API requests
    
    /**
     Entry point for Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter verb:                     HttpVerb
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    class func makeRequest(urlString: String, verb: HTTPVerb, parameters: Dictionary<String,AnyObject>?, headers:Dictionary<String,String>?,type:String,completionHandler:@escaping (AnyObject?,NSError?) -> Void) {
        
        switch verb {
        case .GET:
            APIManager.sharedInstance.doGet(urlString: urlString, parameters: parameters, headers: headers,type:type,completionHandler:completionHandler)
        case .POST:
            APIManager.sharedInstance.doPost(urlString, parameters: parameters, headers: headers,type:type,completionHandler:completionHandler)
        case .DELETE:
            APIManager.sharedInstance.doDelete(urlString, parameters: parameters, headers: headers,completionHandler:completionHandler)
        case .PUT:
            APIManager.sharedInstance.doPut(urlString, parameters: parameters, headers: headers,completionHandler:completionHandler)
        }
        
    }
    
    
}

