// CruiseBookingViewController.swift

//  Team2_MAPD714_Project

//  IoS Development

//  Bhargav Borse 301278352
//  Khanjan Dave 301307330
//  Kajal Patel 301399933


// Description: The goal of our project, the "Cruise App," is to create a thorough and user-friendly mobile application that makes it easier for vacationers to research, pick, and book cruises. This app will enable customers to easily plan their cruise holidays by offering comprehensive cruise information, configurable booking options, secure payment processing, and transparent booking summary. It places a strong emphasis on ease, accessibility, and customer happiness.

// Date last modified:13/11/2023

import UIKit

class CruiseBookingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var scrollView: UIScrollView!
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    var phoneTextField: UITextField!
    var emailTextField: UITextField!
    var addressTextField: UITextField!
    var cityTextField: UITextField!
    var countryTextField: UITextField!
    var adultsTextField: UITextField!
    var kidsTextField: UITextField!
    var seniorsSwitch: UISwitch?
    var over60Label: UILabel!
    var submitButton: UIButton!

    var numberOfAdults: Int = 0
    var numberOfKids: Int = 0
    var isSeniorsTraveling: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the background color
        view.backgroundColor = .white

        // Create a UIScrollView
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .red
        view.addSubview(scrollView)

        // Set up constraints for the scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        // Create form elements
        createForm()

        // Create a navigation bar
        let navBar = UINavigationBar()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)

        // Create a navigation item for the navigation bar
        let navItem = UINavigationItem(title: "Cruise Booking")

        // Create a back button
        let backButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(backButtonTapped))
        navItem.leftBarButtonItem = backButton
        let customColor = UIColor(red: CGFloat(0x26) / 255.0,
                                  green: CGFloat(0x1C) / 255.0,
                                  blue: CGFloat(0x38) / 255.0, alpha: 1.0)
        navBar.barTintColor = customColor
        // Set the text color to white
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white, // Set your desired title color here
            // You can also set other attributes like font, shadow, etc. if needed
        ]
        backButton.tintColor = UIColor.white
        navBar.titleTextAttributes = titleTextAttributes
        
        // Set the navigation item
        navBar.setItems([navItem], animated: false)

        // Set up constraints for the navigation bar
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: scrollView.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])

        // Create label for seniors
        over60Label = UILabel()
        over60Label.text = "Anyone traveling over 60 years"
        over60Label.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(over60Label)

        // Create UISwitch for confirming if anyone is traveling over 60
        seniorsSwitch = UISwitch()
        seniorsSwitch?.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)

        // Add UI elements to the scroll view
        if let seniorsSwitch = seniorsSwitch {
            scrollView.addSubview(seniorsSwitch)

            // Set constraints programmatically (adjust as needed)
            seniorsSwitch.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                kidsTextField.bottomAnchor.constraint(equalTo: over60Label.topAnchor, constant: -20),
                over60Label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                seniorsSwitch.topAnchor.constraint(equalTo: over60Label.bottomAnchor, constant: 8),
                seniorsSwitch.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            ])
        }

        // Create and add the submit button
        submitButton = UIButton(type: .system)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        let customColor1 = UIColor(red: CGFloat(0x26) / 255.0,
                                   green: CGFloat(0x1C) / 255.0,
                                   blue: CGFloat(0x38) / 255.0, alpha: 1.0)
        submitButton.backgroundColor = customColor1
        // Set the text color to white
        submitButton.setTitleColor(.white, for: .normal)
        scrollView.addSubview(submitButton)

        // Set constraints for the submit button
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(greaterThanOrEqualTo: seniorsSwitch!.bottomAnchor, constant: 20),
            submitButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            submitButton.widthAnchor.constraint(equalToConstant: 200),
            submitButton.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            submitButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ])
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateConstraints(for: size)
    }

    func updateConstraints(for size: CGSize) {
        // Update your constraints based on the size and orientation here
        // Example: You may want to adjust the position of certain elements or change their size
        // This will be called when the device orientation changes

        // For simplicity, let's just update the label position in this example
        if size.width > size.height {
            // Landscape
            kidsTextField.bottomAnchor.constraint(equalTo: over60Label.topAnchor, constant: -20).isActive = true
            firstNameTextField.widthAnchor.constraint(equalToConstant: 500).isActive = true
        } else {
            // Portrait
            kidsTextField.bottomAnchor.constraint(equalTo: over60Label.topAnchor, constant: -8).isActive = true
            firstNameTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        }
    }

    func createForm() {
        // Create and add form elements (text fields, radio buttons, etc.) to the scroll view
        // Adjust the frame and styling as needed
        // Example:
        firstNameTextField = createTextField(placeholder: "First Name")
        lastNameTextField = createTextField(placeholder: "Last Name")
        phoneTextField = createTextField(placeholder: "Phone Number")
        emailTextField = createTextField(placeholder: "Email")
        addressTextField = createTextField(placeholder: "Address")
        cityTextField = createTextField(placeholder: "City")
        countryTextField = createTextField(placeholder: "Country")
        adultsTextField = createTextField(placeholder: "Number of Adults")
        kidsTextField = createTextField(placeholder: "Number of Kids")

        scrollView.addSubview(firstNameTextField)
        scrollView.addSubview(lastNameTextField)
        scrollView.addSubview(phoneTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(addressTextField)
        scrollView.addSubview(cityTextField)
        scrollView.addSubview(countryTextField)
        scrollView.addSubview(adultsTextField)
        scrollView.addSubview(kidsTextField)

        // Set constraints programmatically (adjust as needed)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70),
            firstNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//               firstNameTextField.widthAnchor.constraint(equalToConstant: 300),
               firstNameTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
               firstNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ])

        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20),
            lastNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            lastNameTextField.widthAnchor.constraint(equalToConstant: 300),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            lastNameTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            phoneTextField.widthAnchor.constraint(equalToConstant: 300),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            phoneTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addressTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            addressTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            addressTextField.widthAnchor.constraint(equalToConstant: 300),
            addressTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            addressTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            cityTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            cityTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            cityTextField.widthAnchor.constraint(equalToConstant: 300),
            cityTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            cityTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            countryTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            countryTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            countryTextField.widthAnchor.constraint(equalToConstant: 300),
            countryTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            countryTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        adultsTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adultsTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 20),
            adultsTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            adultsTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            adultsTextField.widthAnchor.constraint(equalToConstant: 300),
            adultsTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            adultsTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        kidsTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            kidsTextField.topAnchor.constraint(equalTo: adultsTextField.bottomAnchor, constant: 20),
            kidsTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            kidsTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            kidsTextField.widthAnchor.constraint(equalToConstant: 300),
            kidsTextField.heightAnchor.constraint(equalToConstant: 40), // Adjust the height as needed
            kidsTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])

        // Set the bottom constraint for the scrollView to ensure it can scroll
        let bottomConstraint = kidsTextField.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -20)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
    }

    func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        return textField
    }

    @objc func switchChanged(_ sender: UISwitch) {
        if let seniorsSwitch = seniorsSwitch {
            isSeniorsTraveling = seniorsSwitch.isOn
        }
    }

    @objc func submitButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let paymentViewController = storyboard.instantiateViewController(withIdentifier: "CruisePaymentViewController") as! CruisePaymentViewController
        present(paymentViewController, animated: true, completion: nil)
    }

    @objc func backButtonTapped() {
        print("Back button tapped")
        dismiss(animated: true, completion: nil)
    }

    func redirectToCruiseDetailViewController() {
        if let cruiseDetailsViewController = self.navigationController?.viewControllers.first(where: { $0 is CruiseDetailsViewController }) {
            self.navigationController?.popToViewController(cruiseDetailsViewController, animated: true)
        }
    }

    // MARK: - UIPickerViewDataSource and UIPickerViewDelegate methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10 // Replace with the actual number of rows you want
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Implement logic when a row is selected
    }
}

