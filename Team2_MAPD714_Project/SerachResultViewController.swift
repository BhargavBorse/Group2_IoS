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

class SerachResultViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cruises: [
    String] = ["Bahamas Cruise",
                      "Caribbean Cruise",
                      "Cuba Cruise",
                      "Sampler Cruise",
                      "Star Cruise"]
       
       let cruiseIamges: [UIImage] = [
       
           UIImage(named: "cruise_home")!,
           UIImage(named: "cruise_home")!,
           UIImage(named: "cruise_home")!,
           UIImage(named: "cruise_home")!,
           UIImage(named: "cruise_home")!,
       ]

    @IBOutlet weak var cruiseViewCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cruiseViewCollection.delegate = self
                cruiseViewCollection.dataSource = self
                
                
        let layout = cruiseViewCollection.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Adjust the inset as needed
            layout.minimumInteritemSpacing = 10 // Adjust the spacing between cells horizontally
            layout.minimumLineSpacing = 10 // Adjust the spacing between rows
            
            // Calculate the width of each cell to fit two cells in a row with spacing
        let cellWidth = (cruiseViewCollection.frame.size.width - 28) / 2.3
        let cellHeight = cellWidth * 1.5 // Adjust the height to your desired aspect ratio
            
            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)


        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in section: \(cruises.count)")
        return cruises.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell

        // Set the cruise name and image for each cell
        print("Cruise name from array: \(cruises[indexPath.item])")

        cell.cruiseLabel.text = cruises[indexPath.item]

        if let cruiseName = cell.cruiseLabel.text {
            // The optional has a value, so you can safely use it
            cell.cruiseLabel.text = cruiseName
        } else {
            // Handle the case where the value is nil or provide a default value
            cell.cruiseLabel.text = "Default Cruise Name"
        }

        cell.cruiseImage.image = cruiseIamges[indexPath.item]

        print("Label text: \(String(describing: cell.cruiseLabel.text))")
        print("Image: \(String(describing: cell.cruiseImage.image))")

        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5

        return cell
    }

}
