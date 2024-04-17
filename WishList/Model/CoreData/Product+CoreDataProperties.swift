//
//  Product+CoreDataProperties.swift
//  WishList
//
//  Created by 김정호 on 4/17/24.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var thumbnail: String?
    @NSManaged public var information: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var price: Int16

}

extension Product : Identifiable {

}
