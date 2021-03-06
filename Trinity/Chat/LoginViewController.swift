//
//  LoginViewController.swift
//  Trinity
//
//  Created by Fiza Rasool on 18/05/20.
//  Copyright © 2020 Fiza Rasool. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                }
                else {
                    print("Log in was successful!")
                    
                    SVProgressHUD.dismiss()
                    
                    self.performSegue(withIdentifier: "goToTab", sender: self)
                    
                }
            }
            
        }
        
    }
    
}

