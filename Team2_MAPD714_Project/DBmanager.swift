//
//  DBmanager.swift
//  Team2_MAPD714_Project
//
//  Created by user on 2023-11-27.

import Foundation
import SQLite3

//Data class – model. – Product.swift
class UserProfile {
 
    //Data variables which represents the fields of Product table
    var id: Int
    var username: String?
    var address: String?
    var city: String?
    var country: String?
    var phonenumber: String?
    var email: String?
    var password: String?
 
    //Initializing data variables using a constructor
    init(id: Int, username: String?, address: String?, city: String?, country: String?, phonenumber: String?, email: String?, password: String?){
        self.id = id
        self.username = username
        self.address = address
        self.city = city
        self.country = country
        self.phonenumber = phonenumber
        self.email = email
        self.password = password
    }
}

//Data class – model. – Product.swift
class BookingInfo {

    //Data variables which represents the fields of Product table
    var id: Int
    var address: String?
    var city: String?
    var country: String?
    var phonenumber: String?
    var email: String?
    var firstname: String?
    var lastname: String?
    var number_of_adults: String?
    var number_of_kids: String?
    var anyone_over_60: String?
    var userid: Int
    
    //Initializing data variables using a constructor
    init(id: Int, address: String?, city: String?, country: String?, phonenumber: String?, email: String?, firstname: String?, lastname: String?, number_of_adults: String?, number_of_kids: String?, anyone_over_60: String?, userid: Int){
        self.id = id
        self.address = address
        self.city = city
        self.country = country
        self.phonenumber = phonenumber
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.number_of_adults = number_of_adults
        self.number_of_kids = number_of_kids
        self.anyone_over_60 = anyone_over_60
        self.userid = userid
    }
}

// For Cruise Info
class CruiseInfo {
    var id: Int
    var name: String
    var description: String
    var visitingPlaces: String
    var startDate: String
    var endDate: String
    var duration: String
    var price: Double

    init(id: Int, name: String, description: String, visitingPlaces: String, startDate: String, endDate: String, duration: String, price: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.visitingPlaces = visitingPlaces
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.price = price
    }
}


class DBmanager{
    
    init()
    {
        db = openDatabase()
        createTable()
    }
    
    let dbPath: String = "MyDb.sql"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            debugPrint("could not open database")
            return nil
        }
        else
        {
            print("Database connected to database sucessfully")
            return db
        }
    }
    
    
    // User Table
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT,username TEXT ,address TEXT ,city TEXT ,country TEXT ,phonenumber TEXT ,email TEXT ,password TEXT );"
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("User table created successfully!")
            } else {
                print("User table failed!")
            }
        } else {
            print("Failed to perform CREATE TABLE statement.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Create Cruise Table
    func createCruiseTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS CruiseEntries (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                cruisename TEXT,
                cruisedescription TEXT,
                visitingplaces TEXT,
                startdate TEXT,
                enddate TEXT,
                duration TEXT,
                price REAL
            );
        """
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("CruiseEntries table created successfully!")
            } else {
                print("CruiseEntries table creation failed!")
            }
        } else {
            print("Failed to perform CREATE Cruise TABLE statement.")
        }
        sqlite3_finalize(createTableStatement)
    }

    // Insert into cruise table
    func insertInCruise(cruises: [(cruisename: String, cruisedescription: String, visitingplaces: String, startdate: String, enddate: String, duration: String, price: Double)]) {
        let insertStatementString = "INSERT INTO CruiseEntries (cruisename, cruisedescription, visitingplaces, startdate, enddate, duration, price) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            for cruise in cruises {
                sqlite3_bind_text(insertStatement, 1, (cruise.cruisename as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, (cruise.cruisedescription as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, (cruise.visitingplaces as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, (cruise.startdate as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, (cruise.enddate as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, (cruise.duration as NSString).utf8String, -1, nil)
                sqlite3_bind_double(insertStatement, 7, cruise.price)
                
                if sqlite3_step(insertStatement) != SQLITE_DONE {
                    print("Couldn't add a row for cruise \(cruise.cruisename)")
                }
                
                sqlite3_reset(insertStatement)
            }
            
            print("All cruises added successfully!")
        } else {
            print("INSERT statement failed to succeed!!!")
        }
        
        sqlite3_finalize(insertStatement)
    }

    // Function to retrieve all cruises from the database
    func getAllCruises() -> [CruiseInfo] {
        var cruises: [CruiseInfo] = []
        let queryStatementString = "SELECT * FROM CruiseEntries;"

        var queryStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let places = String(cString: sqlite3_column_text(queryStatement, 3))
                let startDate = String(cString: sqlite3_column_text(queryStatement, 4))
                let endDate = String(cString: sqlite3_column_text(queryStatement, 5))
                let duration = String(cString: sqlite3_column_text(queryStatement, 6))
                let price = sqlite3_column_double(queryStatement, 7)

                let cruise = CruiseInfo(
                    id: Int(id),
                    name: name,
                    description: description,
                    visitingPlaces: places,
                    startDate: startDate,
                    endDate: endDate,
                    duration: duration,
                    price: price
                )

                cruises.append(cruise)
            }
        } else {
            print("SELECT statement for cruises failed!")
        }

        sqlite3_finalize(queryStatement)

        return cruises
    }

    // Function to retrieve a specific cruise by ID from the database
    func getCruiseById(_ cruiseId: Int) -> CruiseInfo? {
        let queryStatementString = "SELECT * FROM CruiseEntries WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var cruise: CruiseInfo?

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // Bind the parameter (cruiseId) to the prepared statement
            sqlite3_bind_int(queryStatement, 1, Int32(cruiseId))

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                let description = String(cString: sqlite3_column_text(queryStatement, 2))
                let places = String(cString: sqlite3_column_text(queryStatement, 3))
                let startDate = String(cString: sqlite3_column_text(queryStatement, 4))
                let endDate = String(cString: sqlite3_column_text(queryStatement, 5))
                let duration = String(cString: sqlite3_column_text(queryStatement, 6))
                let price = sqlite3_column_double(queryStatement, 7)

                cruise = CruiseInfo(
                    id: Int(id),
                    name: name,
                    description: description,
                    visitingPlaces: places,
                    startDate: startDate,
                    endDate: endDate,
                    duration: duration,
                    price: price
                )
            } else {
                print("No cruise found with ID: \(cruiseId)")
            }
        } else {
            print("SELECT statement for a specific cruise by ID failed!")
        }

        sqlite3_finalize(queryStatement)

        return cruise
    }

    
    // Create Bookign Table
    func CreateBookingTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS BookingEntries (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                address TEXT,
                city TEXT,
                country TEXT,
                phonenumber TEXT,
                email TEXT,
                firstname TEXT,
                lastname TEXT,
                number_of_adults TEXT,
                number_of_kids TEXT,
                anyone_over_60 TEXT,
                userid INTEGER,
                FOREIGN KEY(userid) REFERENCES User(id)
            );
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("BookingEntries table created successfully!")
            } else {
                print("BookingEntries table creation failed!")
            }
        } else {
            print("Failed to perform CREATE TABLE statement.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // insert data in insert booking table
    func insertInBooking(address:String, city:String, country:String, phonenumber:String, email:String, firstname:String, lastname:String, number_of_adults:String, number_of_kids:String, anyone_over_60:String, userid:Int ) -> Int {
        let insertStatementString = "INSERT INTO BookingEntries (address, city, country, phonenumber, email, firstname,lastname,number_of_adults, number_of_kids, anyone_over_60, userid) VALUES (?, ?, ?, ?, ?, ?, ?, ? ,? ,?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (country as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (phonenumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (firstname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (lastname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (number_of_adults as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (number_of_kids as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (anyone_over_60 as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 11, Int32(userid))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("A Booking successfully!")
                let lastRowID = Int(sqlite3_last_insert_rowid(db))
                return lastRowID
            } else {
                print("Couldn't add any row?")
            }
        } else {
            print("INSERT Booking statement failed to succeed!!!")
        }
        sqlite3_finalize(insertStatement)
        return -1
    }

    
    func bookingdata(id: String) -> BookingInfo? {
        let queryStatementString = "SELECT * FROM BookingEntries WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var userProfile: BookingInfo? = nil

        print("Executing SQL query: \(queryStatementString)")

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // Bind the parameter (id) to the SQL query
            sqlite3_bind_text(queryStatement, 1, (id as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {

                let id = sqlite3_column_int(queryStatement, 0)
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let phonenumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let useremail = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let firstname = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                var lastname = "no last name"
                let number_of_adults = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let number_of_kids = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let anyone_over_60 = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let userid = sqlite3_column_int(queryStatement, 11)
                

                // Directly assign values to userProfile
                userProfile = BookingInfo(
                    id: Int(id),
                    address: address,
                    city: city,
                    country: country,
                    phonenumber: phonenumber,
                    email: useremail,
                    firstname: firstname,
                    lastname: lastname,
                    number_of_adults: number_of_adults,
                    number_of_kids: number_of_kids,
                    anyone_over_60: anyone_over_60,
                    userid: Int(userid)
                    )

                print("Booking Details using email:")
                print("\(id) | \(address) | \(city) | \(country) | \(phonenumber) | \(useremail) | \(firstname) | \(lastname) | \(number_of_adults) | \(number_of_kids) | \(anyone_over_60)")
            } else {
                print("Booking with ID \(id) not found.")
            }
        } else {
            print("SELECT statement failed to proceed!!! Error: \(sqlite3_errmsg(db)!)")
        }

        sqlite3_finalize(queryStatement)
        return userProfile
    }



    
    // Function to get all booking data
    func getAllBookingData() -> [BookingInfo] {
        print("Booking Details:")
        let queryStatementString = "SELECT * FROM BookingEntries;"
        var queryStatement: OpaquePointer? = nil
        var bookingInfoArray: [BookingInfo] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let address = "no address"
                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let phonenumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let useremail = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let firstname = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                var lastname = "no last name"
                let number_of_adults = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let number_of_kids = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let anyone_over_60 = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let userid = sqlite3_column_int(queryStatement, 11)

                // Create BookingInfo instance and append to array
                let userProfile = BookingInfo(
                    id: Int(id),
                    address: address,
                    city: city,
                    country: country,
                    phonenumber: phonenumber,
                    email: useremail,
                    firstname: firstname,
                    lastname: lastname,
                    number_of_adults: number_of_adults,
                    number_of_kids: number_of_kids,
                    anyone_over_60: anyone_over_60,
                    userid: Int(userid) // Corrected this line
                )

                bookingInfoArray.append(userProfile)

                // Print details (optional)
                print("Booking Details:")
                print("\(id) | \(address) | \(city) | \(country) | \(phonenumber) | \(useremail) | \(firstname) | \(lastname) | \(number_of_adults) | \(number_of_kids) | \(anyone_over_60)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }

        sqlite3_finalize(queryStatement)
        return bookingInfoArray
    }

    func deleteAllBookingRecords() {
        let deleteStatementString = "DELETE FROM BookingEntries;"

        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("All booking records deleted successfully.")
            } else {
                print("Failed to delete booking records.")
            }
        } else {
            print("DELETE statement failed to proceed!!!")
        }
        sqlite3_finalize(deleteStatement)
    }


    
    // insert data in user data
    func insert(username:String, address:String, city:String, country:String, phonenumber:String, email:String, password:String) {
        let insertStatementString = "INSERT INTO User (username, address, city, country, phonenumber, email,password) VALUES (?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (country as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (phonenumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("A user added successfully!")
            } else {
                print("Couldn't add any row?")
            }
        } else {
            print("INSERT statement failed to succeed!!!")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Function to get all data
    func read() -> [UserProfile] {
        print("User Details:")
        let queryStatementString = "SELECT * FROM user"
        var queryStatement: OpaquePointer? = nil
        var prods : [UserProfile] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let phonenumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))

                prods.append(UserProfile(id: Int(id), username: username, address: address, city: city, country: country, phonenumber: phonenumber, email: email, password: password))

                print("User Details:")
                print("\(id) | \(username) | \(address) | \(city) | \(country) | \(phonenumber) | \(email) | \(password)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return prods
    }

    // Retrive data from user table
    func userdata(email: String) -> UserProfile? {
        let queryStatementString = "SELECT * FROM User WHERE email = ?;"
        var queryStatement: OpaquePointer? = nil
        var userProfile: UserProfile? = nil

        print("Executing SQL query: \(queryStatementString)")

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // Bind the parameter (email) to the SQL query
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let fetchedUsername = String(cString: sqlite3_column_text(queryStatement, 1))
                let address = String(cString: sqlite3_column_text(queryStatement, 2))
                let city = String(cString: sqlite3_column_text(queryStatement, 3))
                let country = String(cString: sqlite3_column_text(queryStatement, 4))
                let phonenumber = String(cString: sqlite3_column_text(queryStatement, 5))
                let fetchedEmail = String(cString: sqlite3_column_text(queryStatement, 6))
                let password = String(cString: sqlite3_column_text(queryStatement, 7))

                userProfile = UserProfile(id: Int(id), username: fetchedUsername, address: address, city: city, country: country, phonenumber: phonenumber, email: fetchedEmail, password: password)

                print("User Details using email:")
                print("\(id) | \(fetchedUsername) | \(address) | \(city) | \(country) | \(phonenumber) | \(fetchedEmail) | \(password)")
            } else {
                print("User with email \(email) not found.")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }

        sqlite3_finalize(queryStatement)
        return userProfile
    }
    
    // UserData Check for login validation
    func userLogin(email: String, password: String) -> UserProfile? {
        let queryStatementString = "SELECT * FROM User WHERE email = ? AND password = ?;"
        var queryStatement: OpaquePointer? = nil
        var userProfile: UserProfile? = nil

        print("Executing SQL query: \(queryStatementString)")

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // Bind the parameters (email, password) to the SQL query
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)

            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let fetchedUsername = String(cString: sqlite3_column_text(queryStatement, 1))
                let address = String(cString: sqlite3_column_text(queryStatement, 2))
                let city = String(cString: sqlite3_column_text(queryStatement, 3))
                let country = String(cString: sqlite3_column_text(queryStatement, 4))
                let phonenumber = String(cString: sqlite3_column_text(queryStatement, 5))
                let fetchedEmail = String(cString: sqlite3_column_text(queryStatement, 6))
                let fetchedPassword = String(cString: sqlite3_column_text(queryStatement, 7))

                userProfile = UserProfile(id: Int(id), username: fetchedUsername, address: address, city: city, country: country, phonenumber: phonenumber, email: fetchedEmail, password: fetchedPassword)

                print("User Details using email and password:")
                print("\(id) | \(fetchedUsername) | \(address) | \(city) | \(country) | \(phonenumber) | \(fetchedEmail) | \(fetchedPassword)")
            } else {
                print("User with email \(email) and password not found.")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }

        sqlite3_finalize(queryStatement)
        return userProfile
    }
    
    // Update profile page
    func updateUserProfile(email: String, newProfile: UserProfile) -> Bool {
        let updateStatementString = """
            UPDATE User
            SET username = ?,
                address = ?,
                city = ?,
                country = ?,
                phonenumber = ?,
                password = ?
            WHERE email = ?;
        """

        var updateStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            // Bind parameters
            sqlite3_bind_text(updateStatement, 1, (newProfile.username! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (newProfile.address! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (newProfile.city! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (newProfile.country! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 5, (newProfile.phonenumber! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 6, (newProfile.password! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 7, (email as NSString).utf8String, -1, nil)

            // Execute the update statement
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("User profile updated successfully.")
                sqlite3_finalize(updateStatement)
                return true
            } else {
                print("Failed to update user profile. SQLite Error: \(String(describing: sqlite3_errmsg(db)))")
            }
        } else {
            print("Failed to prepare update statement. SQLite Error: ")
        }

        sqlite3_finalize(updateStatement)
        return false
    }

}
