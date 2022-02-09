//
//  EntryController.swift
//  Journal
//
//  Created by Jonmichael Cheung on 2/8/22.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    func createEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, body: body)
        entries.append(newEntry)
        saveToPersistentStorage()
    }
    
    func deleteEntry(entry: Entry){
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage(){
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do{
        let data = try Data(contentsOf: fileURL())
            let entries = try JSONDecoder().decode([Entry].self, from: data)
            self.entries = entries
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}
