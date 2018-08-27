//
//  WikiViewModel.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/27/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//

import Foundation
import CoreData

class WikiViewModel{
    
    
    func getWikiData(query:String,_ completionHandler:@escaping (Bool,[Pages]?) -> Void){
        
        let api = APIWiki()
        let parameter:[String:AnyObject] = ["action":"query" as AnyObject,"format":"json" as AnyObject,"prop":"info|pageimages|pageterms" as AnyObject, "generator":"prefixsearch" as AnyObject, "redirects":"1" as AnyObject,"formatversion":"2" as AnyObject,"piprop":"thumbnail" as AnyObject,"pithumbsize":"50" as AnyObject,"pilimit":"10" as AnyObject,"wbptterms":"description" as AnyObject,"gpssearch":"\(query)" as AnyObject,"gpslimit":"10" as AnyObject,"inprop":"url" as AnyObject]
        
        api.getWikiData(parameter) {[weak self](data:AnyObject?,error:NSError?) in
            if error == nil {
                print(data as Any)
                if let jsonData = data as? [String:AnyObject] {
                    var paged:[Pages] = []
                    if let query = jsonData["query"] as? [String:AnyObject] {
                        if let pages = query["pages"] as? [[String:AnyObject]]{
                            
                            paged.append(contentsOf: (self?.parseJsonArray(json: pages))!)
                            completionHandler(true,paged)
                            self?.removeDataFromCoreData()
                            CoreDataStack.sharedInstance.savePagesInCoreDataWith(array: paged)
                        }else{
                            completionHandler(false,nil)
                        }
                    }else{
                        completionHandler(false,nil)
                    }
                    
                }
                
            }else {
                completionHandler(false,nil)
            }
        }
    }
    
    private func parseJsonArray(json:[[String:AnyObject]])->[Pages]{
        var page = [Pages]()
        for data in json{
            let entity = NSEntityDescription.entity(forEntityName: "Pages", in: CoreDataStack.sharedInstance.persistentContainer.viewContext)
            let pg = Pages.init(entity: entity!, insertInto: nil)
                if let title = data["title"] as? String {
                    pg.title = title
                }
                if let canonicalurl = data["canonicalurl"] as? String {
                    pg.canonicalurl = canonicalurl
                }
                if let pageid = data["pageid"] as? Int64{
                    pg.pageid = pageid
                }
                if let index = data["index"] as? Int32{
                    pg.index = index
                }
                if let thumbnail = data["thumbnail"]?["source"] as? String{
                    pg.thumbnail = thumbnail
                }
                if let desc = data["terms"]?["description"] as? [String]{
                    for des in desc{
                        pg.desc?.append("\(des),")
                    }
                    let _ = pg.desc?.dropLast()
                }
                page.append(pg)
        }
        return page.sorted(by: {$0.index<$1.index})
    }
    
    func getPagesFromDatabase()->[Pages]{
        var pages = [Pages]()
        let request:NSFetchRequest<Pages> = Pages.fetchRequest()
        do {
            let result = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(request)
            pages.append(contentsOf: result)
            
        } catch {
            print(error) // print the actual error not a meaningless literal string
        }
        
        return pages.sorted(by: {$0.index<$1.index})
    }
    
    
    func removeDataFromCoreData(){
        CoreDataStack.sharedInstance.removeData()
    }
}

