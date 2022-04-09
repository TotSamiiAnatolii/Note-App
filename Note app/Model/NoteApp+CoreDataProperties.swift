//
//  NoteApp+CoreDataProperties.swift
//  Note app
//
//  Created by APPLE on 26.03.2022.
//
//

import Foundation
import CoreData


extension NoteApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteApp> {
        return NSFetchRequest<NoteApp>(entityName: "NoteApp")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var text: String!

}

extension NoteApp : Identifiable {

}
