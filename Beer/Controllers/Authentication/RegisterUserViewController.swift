//
//  RegisterUserViewController.swift
//  Beer
//
//  Created by Melanie on 10/17/18.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON
import TransitionButton

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var dateTextField: HoshiTextField!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var lastnameTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var signUpButton: TransitionButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        dateTextField.delegate = self
        addDatePicker()
        let tapCloseKeyboard = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard(_:)))
        view.addGestureRecognizer(tapCloseKeyboard)
        scrollView.isScrollEnabled = false
        registerKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
    
    func addDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action:#selector(self.changeDatePicker(datepicker:)), for: .valueChanged)
        dateTextField.inputView = datePicker
        datePicker?.backgroundColor = .white
    }
    
    @objc func closeKeyBoard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func changeDatePicker(datepicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateTextField.text = dateFormatter.string(from: datepicker.date)
        dateTextField.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        dateTextField.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        dateTextField.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        
    }
    
    @IBAction func changeBorderColor(_ sender: HoshiTextField) {
        sender.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
    }
    
    @IBAction func changeBorderLastname(_ sender: HoshiTextField) {
        sender.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
    }
    
    @IBAction func changeBorderEmail(_ sender: HoshiTextField) {
        sender.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
    }
    
    @IBAction func changeBorderPassword(_ sender: HoshiTextField) {
        sender.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
    }
    
    
    @IBAction func signUpAction(_ sender: TransitionButton) {
        sender.startAnimation()
        
        if emailTextField.text!.isEmpty && dateTextField.text!.isEmpty && lastnameTextField.text!.isEmpty && nameTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 0)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
        }else if emailTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 1)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
            
        }else if dateTextField.text!.isEmpty{
            self.configOnErrorStyle(sender: sender, value: 2)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
            
        }else if lastnameTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 3)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
            
        }else if nameTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 4)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
            
        }else if passwordTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 5)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
        }else {
            signUp(email: emailTextField.text!, birthdate: dateTextField.text!, lastname: lastnameTextField.text!, name: nameTextField.text!, password: passwordTextField.text!, button: sender)
        }
    }
    
    func signUp(email: String, birthdate: String, lastname: String, name: String, password: String, button: TransitionButton) {
        BeerEndPoint.createUser(email: emailTextField.text!, birthdate: dateTextField.text!, lastname: lastnameTextField.text!, name: nameTextField.text!, password: passwordTextField.text!) { (newKey, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let newKey = newKey {
                button.stopAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                    self.emailTextField.text! = ""
                    self.dateTextField.text! = ""
                    self.lastnameTextField.text! = ""
                    self.nameTextField.text! = ""
                    self.passwordTextField.text! = ""
                    self.signUpButton.cornerRadius = self.signUpButton.frame.height/2
                    self.signUpButton.clipsToBounds = true
                })
                print(newKey)
            }
        }
        
    }
    
    func configOnErrorStyle(sender: TransitionButton, value: Int) {
        switch value {
        case 0:
            self.emailTextField.borderInactiveColor = .red
            self.emailTextField.borderActiveColor = .red
            self.emailTextField.placeholderColor = .red
            
            self.dateTextField.borderInactiveColor = .red
            self.dateTextField.borderActiveColor = .red
            self.dateTextField.placeholderColor = .red
            
            self.lastnameTextField.borderInactiveColor = .red
            self.lastnameTextField.borderActiveColor = .red
            self.lastnameTextField.placeholderColor = .red
            
            self.nameTextField.borderInactiveColor = .red
            self.nameTextField.borderActiveColor = .red
            self.nameTextField.placeholderColor = .red
            
            self.passwordTextField.borderInactiveColor = .red
            self.passwordTextField.borderActiveColor = .red
            self.passwordTextField.placeholderColor = .red
        case 1:
            self.emailTextField.borderInactiveColor = .red
            self.emailTextField.borderActiveColor = .red
            self.emailTextField.placeholderColor = .red
        case 2:
            self.dateTextField.borderInactiveColor = .red
            self.dateTextField.borderActiveColor = .red
            self.dateTextField.placeholderColor = .red
        case 3:
            self.lastnameTextField.borderInactiveColor = .red
            self.lastnameTextField.borderActiveColor = .red
            self.lastnameTextField.placeholderColor = .red
            
        case 4:
            self.nameTextField.borderInactiveColor = .red
            self.nameTextField.borderActiveColor = .red
            self.nameTextField.placeholderColor = .red
        default:
            self.passwordTextField.borderInactiveColor = .red
            self.passwordTextField.borderActiveColor = .red
            self.passwordTextField.placeholderColor = .red
        }
        sender.cornerRadius = sender.frame.height/2
        sender.clipsToBounds = true
        sender.titleLabel!.text = "REGISTRAR"
        sender.setTitle("REGISTRAR", for: .selected)
        sender.setTitle("REGISTRAR", for: .normal)
    }


}

extension RegisterUserViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 0
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
