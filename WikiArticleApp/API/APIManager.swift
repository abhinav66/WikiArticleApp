//
//  APIManager.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/27/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import Foundation

class APIManager:NSObject{
    
    
    static let sharedInstance = APIManager()
    
    /**
     GET requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    let urlSession = URLSession.shared
    
    func doGet(urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,type:String,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        if let url = URL(string:urlString){
            
            let getRequest = URLRequest(url: url)
            let task = urlSession.dataTask(with: getRequest as URLRequest, completionHandler: { data, response, error in
                
                guard error == nil else {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                do {
                    
                    // the data is returned in JSON format and needs to be converted into something that swift can work with
                    // we are converting it into a dictionary of type [String: Any]
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                        completionHandler(json as AnyObject,nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil,error as NSError)
                }
            })
            
            task.resume()
        }
        
    }
    
    /**
     POST requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    
    
    func doPost(_ urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,type:String,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        
    }
    
    /**
     PUT requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    
    
    func doPut(_ urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        
        
        
        
    }
    
    /**
     DELETE requests in Http API calls.
     
     - parameter urlString:                relative path of url
     - parameter headers:                  NSDictionary of headers
     - parameter parameters:               NSDictionary of params
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    
    func doDelete(_ urlString:String,parameters:[String : AnyObject]?,headers: [String : String]?,completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        
    }
}
