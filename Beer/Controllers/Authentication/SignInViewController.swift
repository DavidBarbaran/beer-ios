//
//  SignInViewController.swift
//  Beer
//
//  Created by Melanie on 10/9/18.
//

import UIKit
import TextFieldEffects
import TransitionButton
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var username: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var isLogged = false
    var button = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = signInButton.frame.height / 2
        signInButton.clipsToBounds = true
        signInButton.layer.borderWidth = 2.0
        signInButton.layer.borderColor = UIColor.white.cgColor
        
        let attributedString = NSMutableAttributedString(string:"¿Olvidaste tu contraseña?")
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1.2, range: NSMakeRange(0, attributedString.length))
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        scrollView.isScrollEnabled = false
        registerKeyboardNotifications()
        
        button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_view"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(password.frame.size.width - 25), y: CGFloat(5), width: CGFloat(20), height: CGFloat(12))
        button.addTarget(self, action: #selector(self.showPassword), for: .touchUpInside)
        password.rightView = button
        password.rightViewMode = .always
        password.bringSubview(toFront: button)
        view.bringSubview(toFront: button)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @objc func showPassword() {
        if !(password.text?.isEmpty)! {
            password.isSecureTextEntry = !password.isSecureTextEntry
//            if password.isSecureTextEntry {
//            button.setImage(UIImage(named: "ic_hide"), for: .normal)
//            }else {
//                button.setImage(UIImage(named: "ic_view"), for: .normal)
//            }
        }
        if password.isSecureTextEntry, let text = password.text {
            password.text?.removeAll()
            password.insertText(text)
        }
    }
    
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.isScrollEnabled = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func changeBorderPassword(_ sender: HoshiTextField) {
        sender.placeholderColor = .white
        sender.borderInactiveColor = .white
        sender.borderActiveColor = .white
    }
    
    @IBAction func changeBorderUser(_ sender: HoshiTextField) {
        sender.placeholderColor = .white
        sender.borderInactiveColor = .white
        sender.borderActiveColor = .white
    }
    
    @IBAction func signInAction(_ sender: TransitionButton) {
        sender.titleLabel?.text = ""
        sender.setTitle("", for: .selected)
        sender.setTitle("", for: .normal)
        sender.startAnimation()
        if username.text!.isEmpty && password.text!.isEmpty {
            sender.cornerRadius = sender.frame.height/2
            sender.clipsToBounds = true
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0, completion: {
                self.configOnErrorStyle(sender: sender, value: 0)
            })
        }
        else if username.text!.isEmpty {
            sender.cornerRadius = sender.frame.height/2
            sender.clipsToBounds = true
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0, completion: {
                self.configOnErrorStyle(sender: sender, value: 1)
            })
        }else if password.text!.isEmpty {
            sender.cornerRadius = sender.frame.height/2
            sender.clipsToBounds = true
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0, completion: {
                self.configOnErrorStyle(sender: sender, value: 2)
            })
        }else {
            signIn(userEmail: username.text!, pass: password.text!, sender:  sender)
        }
        
    }
    
    func signIn(userEmail: String, pass: String, sender: TransitionButton) {
        let email = "%22\(userEmail)"
        BeerEndPoint.loginUser(email: email) { (user, error) in
            if let error = error {
                print(error)
                sender.cornerRadius = sender.frame.height/2
                sender.clipsToBounds = true
                sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0, completion: {
                    self.configOnErrorStyle(sender: sender, value: 0)
                })
                return
            }
            
            if let user = user {
                if self.password.text! == user.password {
                    DispatchQueue.main.async {
                        sender.stopAnimation(animationStyle: .expand, revertAfterDelay: 0.0) {
                            let secondVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "homeTabBar")
                            self.present(secondVC, animated: false, completion: nil)
                            self.isLogged = true
                            UserDefaults.standard.set(self.isLogged, forKey: "login")
                            let newUser = ["username" : user.name, "lastname" : user.lastname, "birthdate" : user.birthdate, "urlImage": user.urlImage, "email" : user.email]
                            UserDefaults.standard.setValue(newUser, forKey: "user")
                        }
                    }
                }else {
                    print("Contraseña incorrecta")
                    sender.cornerRadius = sender.frame.height/2
                    sender.clipsToBounds = true
                    sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0, completion: {
                        self.configOnErrorStyle(sender: sender, value: 2)
                    })
                }
            }
        }
        
    }
    
    func configOnErrorStyle(sender: TransitionButton, value: Int) {
        switch value {
        case 0:
            self.username.text = ""
            self.username.borderInactiveColor = .red
            self.username.borderActiveColor = .red
            self.username.placeholderColor = .red
            
            self.password.text = ""
            self.password.borderInactiveColor = .red
            self.password.borderActiveColor = .red
            self.password.placeholderColor = .red
        case 1:
            self.username.borderInactiveColor = .red
            self.username.borderActiveColor = .red
            self.username.placeholderColor = .red
            self.password.text = ""
        default:
            self.password.text = ""
            self.password.borderInactiveColor = .red
            self.password.borderActiveColor = .red
            self.password.placeholderColor = .red
        }
        sender.titleLabel!.text = "INGRESAR"
        sender.setTitle("INGRESAR", for: .selected)
        sender.setTitle("INGRESAR", for: .normal)
    }
}
