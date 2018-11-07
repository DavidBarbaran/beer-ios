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
                        let signvc = storyboard.instantiateInitialViewController()
                        self.present(signvc!, animated: true)
                    }else {
                        let homevc = UIStoryboard(name: "Home", bundle: nil ).instantiateViewController(withIdentifier: "homeTabBar")
                        self.present(homevc, animated: true)
                    }
                }
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

