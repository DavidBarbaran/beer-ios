//
//  ViewController.swift
//  testLottieAnimation
//
//  Created by Melanie on 10/9/18.
//  Copyright © 2018 exercise. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController{
    
    @IBOutlet weak var animatedView: UIView!
    private var boatAnimation: LOTAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boatAnimation = LOTAnimationView(name: "beer")
        boatAnimation?.contentMode = .scaleAspectFill
        boatAnimation?.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        self.animatedView.addSubview(boatAnimation!)
        boatAnimation?.play(completion: { (finish) in
            print(finish)
            if finish {
                let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
                if let log = UserDefaults.standard.object(forKey: "login") as? Bool {
                    if log == false {
                        let signvc = storyboard.instantiateViewController(withIdentifier: "signInVC") as! SignInViewController
                        self.navigationController?.pushViewController(signvc, animated: false)
//                        self.present(signvc,animated: true)
                    }else {
                        let homevc = UIStoryboard(name: "Home", bundle: nil ).instantiateInitialViewController()
                        self.present(homevc!, animated: true)
                    }
                }
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden  = false
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden  = true
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

