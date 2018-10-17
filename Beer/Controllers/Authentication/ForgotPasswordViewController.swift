//
//  ForgotPasswordViewController.swift
//  Beer
//
//  Created by Melanie on 10/16/18.
//

import UIKit

class ForgotPasswordViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func sendEmailAction(_ sender: Any) {
//        let mailCompose = configureEmailController()
//        if MFMailComposeViewController.canSendMail() {
//
//        }
//
    }
    
//    func configureEmailController() -> MFMailComposeViewController {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self
//        mailComposerVC.setToRecipients(["nmadrid.tello@gmail.com"])
//        mailComposerVC.setSubject("we")
//        mailComposerVC.setMessageBody("csss", isHTML: false)
//
//        return mailComposerVC
//    }
//
//    func showMailError() {
//        let sendMailAlert = UIAlertController(title: "error", message: "error", preferredStyle: .alert)
//        let dismiss = UIAlertAction(title: "WW", style: .default, handler: nil)
//        sendMailAlert.addAction(dismiss)
//        self.present(sendMailAlert,animated: true)
//    }
//
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true, completion: nil)
//    }
//
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
