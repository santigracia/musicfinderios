//
//  signupVC.swift
//  musicfinder
//
//  Created by Santi Gracia on 9/3/19.
//  Copyright © 2019 Mixpanel. All rights reserved.
//

import Foundation
import UIKit

class signupVC : UIViewController {
    
    
    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    @IBOutlet weak var passwordLbl: UITextField!
    @IBOutlet weak var genreLbl: UISegmentedControl!
    @IBOutlet weak var planLbl: UISegmentedControl!
    
    override func viewDidLoad() {
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // unwrapping optionals and checking input data in the main thread
        guard let theName = nameLbl.text else { return }
        guard let theEmail = emailLbl.text else { return }
        guard let thePassword = passwordLbl.text else { return }

        var theGenre = ""
        if genreLbl.selectedSegmentIndex == 0 { theGenre = "Classical" }
        else if genreLbl.selectedSegmentIndex == 1 { theGenre = "Electronic" }
        else if genreLbl.selectedSegmentIndex == 2 { theGenre = "Folk" }
        else if genreLbl.selectedSegmentIndex == 3 { theGenre = "Hip-Hop" }
        else if genreLbl.selectedSegmentIndex == 4 { theGenre = "Rock" }
        
        var thePlan = ""
        if planLbl.selectedSegmentIndex == 0 { thePlan = "Free" }
        else if planLbl.selectedSegmentIndex == 1 { thePlan = "Premium" }
        
        
        // network calls in the background
        DispatchQueue.global(qos: .background).async {
            API.signup(name: theName, email: theEmail, password: thePassword, genre: theGenre, plan: thePlan, completion: { (result) in
                print("Sign up for: Name: \(theName) Email: \(theEmail) Password: \(thePassword) Genre: \(theGenre) Plan: \(thePlan)")
                
                // back to the main UI thread
                DispatchQueue.main.async {
                    //if result == "(\"2\");" || result == "(\"0\");" { // FAILED SIGN UP ATTEMPT
                    if result == "{\"result\": 2}" || result == "{\"result\": 0}" { // FAILED SIGN UP ATTEMPT
                        let alert = UIAlertController(title: "Error", message: "Error in sign up process/user exists", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else { // SUCCESS
                        // the ID comes from our backend, we need to parse the result
                        let serverID = result.components(separatedBy: "id")[1].replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ";", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\\", with: "")
                        print(serverID) // this is the ID our backend assigned to this new user
                        
                        UserDefaults.standard.set(theName, forKey: "name")
                        UserDefaults.standard.set(theGenre, forKey: "genre")
                        UserDefaults.standard.set(thePlan, forKey: "plan")
                        UserDefaults.standard.set(theEmail, forKey: "email")
                        UserDefaults.standard.set(thePassword, forKey: "password") // in real app use keychain
                        
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "playerVC") as UIViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                        
//                        let alert = UIAlertController(title: "Success!", message: "Welcome to Music Finder! You are now signed up!", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (a) in }))
//                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
}
