//
//  CruiseInfoDetViewController.swift
//  Team2_MAPD714_Project
//
//  IoS Development

//  Bhargav Borse 301278352
//  Khanjan Dave 301307330
//  Kajal Patel 301399933


// Description: The goal of our project, the "Cruise App," is to create a thorough and user-friendly mobile application that makes it easier for vacationers to research, pick, and book cruises. This app will enable customers to easily plan their cruise holidays by offering comprehensive cruise information, configurable booking options, secure payment processing, and transparent booking summary. It places a strong emphasis on ease, accessibility, and customer happiness.

// Date last modified:13/11/2023
import UIKit

class CruiseInfoDetViewController: UIViewController {
    
    var name1: String?
    var address1: String?
    var city1: String?
    var country1: String?
    var email1: String?
    var phonenumber1: String?
    var numberofadults1: Int?
    var numberofkids1: Int?
    var over601: Bool?

    // Define storyboard variables
    @IBOutlet weak var custname: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phonenumber: UILabel!
    @IBOutlet weak var numberofadults: UILabel!
    @IBOutlet weak var numberofkids: UILabel!
    @IBOutlet weak var over60: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var visitingplaces: UILabel!
    @IBOutlet weak var typeofcruise: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cruiseId = UserDefaults.standard.string(forKey: "cruiseId")
            {
            let db = DBmanager()
            print(cruiseId)
            if let cruise = db.getCruiseById(Int(cruiseId) ?? 1) {
                print("Cruise found: \(cruise.name)")
                typeofcruise.text = cruise.name
                visitingplaces.text = cruise.visitingPlaces
                duration.text = cruise.duration
                price.text = "$ \(cruise.price)"
            } else {
                print("Cruise not found.")
            }
        }
        
        // Example: Retrieve a value from UserDefaults
        let ls = UserDefaults.standard.value(forKey: "lastBooking")
        print("dfdjfkjdkfjdkjfkdjfk::::: \(ls)")
        
        if let lastBooking = UserDefaults.standard.value(forKey: "lastBooking") as? Int {
            print("here ---------- \(lastBooking)")
            let db = DBmanager()
            let lastb = String(lastBooking)
            // db.getAllBookingData() // Uncomment if needed
            if let userProfile = db.bookingdata(id: lastb) {
                custname.text = userProfile.firstname
                address.text = userProfile.address
                city.text = userProfile.city
                country.text = userProfile.country
                email.text = userProfile.email
                phonenumber.text = userProfile.phonenumber
                numberofadults.text = userProfile.number_of_adults
                numberofkids.text = userProfile.number_of_kids
                over60.text = userProfile.anyone_over_60
            }
        } else {
            print("Error: Could not retrieve 'lastBooking' from UserDefaults.")
        }
    
        // Do any additional setup after loading the view.
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
