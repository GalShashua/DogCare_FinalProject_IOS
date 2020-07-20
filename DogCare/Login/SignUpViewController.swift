//
//  SignUpViewController.swift
//  DogCare
//
//  Created by user167535 on 6/11/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Photos
import FirebaseStorage

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // MARK: IBOutlets

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var imagePickerController = UIImagePickerController()
    var ref : DatabaseReference!
    var currentUID : String?
    var phoneNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        imagePickerController.delegate = self
        checkPermission()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            view.addGestureRecognizer(tap)

        }
        
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }
    
    // MARK: Gallery Permission

    func checkPermission() {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status:
                PHAuthorizationStatus) -> Void in
                ()
                })
            }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthroizatHandler)
        }
    }
    
    func requestAuthroizatHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            print("We have access to photos")
        } else {
            print("We dont have access to photos")
        }
    }
    
    // MARK: Design
    
    func setUpElements() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleFilledButton(signUpBtn)
    }
    
    // MARK: validate Fields
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    // MARK: Upload data to firebase
    
    @IBAction func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            print(error as Any)
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            var dict = [String:Any]()
            dict.updateValue(firstName, forKey: "firstName")
            dict.updateValue(lastName, forKey: "lastName")
            dict.updateValue(email, forKey: "email")
            dict.updateValue(phoneNumber!, forKey: "phone")
            dict.updateValue(currentUID!, forKey: "uid")
            ref = Database.database().reference()
            ref.child("Users").child(currentUID!).setValue(dict)
            self.transitionToTabBar()
        }
    }
    
    // MARK: transition to another page

    func transitionToTabBar() {
        let tabBar = storyboard?.instantiateViewController(identifier: Constants.Storyboard.TabViewController) as? MainTabController
        MainTabController.myPhoneNumber = phoneNumber
        MainTabController.myUid = currentUID
        view.window?.rootViewController = tabBar
        view.window?.makeKeyAndVisible()
    }
    
    // MARK: Upload and choose profile image

    @IBAction func uploadImageTapped(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            uploadPhotoToCloud(fileURL: url)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func uploadPhotoToCloud(fileURL: URL) {
        let storage = Storage.storage()
        _ = Data()
        let storageRef = storage.reference()
        let localFule = fileURL
        let photoRef = storageRef.child("UsersPhotos").child(currentUID!)
        _ = photoRef.putFile(from: localFule, metadata: nil) { (metadata, err) in
            guard metadata != nil else {
                print(err?.localizedDescription as Any)
                return
            }
            print("Photo upload")
        }
    }
}
