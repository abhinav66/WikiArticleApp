//
//  APIWiki.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/27/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import Foundation

import Foundation

class APIWiki:NSObject{
    
    /**
     getFacilities
     
     - parameter completionHandler:        (AnyObject response, NSError)
     */
    func getWikiData(_ parameters:[String:AnyObject]?,_ completionHandler:@escaping ((AnyObject?,NSError?)->Void)){
        
        var queryString = ""
        var i=0
        for(key,value) in parameters! {
            if i == 0 {
                queryString.append("\(key)=\(value)")
            }
            else {
                queryString.append("&\(key)=\(value)")
            }
            i+=1
        }
        
        APIHelper.makeRequest(urlString: "https://en.wikipedia.org//w/api.php?\(queryString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)", verb: .GET, parameters: nil, headers: nil,type:"JSON",completionHandler: completionHandler)
        
    }
    
}
