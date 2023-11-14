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

    var currentPage: Int = 0
    let totalPages: Int = 3
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

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

    // ... (other methods)
}
