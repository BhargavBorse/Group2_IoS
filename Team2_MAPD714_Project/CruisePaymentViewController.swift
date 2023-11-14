//
//  CruisePaymentViewController.swift
//  Team2_MAPD714_Project
//
//  IoS Development

//  Bhargav Borse 301278352
//  Khanjan Dave 301307330
//  Kajal Patel 301399933


// Description: The goal of our project, the "Cruise App," is to create a thorough and user-friendly mobile application that makes it easier for vacationers to research, pick, and book cruises. This app will enable customers to easily plan their cruise holidays by offering comprehensive cruise information, configurable booking options, secure payment processing, and transparent booking summary. It places a strong emphasis on ease, accessibility, and customer happiness.



import UIKit

class CruisePaymentViewController: UIViewController {
    var customHeight: CGFloat = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewHeight()
        // Do any additional setup after loading the view.
    }
   

        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            updateViewHeight()
        }

        func updateViewHeight() {
            let orientation = UIDevice.current.orientation

            switch orientation {
            case .portrait, .portraitUpsideDown:
                customHeight = 1000
            case .landscapeLeft, .landscapeRight:
                customHeight = 2000
            default:
                customHeight = 1000
            }

            // Update the frame of your scroll view or any other views as needed
            scrollView.frame.size.height = customHeight

            // You may also need to update the content size of the scroll view if needed
            // scrollView.contentSize = CGSize(width: someWidth, height: customHeight)
        }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
