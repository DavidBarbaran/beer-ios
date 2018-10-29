//
//  ProfileViewController.swift
//  Beer
//
//  Created by Melanie on 10/26/18.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let username = userPreference.sharedInstance.userName , let birthday = userPreference.sharedInstance.userDate, let lastname = userPreference.sharedInstance.userName {
            usernameLabel.text = username
            birthdayLabel.text = birthday
            lastnameLabel.text = lastname
        }
    }
    
    @IBAction func closeSessionAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "login")
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInvc = storyboard.instantiateInitialViewController()
        self.present(signInvc!, animated: true)
        
    }
}
