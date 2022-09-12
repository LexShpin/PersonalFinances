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
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        //
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) {authResult , error in
                if let error = error {
                    self.errorLabel.text = error.localizedDescription
                } else {
                    self.errorLabel.text = ""
                    self.performSegue(withIdentifier: K.registrationSegue, sender: self)
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
}
