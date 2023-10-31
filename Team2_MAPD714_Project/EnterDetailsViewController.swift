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

class EnterDetailsViewController: UIViewController {

    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnYes.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        btnYes.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        btnNo.setImage(UIImage.init(named: "radio-button-off"), for: .normal)
        btnNo.setImage(UIImage.init(named: "radio_button_on"), for: .selected)
        btnYes.isSelected = true
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSelectGender(_ sender: UIButton) {
        if sender == btnYes{
            btnYes.isSelected = true
            btnNo.isSelected = false
        }else{
            btnYes.isSelected = false
            btnNo.isSelected = true
        }
    }

}
