import Foundation
import SQLite

class SQLiteDatabase {
    static let sharedInstance = SQLiteDatabase()
    var database: Connection?
    
    private init() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("favoritesMovies").appendingPathExtension("sqlite3")
            
            database = try Connection(fileUrl.path)
            
        } catch {
            print("Creating connection to database error: \(error)")
        }
    }
    
    func createTableMovies() {
        SQLiteCommands.createTable()
    }
}
