//
//  SignInViewController.swift
//  Beer
//
//  Created by Melanie on 10/9/18.
//

import UIKit
import TextFieldEffects

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var username: HoshiTextField!
    @IBOutlet weak var password: HoshiTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderWidth = 2.0
        signInButton.layer.borderColor = UIColor.white.cgColor
        
        let attributedString = NSMutableAttributedString(string:"¿Olvidaste tu contraseña?")
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value: 1.2, range: NSMakeRange(0, attributedString.length))
        forgotPasswordButton.setAttributedTitle(attributedString, for: .normal)
        
        registerKeyboardNotifications()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

extension UITextField {
    func putLayer(textField: UITextField) {
        let border1 = CALayer()
        border1.borderColor = UIColor.white.cgColor
        border1.frame = CGRect(x: 0, y: textField.frame.size.height - 2.0, width: textField.frame.size.width, height: textField.frame.size.height)
        border1.borderWidth = 2.0
        textField.layer.addSublayer(border1)
    }
    
    func customTextField(textField: UITextField, placeholderText: String) {
        textField.layer.masksToBounds = true
        textField.backgroundColor = UIColor.clear
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
}
