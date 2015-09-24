//
//  Note.swift
//  Note
//
//  Created by Tom Giraudet on 09/02/2015.
//  Copyright (c) 2015 Tom Giraudet. All rights reserved.
//

import Foundation
import CoreData

class Note: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var contents: String
    
    // Constructeur
    class func createInManagedObjectContext(moc: NSManagedObjectContext, title: String, contents: String) -> Note {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! Note
        newItem.title = title
        newItem.contents = contents
        
        return newItem
    }

}
