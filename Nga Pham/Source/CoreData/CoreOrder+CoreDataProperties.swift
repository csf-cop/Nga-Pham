//
//  CoreOrder+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/2/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreOrder> {
        return NSFetchRequest<CoreOrder>(entityName: "CoreOrder")
    }

    @NSManaged public var contactAddress: String?
    @NSManaged public var contactName: String?
    @NSManaged public var externalId: String?
    @NSManaged public var id: String
    @NSManaged public var isDelete: Bool
    @NSManaged public var juiceName: String
    @NSManaged public var juiceType: String?
    @NSManaged public var orderNote: String?
    @NSManaged public var phone: String?
    @NSManaged public var mode: Int16

}
