//
//  CruiseDetailsViewController.swift
//  Team2_MAPD714_Project

//  IoS Development

//  Bhargav Borse 301278352
//  Khanjan Dave 301307330
//  Kajal Patel 301399933
//
//  Created by Khanjan Dave on 2023-11-12.
//

import UIKit

class CruiseDetailsViewController: UIViewController {

    var customHeight: CGFloat = 1000

    @IBOutlet weak var pageviewController: UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var CruiseName: UILabel!

    
//    @IBOutlet weak var CruiseDescription: UILabel!
      @IBOutlet weak var VisitingPlaces: UILabel!
      @IBOutlet weak var Duration: UILabel!
      @IBOutlet weak var StartEndDate: UILabel!
      @IBOutlet weak var CruisePrice: UILabel!
    var currentPage: Int = 0
    let totalPages: Int = 3
    var timer: Timer?
    
    var receivedData: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DBmanager()
        
        // get selected cruise id
        print("Selected Cruise ID: \(String(describing: receivedData))")
        
        if let cruiseID = receivedData {
            print("Selected Cruise ID: \(cruiseID)")
            if receivedData != 0 {
                if let cruise = db.getCruiseById(cruiseID) {
                    print("Cruise found: \(cruise.name)")
                    CruiseName.text = cruise.name
                    VisitingPlaces.text = cruise.visitingPlaces
                    Duration.text = cruise.duration
                    StartEndDate.text = "\(cruise.startDate) - \(cruise.endDate)"
                    CruisePrice.text = "$ \(cruise.price)"
                } else {
                    print("Cruise not found.")
                }
            } else {
                print("No Cruise ID found in UserDefaults")
            }
        } else {
            print("Received data is nil.")
        }
        
        
        
        // Do any additional setup after loading the view.
        pageviewController.numberOfPages = totalPages
        pageControlValueChanged(pageviewController)

        // Set up a timer for auto slide every 2 seconds
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { _ in
            // Code to execute during the transition
            self.updateViewDuringTransition(size: size)
        }, completion: { _ in
            // Code to execute after the transition
            self.deviceOrientationChanged()
        })
    }

    func updateViewDuringTransition(size: CGSize) {
        // Get the current device orientation
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation

        // Set the custom height based on the orientation
        switch orientation {
        case .portrait, .portraitUpsideDown:
            customHeight = 1000
        case .landscapeLeft, .landscapeRight:
            customHeight = 2000
        default:
            customHeight = 1000
        }

        // Apply the new height to your view
        view.frame.size.height = customHeight

        // Additional code related to the transition, if needed
    }

    func deviceOrientationChanged() {
        // Code to execute after the device orientation has changed
        // This could include additional updates or handling specific to the orientation change
    }

    @objc func autoSlide() {
        currentPage = (currentPage + 1) % totalPages
        pageviewController.currentPage = currentPage
        pageControlValueChanged(pageviewController)
    }

    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let pageNumber = sender.currentPage

        // Set a default image for page 1
        var imageName = "cruise_image1"

        // For pages other than 1, use the dynamic image names
        if pageNumber > 0 {
            imageName = "cruise_image\(pageNumber + 1)"
        }

        imageView.image = UIImage(named: imageName)
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func goToCustomerDetailsAddPage(_ sender: Any) {
        let viewController = CruiseBookingViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}


//-----------------------------------------------------------------------

//import UIKit
//
//class CruiseDetailsViewController: UIViewController {
//
//    var customHeight: CGFloat = 1000
//    
//    var receivedData: Int?
//
//    @IBOutlet weak var pageviewController: UIPageControl!
//    @IBOutlet weak var imageView: UIImageView!
//
//    var currentPage: Int = 0
//    let totalPages: Int = 3
//    var timer: Timer?
//
//    @IBOutlet weak var CruiseName: UILabel!
//    @IBOutlet weak var CruiseDescription: UILabel!
//    @IBOutlet weak var VisitingPlaces: UILabel!
//    @IBOutlet weak var Duration: UILabel!
//    @IBOutlet weak var StartEndDate: UILabel!
//    @IBOutlet weak var CruisePrice: UILabel!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let db = DBmanager()
////        let selectedCruiseID = UserDefaults.standard.value(forKey: "selectedid")
////        print("Selected Cruise ID: \(String(describing: lastBooking))")
//        if let selectedCruiseID = UserDefaults.standard.value(forKey: "selectedid"){
//            print("Selected Cruise IDDDDDDDDD: \(receivedData)")
//            if let cruise = db.getCruiseById(selectedCruiseID as! Int) {
//                print("Cruise found: \(cruise.name), Description: \(cruise.description), Price: \(cruise.price)")
//                CruiseName.text = cruise.name
//                CruiseDescription.text = cruise.description
//                VisitingPlaces.text = cruise.visitingPlaces
//                Duration.text = cruise.duration
//                StartEndDate.text = "\(cruise.startDate) - \(cruise.endDate)"
//                CruisePrice.text = String(cruise.price)
//
//            } else {
//                print("Cruise not found.")
//            }
//        } else {
//            print("No Cruise ID found in CruiseManager")
//        }
//
//        pageviewController.numberOfPages = totalPages
//        setCustomHeightForView()
//
//        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
//    }
//
//    func setCustomHeightForView() {
//        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
//        switch orientation {
//        case .portrait, .portraitUpsideDown:
//            customHeight = 1000
//        case .landscapeLeft, .landscapeRight:
//            customHeight = 2000
//        default:
//            customHeight = 1000
//        }
//        view.frame.size.height = customHeight
//    }
//
//    @objc func autoSlide() {
//        currentPage = (currentPage + 1) % totalPages
//        pageviewController.currentPage = currentPage
//        pageControlValueChanged(pageviewController)
//    }
//
//    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
//        let pageNumber = sender.currentPage
//        var imageName = "cruise_image1"
//
//        if pageNumber > 0 {
//            imageName = "cruise_image\(pageNumber + 1)"
//        }
//
//        imageView.image = UIImage(named: imageName)
//    }
//
//    @IBAction func backButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func goToCustomerDetailsAddPage(_ sender: Any) {
//        let viewController = CruiseBookingViewController()
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: true, completion: nil)
//    }
//}
