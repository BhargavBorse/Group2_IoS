import UIKit

class LoginControllerViewController: UIViewController {

    // Define variables for storyboard UI elements
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let db = DBmanager()
//        db.getAllBookingData()
        // Do any additional setup after loading the view.
//        let db = DBmanager()
//        db.deleteAllBookingRecords()
    }

    @IBAction func OnClick(_ sender: Any) {
        // Add validation for login screen
        guard let usernameText = username.text, !usernameText.isEmpty,
              let passwordText = password.text, !passwordText.isEmpty else {

            showErrorAlert(message: "Username and password are required.")
            return
        }

        // if user exists or not
        let db = DBmanager() // create an object of the database class
//        db.getAllBookingData()
        
          if let userProfile = db.userLogin(email: usernameText, password: passwordText) {
            // Passing Data From one view controller to another
            let controller = storyboard?.instantiateViewController(identifier: "UserProfileViewController") as! UserProfileViewController

            // Pass username and password to the next view controller
            controller.regusername = usernameText
            controller.regpass = passwordText
            
            // Example: Set a value in UserDefaults
            UserDefaults.standard.set(usernameText , forKey: "username")
              
            // Get login id by email for last screen
            let userdata = db.userdata(email: usernameText)
              print("***********")
              print(userdata?.id)
              print("***********")
              UserDefaults.standard.set(userdata?.id , forKey: "userid")

            // Present the UserProfileViewController
            present(controller, animated: true, completion: nil)
              
              username.text = ""
              password.text = ""
              
        } else {
            showErrorAlert(message: "User does not exist")
            return
        }
    }

    // common function for all error messages
    func showErrorAlert(message: String) {
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
