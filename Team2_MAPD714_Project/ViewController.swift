//
//  ViewController.swift
//  Team2_MAPD714_Project

//  IoS Development

//  Bhargav Borse 301278352
//  Khanjan Dave 301307330
//  Kajal Patel 301399933


// Description: The goal of our project, the "Cruise App," is to create a thorough and user-friendly mobile application that makes it easier for vacationers to research, pick, and book cruises. This app will enable customers to easily plan their cruise holidays by offering comprehensive cruise information, configurable booking options, secure payment processing, and transparent booking summary. It places a strong emphasis on ease, accessibility, and customer happiness.

// Date last modified: 30/10/2023

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DBmanager()
        db.CreateBookingTable()
        db.createTable()
        db.createCruiseTable()
        let cruises = db.getAllCruises()
        // Print the retrieved cruises to the console
        print("Retrieved cruises: \(cruises)")
        let cruisesData: [(cruisename: String, cruisedescription: String, visitingplaces: String, startdate: String, enddate: String, duration: String, price: Double)] = [
            ("Ocean Cruise", "Explore the vastness of the ocean.", "Various ocean locations", "2023-01-01", "2023-01-10", "6 days - 7 Nights", 1500.0),
            ("Cuba Adventure", "Discover the beauty of Cuba.", "Havana, Varadero, Trinidad", "2023-02-01", "2023-02-10", "9 days - 8 Nights", 1200.0),
            ("Bahamas Paradise", "Relax in the paradise of the Bahamas.", "Nassau, Freeport, Exuma", "2023-03-01", "2023-03-10", "5 days - 6 Nights", 1300.0),
            ("Sampler Cruise", "Sample different locations in one trip.", "Various locations", "2023-04-01", "2023-04-10", "9 days - 10 Nights", 1100.0),
            ("Star Cruise", "Experience luxury under the stars.", "Starry destinations", "2023-05-01", "2023-05-10", "8 days - 9 Nights", 1800.0)
        ]

        db.insertInCruise(cruises: cruisesData)
        
        // Usage example
        let allCruises = db.read()

        for cruise in cruises {
            print("Cruise ID: \(cruise.id), Name: \(cruise.name), Description: \(cruise.description), Places: \(cruise.visitingPlaces), Start Date: \(cruise.startDate), End Date: \(cruise.endDate), Price: \(cruise.price)")
        }
    }
}

