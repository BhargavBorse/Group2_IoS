//
//  ViewController.swift
//  Team2_MAPD714_Project

//  IoS Development

//  Bhargav Borse 301278352
//  Khanjan Dave 301307330
//  Kajal Patel 301399933


// Description: The goal of our project, the "Cruise App," is to create a thorough and user-friendly mobile application that makes it easier for vacationers to research, pick, and book cruises. This app will enable customers to easily plan their cruise holidays by offering comprehensive cruise information, configurable booking options, secure payment processing, and transparent booking summary. It places a strong emphasis on ease, accessibility, and customer happiness.

// Date last modified: 30/10/2023



//import UIKit
//import SQLite3
//import Foundation
//
//class SerachResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    let dbManager = DBmanager()
//    var cruises: [CruiseInfo] = [] // Use CruiseInfo instead of String
//
//    let cruiseIamges: [UIImage] = [
//        UIImage(named: "OceanCruiseImage")!,
//        UIImage(named: "CubaCruiseImage")!,
//        UIImage(named: "BahamasCruiseImage")!,
//        UIImage(named: "SamplerCruiseImage")!,
//        UIImage(named: "StarCruiseImage")!,
//    ]
//
//    @IBOutlet weak var backButton: UILabel!
//    @IBOutlet weak var cruiseViewCollection: UICollectionView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        backButton.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
//        backButton.addGestureRecognizer(tapGesture)
//
//        cruiseViewCollection.delegate = self
//        cruiseViewCollection.dataSource = self
//
//        let layout = cruiseViewCollection.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//
//        let cellWidth = cruiseViewCollection.frame.size.width - 20
//        let cellHeight = cellWidth * 0.6
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//
//        // Fetch cruise data from the database
//        cruises = dbManager.getAllCruises()
//
//        // Reload the collection view to reflect the updated data
////        cruiseViewCollection.reloadData()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cruises.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//
//        cell.cruiseLabel.text = cruises[indexPath.item].name
//
//        if let cruiseName = cell.cruiseLabel.text {
//            cell.cruiseLabel.text = cruiseName
//        } else {
//            cell.cruiseLabel.text = "Default Cruise Name"
//        }
//
//        cell.cruiseImage.image = cruiseIamges[indexPath.item]
//        cell.layer.borderColor = UIColor.lightGray.cgColor
//        cell.layer.borderWidth = 0.5
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Handle cell selection, and pass cruise ID to another view controller
//        let selectedCruiseID = cruises[indexPath.item].id
//        
//        UserDefaults.standard.set(selectedCruiseID, forKey: "SelectedCruiseID")
//
//        // Navigate to another view controller, e.g., perform segue or push
//        let controller = storyboard?.instantiateViewController(identifier: "CruiseDetailsViewController") as! CruiseDetailsViewController
//            
//            // Present the UserProfileViewController
//            present(controller, animated: true, completion: nil)
//    }
//
//    @objc func buttonAction() {
//        dismiss(animated: true, completion: nil)
//    }
//}
//


import UIKit

class CruiseManager {
    static let shared = CruiseManager()

    var selectedCruiseID: Int?

    private init() {}
}

class SerachResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let dbManager = DBmanager()
    var cruises: [CruiseInfo] = []
    var selectedCruiseID: Int?

    let cruiseIamges: [UIImage] = [
        UIImage(named: "OceanCruiseImage")!,
        UIImage(named: "CubaCruiseImage")!,
        UIImage(named: "BahamasCruiseImage")!,
        UIImage(named: "SamplerCruiseImage")!,
        UIImage(named: "StarCruiseImage")!,
    ]

    @IBOutlet weak var backButton: UILabel!
    @IBOutlet weak var cruiseViewCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonAction))
        backButton.addGestureRecognizer(tapGesture)

        cruiseViewCollection.delegate = self
        cruiseViewCollection.dataSource = self

        let layout = cruiseViewCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let cellWidth = cruiseViewCollection.frame.size.width - 20
        let cellHeight = cellWidth * 0.6
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        cruises = dbManager.getAllCruises()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cruises.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell

        cell.cruiseLabel.text = cruises[indexPath.item].name

        if let cruiseName = cell.cruiseLabel.text {
            cell.cruiseLabel.text = cruiseName
        } else {
            cell.cruiseLabel.text = "Default Cruise Name"
        }

        cell.cruiseImage.image = cruiseIamges[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
//        cruiseId(id:cruises[indexPath.item].id)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedID = cruises[indexPath.item].id
        cruiseId(id: selectedID)
    }

    func cruiseId(id: Int) {
        print(id)
        if id > 0 {
            print("if")
            let controller = storyboard?.instantiateViewController(withIdentifier: "CruiseDetails") as! CruiseDetailsViewController
            controller.receivedData = id
            present(controller,animated: true,completion: nil)
            UserDefaults.standard.set(id, forKey: "cruiseId")
        } else {
            // Handle the case when the selected ID is invalid
            // For example, display an alert or perform other actions
            print("Invalid cruise ID")
        }
    }


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "searchResult" {
//            if let selectedCruiseID = sender as? Int {
//                if let cruiseDetailsVC = segue.destination as? CruiseDetailsViewController {
//                    cruiseDetailsVC.receivedData = selectedCruiseID
//                }
//            }
//        }
//    }


    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
////        CruiseManager.shared.selectedCruiseID = selectedCruiseID
//        // Example: Set a value in UserDefaults
//        print("------")
//        print(selectedCruiseID)
//        print("------")
////        UserDefaults.standard.set("" , forKey: "selectedid")
//        UserDefaults.standard.set(selectedCruiseID , forKey: "selectedid")
//        navigateToCruiseDetailsWithDelay()
//    }

    @objc func buttonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
