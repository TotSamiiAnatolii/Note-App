//
//  NoteApp+CoreDataClass.swift
//  Note app
//
//  Created by APPLE on 26.03.2022.
//
//

import Foundation
import CoreData

@objc(NoteApp)
public class NoteApp: NSManagedObject {

    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? "Заголовок"
    }
    
    var textNote: String {
        var lines = text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
        lines.removeFirst()
        return lines.first ?? "Текст заметки"
    }
}
