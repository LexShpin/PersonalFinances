//
//  WelcomeViewController.swift
//  PersonalFinances
//
//  Created by Alexander Shpin on 11.09.2022.
//

import Foundation
import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet var appLabel: CLTypingLabel!
    
    
    override func viewDidLoad() {
        appLabel.text = "Personal Finances"
        appLabel.charInterval = 0.08
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
    }
    
}
