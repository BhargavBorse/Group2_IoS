//
//  RegistrationController.swift
//  Team2_MAPD714_Project
//
//  Created by user on 2023-11-26.
//

import UIKit

class RegistrationController: UIViewController {

    // Define variables for storyboard ui elements
    @IBOutlet weak var cname: UITextField!
    @IBOutlet weak var caddress: UITextField!
    @IBOutlet weak var ccity: UITextField!
    @IBOutlet weak var ccountry: UITextField!
    @IBOutlet weak var cphone: UITextField!
    @IBOutlet weak var cemail: UITextField!
    @IBOutlet weak var cpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnClick(_ sender: Any) {
        
        // Name Validation
        guard let name = cname.text, !name.isEmpty else {
            showErrorAlert(message: "Name is required.")
            return
        }
        
        // Address Validation
        guard let address = caddress.text, !address.isEmpty else {
            showErrorAlert(message: "Address is required.")
            return
        }
        
        // City validation
        guard let city = ccity.text, !city.isEmpty else {
            showErrorAlert(message: "City is required.")
            return
        }
        
        // County validation
        guard let country = ccountry.text, !country.isEmpty else {
            showErrorAlert(message: "Country is required.")
            return
        }
        
        // Phone numberrequired validation
        guard let phone = cphone.text, !phone.isEmpty else {
            showErrorAlert(message: "Phone number is required.")
            return
        }
        
        // Validate phone number format (digits only)
        if !phone.isNumeric {
            showErrorAlert(message: "Phone number should contain only digits.")
            return
        }
        
        // phone number length validation
        if phone.count != 10 {
            showErrorAlert(message: "Phone number should be 10 digits.")
            return
        }
        
        // email validation
        guard let email = cemail.text, !email.isEmpty else {
            showErrorAlert(message: "Email is required.")
            return
        }
        
        //  email format vaidation
        if !isValidEmail(email) {
            showErrorAlert(message: "Invalid email format.")
            return
        }
        
        guard let password = cpassword.text, !password.isEmpty else {
            showErrorAlert(message: "Password is required.")
            return
        }
        
        // Validate password length
        if password.count < 6 {
            showErrorAlert(message: "Password should be at least 6 characters.")
            return
        }
        
        // If it passes every validation insert user in database
        let db = DBmanager() // create object of database class
        db.insert(username: name, address: address, city: city, country: country, phonenumber: phone, email: email, password: password)
        
        let controller = storyboard?.instantiateViewController(identifier: "UserProfileViewController") as! UserProfileViewController
            
            // Pass username and password to the next view controller
            controller.regusername = cemail.text
            controller.regpass = cpassword.text
        
        UserDefaults.standard.set(cemail.text , forKey: "username")
            
        
          
        // Get login id by email for last screen
        let userdata = db.userdata(email: cemail.text ?? "")
          print("***********")
          print(userdata?.id)
          print("***********")
          UserDefaults.standard.set(userdata?.id , forKey: "userid")
        
            // Present the UserProfileViewController
            present(controller, animated: true, completion: nil)
        
        
        cname.text = ""
        ccity.text = ""
        ccountry.text = ""
        cemail.text = ""
        cphone.text = ""
        caddress.text = ""
        cphone.text = ""
        cpassword.text = ""
        
    }
    
    // Function for checking email format
    private func isValidEmail(_ email: String) -> Bool {
        // Simple email validation using regular expression
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Common function for all error message
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
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}



extension String {
    var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
