//
//  ProductsList+CoreDataProperties.swift
//  VapingApp
//
//  Created by iOSayed on 17/12/2022.
//
//

import Foundation
import CoreData


extension ProductsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsList> {
        return NSFetchRequest<ProductsList>(entityName: "ProductsList")
    }

    @NSManaged public var id: [Int]
    @NSManaged public var productDescription: [String]
    @NSManaged public var width: [Int]
    @NSManaged public var height: [Int]
    @NSManaged public var url: [String]
    @NSManaged public var price: [Int]

}

extension ProductsList : Identifiable {

}
