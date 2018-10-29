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
import Cloudinary

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var dateTextField: HoshiTextField!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var lastnameTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    @IBOutlet weak var signUpButton: TransitionButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var questionTextField: HoshiTextField!
    @IBOutlet weak var answerTextField: HoshiTextField!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    private var datePicker: UIDatePicker?
    private var questionPicker: UIPickerView?
    private var urlProfileImage: String?
    var allQuestions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
        dateTextField.delegate = self
        addDatePicker()
        let tapCloseKeyboard = UITapGestureRecognizer(target: self, action: #selector(closeKeyBoard(_:)))
        view.addGestureRecognizer(tapCloseKeyboard)
        
        addPicker()
        getQuestions()
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
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func getQuestions() {
        BeerEndPoint.getSecurityQuestions { (secQuestions, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let questions = secQuestions {
                for questions in questions {
                    self.allQuestions.append(questions.stringValue)
                }
            }
        }
    }
    
    func addPicker() {
        questionPicker = UIPickerView()
        questionPicker?.showsSelectionIndicator = true
        questionTextField.inputView = questionPicker
        questionPicker?.backgroundColor = .white
        questionPicker!.dataSource = self
        questionPicker!.delegate = self
        questionTextField.delegate = self
        
        answerTextField.borderActiveColor = .gray
        answerTextField.borderInactiveColor = .gray
        answerTextField.placeholderColor = .gray
        answerTextField.isEnabled = false
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
        UIView.animate(withDuration: 0.8) {
            self.view.endEditing(true)
        }
        
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
    
    @IBAction func changeQuestionBorder(_ sender: HoshiTextField) {
        sender.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        sender.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
    }
    
    @IBAction func signUpAction(_ sender: TransitionButton) {
        sender.startAnimation()
        guard let userUrlImage = urlProfileImage else {
            self.signUpButton.cornerRadius = self.signUpButton.frame.height/2
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                self.selectImageButton.setTitleColor(.red, for: .normal)
            }
            return
        }
        
        
        if emailTextField.text!.isEmpty && dateTextField.text!.isEmpty && lastnameTextField.text!.isEmpty && nameTextField.text!.isEmpty && passwordTextField.text!.isEmpty && questionTextField.text!.isEmpty && answerTextField.text!.isEmpty{
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
        }else if questionTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 6)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
        }else if answerTextField.text!.isEmpty {
            self.configOnErrorStyle(sender: sender, value: 7)
            sender.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.0) {
                return
            }
        }else {
            let user = User.init(name: nameTextField.text!, lastname: lastnameTextField.text!, birthdate: dateTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, question: questionTextField.text!, answer: answerTextField.text!, urlImage: userUrlImage)
            signUp(user: user, button: sender)
        }
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let imageVC = UIImagePickerController()
        imageVC.delegate = self
        imageVC.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imageVC, animated: true)
    }
    
    func signUp(user: User, button: TransitionButton) {
        BeerEndPoint.createUser(user: user) { (newKey, error) in
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
                    self.questionTextField.text! = ""
                    self.answerTextField.text! = ""
                    self.selectImageButton.setTitleColor(self.selectImageButton.tintColor, for: .normal)
                    self.profileImageVIew.image = UIImage()
                    self.signUpButton.cornerRadius = self.signUpButton.frame.height/2
                    self.signUpButton.clipsToBounds = true
                    self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
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
        case 5:
            self.passwordTextField.borderInactiveColor = .red
            self.passwordTextField.borderActiveColor = .red
            self.passwordTextField.placeholderColor = .red
        case 6:
            self.questionTextField.borderInactiveColor = .red
            self.questionTextField.borderActiveColor = .red
            self.questionTextField.placeholderColor = .red
        default:
            self.answerTextField.borderInactiveColor = .red
            self.answerTextField.borderActiveColor = .red
            self.answerTextField.placeholderColor = .red
        }
        sender.cornerRadius = sender.frame.height/2
        sender.clipsToBounds = true
        sender.titleLabel!.text = "REGISTRAR"
        sender.setTitle("REGISTRAR", for: .selected)
        sender.setTitle("REGISTRAR", for: .normal)
    }
    
    func uploadImage(profileImage: UIImage) {
        let config = CLDConfiguration(cloudName: "dh47myzjn", apiKey: "122312343553885", apiSecret: "2lLvTKbJOU4cm7eOgd-LvOP5Cbk")
        let cloudinary = CLDCloudinary(configuration: config)
        
        let data = UIImagePNGRepresentation(profileImage)
        
        cloudinary.createUploader().upload(data: data!, uploadPreset: "nqo50tbr").response { (result, error) in
            if let result = result {
                self.urlProfileImage = result.url!
            }
        }
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

extension RegisterUserViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allQuestions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allQuestions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        questionTextField.text = allQuestions[row]
        answerTextField.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        answerTextField.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        answerTextField.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        questionTextField.borderActiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        questionTextField.borderInactiveColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        questionTextField.placeholderColor = UIColor(red: 70/255, green: 49/255, blue: 104/255, alpha: 1)
        answerTextField.isEnabled = true
        UIView.animate(withDuration: 0.8) {
            self.view.endEditing(true)
        }
    }
}

extension RegisterUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        profileImageVIew.image = image
        self.dismiss(animated: true, completion: {
            self.uploadImage(profileImage: image)
            self.selectImageButton.setTitleColor(self.selectImageButton.tintColor, for: .normal)
        })
    }
}
