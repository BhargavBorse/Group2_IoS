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
    
    // Define variables for storyboard ui elements
    
    @IBOutlet weak var cardnumber: UITextField!
    @IBOutlet weak var cardholdername: UITextField!
    @IBOutlet weak var expirydate: UITextField!
    @IBOutlet weak var cvv: UITextField!
    
    
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
    
    @IBAction func OnClick(_ sender: Any) {
        // Validate payment details before processing payment
        if !validateCardNumber() || !validateCardholderName() || !validateExpiryDate() || !validateCVV() {
            return
            
            cardnumber.text = ""
            cardholdername.text = ""
            expirydate.text = ""
            cvv.text = ""
        }
    }
    
    // Function to validate card number
    private func validateCardNumber() -> Bool {
        guard let cardNumber = cardnumber.text, !cardNumber.isEmpty, cardNumber.isNumeric, cardNumber.count == 16 else {
            showErrorAlert(message: "Please enter a valid 16-digit card number.")
            return false
        }
        return true
    }
    
    // Function to validate cardholder name
    private func validateCardholderName() -> Bool {
        guard let cardHolderName = cardholdername.text, !cardHolderName.isEmpty else {
            showErrorAlert(message: "Please enter the cardholder name.")
            return false
        }
        return true
    }

    // Function to validate expiry date
    private func validateExpiryDate() -> Bool {
        guard let expiryDate = expirydate.text, !expiryDate.isEmpty, expiryDate.matches("^\\d{2}/\\d{2}$") else {
            showErrorAlert(message: "Please enter a valid expiry date in the MM/YY format.")
            return false
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/yy"

        if let enteredDate = dateFormatter.date(from: expiryDate), let currentDate = Calendar.current.date(byAdding: .day, value: 0, to: Date()) {
            if enteredDate < currentDate {
                showErrorAlert(message: "Expiry date should not be before today's date.")
                return false
            }
        }

        return true
    }


    // Function to validate CVV
    private func validateCVV() -> Bool {
        guard let cvvText = cvv.text, !cvvText.isEmpty, cvvText.isNumeric, cvvText.count == 3 else {
            showErrorAlert(message: "Please enter a valid 3-digit CVV.")
            return false
        }
        return true
    }
    
    private func showErrorAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
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

// Extension to check if a string matches a regular expression
extension String {
    func matches(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
