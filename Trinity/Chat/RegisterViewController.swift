//
//  RegisterViewController.swift
//  Trinity
//
//  Created by Fiza Rasool on 18/05/20.
//  Copyright © 2020 Fiza Rasool. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        //SVProgressHUD.show()
        if let _ = emailTextfield.text, let _ = passwordTextfield.text {
            Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {
                (user, error) in
                
                if error != nil {
                    print("The error is : \(String(describing: error))")
                }
                else {
                    print("Registration Successful!")
                    
                    //SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "goToTab", sender: self)
                }
            }
        }
        
    }
}
