import Foundation
import SQLite
import SQLite3

class SQLiteCommands {
    
    static var tableFavorites = Table("favorites")
    static let id = Expression<Int>("id")
    static let title = Expression<String?>("title")
    static let overview = Expression<String?>("overview")
    static let imageURL = Expression<String?>("imageURL")
    static let votes = Expression<Double?>("votes")
    static let releaseDate = Expression<String?>("releaseDate")
    static let firstAirDate = Expression<String?>("firstAirDate")
    static let nameTV = Expression<String?>("nameTV")
    
    
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            try database.run(tableFavorites.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(title)
                table.column(overview)
                table.column(imageURL)
                table.column(releaseDate)
                table.column(firstAirDate)
                table.column(nameTV)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }

    static func insertRowMovie(_ movieValues: MovieEntity) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
                
        do {
            try database.run(tableFavorites.insert(id <- movieValues.id, title <- movieValues.title, overview <- movieValues.overview, imageURL <- movieValues.imageURL, releaseDate <- movieValues.releaseDate, firstAirDate <- movieValues.firstAirDate, nameTV <- movieValues.nameTV))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    
    static func updateRowMovie(_ movieValues: MovieEntity) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        let movie = tableFavorites.filter(id == movieValues.id).limit(1)

        do {
            if try database.run(movie.update(id <- movieValues.id, title <- movieValues.title, overview <- movieValues.overview, imageURL <- movieValues.imageURL, releaseDate <- movieValues.releaseDate, firstAirDate <- movieValues.firstAirDate, nameTV <- movieValues.nameTV)) > 0 {
                return true
            } else {
                print("Could not update")
                return false
            }
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Update row faild: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Updation failed: \(error)")
            return false
        }
    }
   
    static func presentRowsMovies() -> [MovieEntity]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        var movieArray = [MovieEntity]()
        tableFavorites = tableFavorites.order(id.desc)
        
        do {
            for movie in try database.prepare(tableFavorites) {
                let idValue = movie[id]
                let titleValue = movie[title] ?? nil
                let overviewValue = movie[overview] ?? nil
                let imageURLValue = movie[imageURL] ?? ""
                let releaseDateValue = movie[releaseDate] ?? nil
                let firstAirDateValue = movie[firstAirDate] ?? nil
                let nameTVValue = movie[nameTV] ?? nil
        
                let movieObject = MovieEntity(id: idValue, title: titleValue, overview: overviewValue, imageURL: imageURLValue, releaseDate: releaseDateValue, firstAirDate: firstAirDateValue, nameTV: nameTVValue)
                movieArray.append(movieObject)
                
            }
        } catch {
            print("Present row error: \(error)")
        }
        return movieArray
    }
    
    static func adviseWithRowsMovie(_ movieValues: MovieEntity) -> Bool?{
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        do {
            var exist = false
            for movie in try database.prepare(tableFavorites) {
                let id = movie[id]
                if(id == movieValues.id) {
                    exist = true
                    break
                }
            }
          return exist
        } catch let error {
            print("Updation failed: \(error)")
            return false
        }
    }
    
    static func deleteRowMovie(movieID: Int) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            let movie = tableFavorites.filter(id == movieID).limit(1)
            try database.run(movie.delete())
        } catch {
            print("Delete row error: \(error)")
        }
    }
}
