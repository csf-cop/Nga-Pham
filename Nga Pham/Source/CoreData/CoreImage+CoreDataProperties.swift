//
//  CoreImage+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/23/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreImage> {
        return NSFetchRequest<CoreImage>(entityName: "CoreImage")
    }

    @NSManaged public var id: String
    @NSManaged public var imageData: Data?
    @NSManaged public var imageDateCreate: Date?
    @NSManaged public var imageFileSize: Float
    @NSManaged public var imageName: String?
    @NSManaged public var imageTypeFor: Int16
    @NSManaged public var isDelete: Bool
    @NSManaged public var re_Contact: CoreContact?
    @NSManaged public var re_Juice: NSSet?

}

// MARK: Generated accessors for re_Juice
extension CoreImage {

    @objc(addRe_JuiceObject:)
    @NSManaged public func addToRe_Juice(_ value: CoreJuice)

    @objc(removeRe_JuiceObject:)
    @NSManaged public func removeFromRe_Juice(_ value: CoreJuice)

    @objc(addRe_Juice:)
    @NSManaged public func addToRe_Juice(_ values: NSSet)

    @objc(removeRe_Juice:)
    @NSManaged public func removeFromRe_Juice(_ values: NSSet)

}
