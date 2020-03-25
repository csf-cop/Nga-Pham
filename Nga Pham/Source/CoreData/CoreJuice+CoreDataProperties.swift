//
//  CoreJuice+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/23/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreJuice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreJuice> {
        return NSFetchRequest<CoreJuice>(entityName: "CoreJuice")
    }

    @NSManaged public var id: String
    @NSManaged public var juiceName: String?
    @NSManaged public var juiceDescription: String
    @NSManaged public var dateCreate: Date
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var isDelete: Bool
    @NSManaged public var re_Image: NSSet?
    @NSManaged public var re_Unit: NSSet?
    @NSManaged public var re_Order: NSSet?

}

// MARK: Generated accessors for re_Image
extension CoreJuice {

    @objc(addRe_ImageObject:)
    @NSManaged public func addToRe_Image(_ value: CoreImage)

    @objc(removeRe_ImageObject:)
    @NSManaged public func removeFromRe_Image(_ value: CoreImage)

    @objc(addRe_Image:)
    @NSManaged public func addToRe_Image(_ values: NSSet)

    @objc(removeRe_Image:)
    @NSManaged public func removeFromRe_Image(_ values: NSSet)

}

// MARK: Generated accessors for re_Unit
extension CoreJuice {

    @objc(addRe_UnitObject:)
    @NSManaged public func addToRe_Unit(_ value: CoreUnit)

    @objc(removeRe_UnitObject:)
    @NSManaged public func removeFromRe_Unit(_ value: CoreUnit)

    @objc(addRe_Unit:)
    @NSManaged public func addToRe_Unit(_ values: NSSet)

    @objc(removeRe_Unit:)
    @NSManaged public func removeFromRe_Unit(_ values: NSSet)

}

// MARK: Generated accessors for re_Order
extension CoreJuice {

    @objc(addRe_OrderObject:)
    @NSManaged public func addToRe_Order(_ value: CoreOrder)

    @objc(removeRe_OrderObject:)
    @NSManaged public func removeFromRe_Order(_ value: CoreOrder)

    @objc(addRe_Order:)
    @NSManaged public func addToRe_Order(_ values: NSSet)

    @objc(removeRe_Order:)
    @NSManaged public func removeFromRe_Order(_ values: NSSet)

}
