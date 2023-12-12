//
//  UserProfileViewController.swift
//  Team2_MAPD714_Project
//
//  Created by user on 2023-11-26.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // Getting Username from registration
    var regusername: String?
    var regpass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = DBmanager() // create object of database class

        if let userProfile = db.userdata( email: regusername ?? "" ) {
            // Access the user data properties
            username.text = userProfile.username
            address.text = userProfile.address
            city.text = userProfile.city
            country.text = userProfile.country
            phonenumber.text = userProfile.phonenumber
            email.text = userProfile.email
            password.text = userProfile.password
        } else {
            print("User not found or an error occurred.")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func editButtonClick(_ sender: Any) {
        let db = DBmanager() // create object of database class
        let updatedProfile = UserProfile(
            id: 0, // You can set it to any value since it's not being updated
            username: username.text,
            address: address.text,
            city: city.text,
            country: country.text,
            phonenumber: phonenumber.text,
            email: email.text, // The email of the user you want to update
            password: password.text
        )

        let updateSuccess = db.updateUserProfile(email: regusername ?? "", newProfile: updatedProfile)
        
        if updateSuccess {
            let alert = UIAlertController(title: "Alert", message: "Detailes Updated", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            print("Failed to update profile.")
        }
        
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
