//
//  API.swift
//  musicfinder
//
//  Created by Santi Gracia on 9/3/19.
//  Copyright © 2019 Mixpanel. All rights reserved.
//

import Foundation

class API {
    
    static func signup(name: String, email : String, password : String, genre : String, plan : String, completion: @escaping (_ result: NSString) -> Void ) {
        let dest = "https://us-central1-mixpanel-tools.cloudfunctions.net/support-musicfinder-api/auth.php?action=signup&email=" + email + "&password=" + password + "&genre=" + genre + "&plan=" + plan + "&name=" + name
        sendRequest(myURL: dest) { (result) in
            completion(result)
        }
    }
    
    static func login(email: String, password: String, completion: @escaping (_ result: NSString) -> Void ) {
        let dest = "https://us-central1-mixpanel-tools.cloudfunctions.net/support-musicfinder-api/auth.php?action=login&email=" + email + "&password=" + password
        sendRequest(myURL: dest) { (result) in
            completion(result)
        }
    }
    
    static func sendRequest(myURL : String, completionHandler: @escaping (_ result: NSString) -> Void) {
        let url = URL(string: myURL)
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            guard let data = data, error == nil else { return }
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "error")
            completionHandler(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "2")
        }
        task.resume()
    }
    
}
