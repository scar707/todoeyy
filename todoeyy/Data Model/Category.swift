//
//  Category.swift
//  todoeyy
//
//  Created by Milinda Sandaruwan on 4/3/19.
//  Copyright © 2019 WIZBIZ International. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    
    @objc dynamic var name:String=""
    let items=List<Item>()
    
}
