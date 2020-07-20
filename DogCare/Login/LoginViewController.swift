//
//  LoginViewController.swift
//  DogCare
//
//  Created by user167535 on 6/11/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var otpTextField: UITextField!
    var userId : String?
    
    var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        otpTextField.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Design

    func setUpElements() {
        Utilities.styleTextField(phoneNumberTextField)
        Utilities.styleTextField(otpTextField)
    }
    
    var verification_id : String? = nil
    
    // MARK: check details and users in system

    @IBAction func loginTapped(_ sender: Any) {
        var _ : Bool = false
        if (otpTextField.isHidden) {
            if !phoneNumberTextField.text!.isEmpty {
                if phoneNumberTextField.text!.count == 13 &&  phoneNumberTextField.text!.prefix(1)=="+" {
                Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberTextField.text!, uiDelegate: nil, completion: {verificationID, error in
                    if (error != nil) {
                        return
                    } else {
                        self.verification_id = verificationID
                        self.otpTextField.isHidden = false
                    }
                })
            } else {
                showAlert()
            }

            }         } else {
            if verification_id != nil {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verification_id!, verificationCode: otpTextField.text!)
                Auth.auth().signIn(with: credential, completion: {authData, error in
                    if (error != nil) {
                        print(error.debugDescription)
                    } else {
                        print("AUTHENTICATION SUCCESS" + (authData?.user.phoneNumber! ?? "no phone number"))
                        
                        self.userId = Auth.auth().currentUser!.uid
                        self.getAllSignedUsers() {
                            res in
                            if (res.contains(self.userId!)) {
                                self.transitionToTabBar()
                            } else {
                                self.transitionToRegister()
                            }
                            
                        }
                    }
                })
            } else {
                print("error getting verification id")
            }
        }
        self.userId=""
        
    }
    
    
    func getAllSignedUsers (completion:@escaping(([String]) -> ())) {
        var usersExist : [String] = []
        let g = DispatchGroup()
        self.ref = Database.database().reference()
        self.ref = self.ref.child("Users")
        g.enter()
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for user in snapshot.children {
                let snap = user as! DataSnapshot
                let dict = snap.value as! [String: Any]
                let getUid : String = dict["uid"] as! String
                usersExist.append(getUid)
            }
            g.leave()
        })
        g.notify(queue: .main) {
            completion(usersExist)
        }
    }
    
    
    // MARK: transition to another pages

    func transitionToTabBar() {
        let tabBar = storyboard?.instantiateViewController(identifier: Constants.Storyboard.TabViewController) as? MainTabController
        MainTabController.myPhoneNumber = phoneNumberTextField.text!
        MainTabController.myUid = userId
        view.window?.rootViewController = tabBar
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToRegister() {
        let registerViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signUpViewController) as? SignUpViewController
        registerViewController?.currentUID = userId
        registerViewController?.phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        view.window?.rootViewController = registerViewController
        view.window?.makeKeyAndVisible()
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }

    // MARK: Alert

    func showAlert() {
        let alertView = UIAlertController(title: "Error", message: "Please insert valid phone number: + sign and than 12 digits", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }

    
}
