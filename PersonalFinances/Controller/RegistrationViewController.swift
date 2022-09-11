//
//  RegistrationViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        //
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let emailText = emailTextField.text
        let passwordText = passwordTextField.text
        if let email = emailText, let password = passwordText {
            Auth.auth().createUser(withEmail: email, password: password) {authResult , error in
                
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
}
