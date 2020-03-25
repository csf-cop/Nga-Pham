//
//  CoreOrder+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/23/20.
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
    @NSManaged public var re_Juice: NSSet?
    @NSManaged public var re_Unit: NSSet?

}

// MARK: Generated accessors for re_Juice
extension CoreOrder {

    @objc(addRe_JuiceObject:)
    @NSManaged public func addToRe_Juice(_ value: CoreJuice)

    @objc(removeRe_JuiceObject:)
    @NSManaged public func removeFromRe_Juice(_ value: CoreJuice)

    @objc(addRe_Juice:)
    @NSManaged public func addToRe_Juice(_ values: NSSet)

    @objc(removeRe_Juice:)
    @NSManaged public func removeFromRe_Juice(_ values: NSSet)

}

// MARK: Generated accessors for re_Unit
extension CoreOrder {

    @objc(addRe_UnitObject:)
    @NSManaged public func addToRe_Unit(_ value: CoreUnit)

    @objc(removeRe_UnitObject:)
    @NSManaged public func removeFromRe_Unit(_ value: CoreUnit)

    @objc(addRe_Unit:)
    @NSManaged public func addToRe_Unit(_ values: NSSet)

    @objc(removeRe_Unit:)
    @NSManaged public func removeFromRe_Unit(_ values: NSSet)

}
