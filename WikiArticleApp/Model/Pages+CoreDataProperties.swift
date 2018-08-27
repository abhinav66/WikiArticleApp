//
//  Pages+CoreDataProperties.swift
//  WikiArticleApp
//
//  Created by Abhinav Singh on 8/28/18.
//  Copyright © 2018 Abhinav. All rights reserved.
//
//

import Foundation
import CoreData


extension Pages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pages> {
        return NSFetchRequest<Pages>(entityName: "Pages")
    }

    @NSManaged public var pageid: Int64
    @NSManaged public var title: String?
    @NSManaged public var canonicalurl: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var index: Int32
    @NSManaged public var desc: String?
    
//    convenience init(pageid: Int64, title: String?, canonicalurl: String?, thumbnail:String?,index:Int32,desc:String?) {
//        self.init(pageid:pageid,title:title,canonicalurl:canonicalurl,thumbnail:thumbnail,index:index,desc:desc)
//        self.pageid = pageid
//        self.title = title
//        self.canonicalurl = canonicalurl
//        self.thumbnail = thumbnail
//        self.index = index
//        self.desc = desc
//    }

}
