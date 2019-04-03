//
//  Item.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 4/3/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    @objc dynamic var date:Date?
    
    var parentCategory=LinkingObjects(fromType: Category.self, property:"items")
    
}
