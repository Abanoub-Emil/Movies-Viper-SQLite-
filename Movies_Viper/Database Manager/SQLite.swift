//
//  SQLite.swift
//  Movies_Viper
//
//  Created by Mai Hassan on 2/12/19.
//  Copyright © 2019 Mai Hassan. All rights reserved.
//

import UIKit
import SQLite3

class SQLiteManager {
    
    static let sharedDBManager = SQLiteManager()
    let createTableString = """
                            CREATE TABLE if not exists Movie(
                            id TEXT PRIMARY KEY NOT NULL,
                            title TEXT,
                            image TEXT,
                            overview TEXT,
                            vote_average TEXT);
                            """
    //    let insertStatementString = """
    //                                    INSERT INTO Movie (id, title, image, overview, vote_average)
    //                                    VALUES (?, ?, ?, ?, ?);
    //                                """
    static func sqliteManager() -> SQLiteManager {
        return sharedDBManager
    }
    
    private init(){}
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("test.sqlite")
        
        // open database
        
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        return db ?? nil
    }
    
    func createTable() {
        let db = openDatabase()
        // 1
        var createTableStatement: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Contact table created.")
            } else {
                print("Contact table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        // 4
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(movie: Movie) {
        print(movie.id!)
        print(movie.title!)
        print(movie.image)
        print(movie.vote_average!)
        let db = openDatabase()
        //        var insertStatement: OpaquePointer? = nil
        
        ///////////////////
        var insertStatement: OpaquePointer? = nil
        let insertStatementString = "INSERT INTO Movie (id, title, image, overview, vote_average) VALUES (?, ?, ?, ?, ?);"

        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let id: NSString = movie.id! as NSString
            let title: NSString = movie.title! as NSString
            let image: NSString = movie.image as NSString
            let overview: NSString = movie.overview! as NSString
            let vote_average: NSString = "\(movie.vote_average ?? 7.0)" as NSString
            // 2
            sqlite3_bind_text(insertStatement, 1, id.utf8String, -1, nil)
            // 3
            sqlite3_bind_text(insertStatement, 2, title.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, image.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, overview.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, vote_average.utf8String, -1, nil)
            
            // 4
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
        
    }
    
    func getCachedMovies() -> [Movie] {
        var allMovies = [Movie]()
        let queryStatementString = "SELECT id, title, image, overview, vote_average FROM Movie;"
        let db = openDatabase()
        var statement: OpaquePointer? = nil
        // 1
        if sqlite3_prepare_v2(db, queryStatementString, -1, &statement, nil) == SQLITE_OK {
            // 2
            while sqlite3_step(statement) == SQLITE_ROW {
                let movie = Movie()
                
                if let cString = sqlite3_column_text(statement, 0) {
                    let name = String(cString: cString)
                    movie.id = name
                    print("id = \(name)")
                } else {
                    print("id not found")
                }
                if let cString0 = sqlite3_column_text(statement, 1) {
                    let title = String(cString: cString0)
                    movie.title = title
                    print("name1 = \(title)")
                } else {
                    print("name1 not found")
                }
                
                if let cString1 = sqlite3_column_text(statement, 2) {
                    let image = String(cString: cString1)
                    movie.image = image
                    print("name2 = \(image)")
                } else {
                    print("name2 not found")
                }
                
                if let cString2 = sqlite3_column_text(statement, 3) {
                    let overview = String(cString: cString2)
                    movie.overview = overview
                    print("name3 = \(overview)")
                } else {
                    print("name3 not found")
                }

                if let cString3 = sqlite3_column_text(statement, 4) {
                    let vote_average = String(cString: cString3)
                    let n = NumberFormatter().number(from: vote_average)
                    movie.vote_average = CGFloat(truncating: n ?? 6.7)
                    print("name4 = \(vote_average)")
                } else {
                    print("name4 not found")
                }
                
                if let cString3 = sqlite3_column_text(statement, -1) {
                    let name = String(cString: cString3)
                    print("name4 = \(name)")
                } else {
                    print("name4 not found")
                }
                
                allMovies.append(movie)
            }
            
            if sqlite3_finalize(statement) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error finalizing prepared statement: \(errmsg)")
            }

            else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        // 6
        return allMovies
    }

}
