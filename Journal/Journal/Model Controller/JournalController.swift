//
//  JournalController.swift
//  Journal
//
//  Created by Jonmichael Cheung on 2/9/22.
//

import Foundation

class JournalController {
    
    static let shared = JournalController()
    
    var journals: [Journal] = []
    
    func createJournalWith(title: String){
        let journal = Journal(title: title)
        journals.append(journal)
        saveToPersistentStorage()
    }

    func delete(journal: Journal){
        guard let index = journals.firstIndex(of:journal) else { return }
        journals.remove(at: index)
        saveToPersistentStorage()
    }
    
    func addEntryTo(journal: Journal, entry: Entry){
        journal.entries.append(entry)
        saveToPersistentStorage()
    }
    
    func removeEntryFrom(journal: Journal, entry: Entry){
        guard let index = journal.entries.firstIndex(of:  entry) else { return }
        journal.entries.remove(at: index)
        saveToPersistentStorage()
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Journal.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do{
            let data = try JSONEncoder().encode(journals)
            try data.write(to: fileURL())
        } catch{
            print("\(error.localizedDescription)")
            
        }
    }
    
    func loadFromPersistentStorage() {
        do{
            let data = try Data(contentsOf: fileURL())
            let journals = try JSONDecoder().decode([Journal].self, from: data)
            self.journals = journals
        }catch {
            print("\(error.localizedDescription)")
        }
    }
    
    
}
