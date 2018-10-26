//
//  ProfileViewController.swift
//  Beer
//
//  Created by Melanie on 10/26/18.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeSessionAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "login")
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInvc = storyboard.instantiateInitialViewController()
        self.present(signInvc!, animated: true)
        
    }
    
    

}
