//
//  CoreContact+CoreDataProperties.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 4/2/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreContact> {
        return NSFetchRequest<CoreContact>(entityName: "CoreContact")
    }

    @NSManaged public var addressMap: String?
    @NSManaged public var addressOther: String?
    @NSManaged public var addressPrimary: String?
    @NSManaged public var avatarId: String?
    @NSManaged public var externalId: String?
    @NSManaged public var fullName: String
    @NSManaged public var id: String
    @NSManaged public var isDelete: Bool
    @NSManaged public var noteInfo: String?
    @NSManaged public var phone: String?
    @NSManaged public var mode: Int16

}
