//
//  loginVC.swift
//  musicfinder
//
//  Created by Santi Gracia on 9/3/19.
//  Copyright © 2019 Mixpanel. All rights reserved.
//

import Foundation
import UIKit

class loginVC : UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // unwrap values from textfields, also this needs to be done in the main UI thread
        guard let theEmail = email.text, let thePassword = password.text else { return }
        
        // network calls done in the background
        DispatchQueue.global(qos: .background).async {
            API.login(email: theEmail, password: thePassword) { (result) in
                // back to the main UI thread after result
                DispatchQueue.main.async {
                    if result == "{\"result\": 2}" || result == "{\"result\": 0}"  { // FAILED LOGIN ATTEMPT
                        let alert = UIAlertController(title: "Error", message: "Error auth", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else { // SUCCESS
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                        let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "playerVC") as UIViewController
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: false, completion: nil)
                        
//                        let alert = UIAlertController(title: "Success!", message: "You are now logged in", preferredStyle: UIAlertController.Style.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

