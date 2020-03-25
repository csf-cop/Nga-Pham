//
//  CoreOrder+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/25/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreOrder> {
        return NSFetchRequest<CoreOrder>(entityName: "CoreOrder")
    }

    @NSManaged public var id: String?

}
