//
//  Article+Data.swift
//  NewsReader
//
//  Created by Prasanta Sahu on 08/12/24.
//

import SwiftData


extension Article {
    
    func addItem(context: ModelContext) {
        modelContext?.insert(self)
        do {
            try context.save()
        } catch {
            print("Data save error \(error.localizedDescription)")
        }
    }

    func deleteItem(context: ModelContext) {
        modelContext?.delete(self)
        do {
            try context.save()
        } catch {
            print("Data save error \(error.localizedDescription)")
        }
    }
}
