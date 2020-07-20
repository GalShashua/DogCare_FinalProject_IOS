//
//  CreateGroupViewController.swift
//  DogCare
//
//  Created by user167535 on 6/16/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseUI
import Photos

class CreateGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var uploadPhotoBtn: UIButton!
    @IBOutlet weak var insertPhoneTextField: UITextField!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var createGroupBtn: UIButton!
    @IBOutlet weak var addPhoneBtn: UIButton!
    @IBOutlet weak var finishBtn: UIButton!
    
    private var groupUsers : [String] = []
    private var photoUrl : URL? = nil
    
    var ref : DatabaseReference!
    var groupName : String!
    var groupId : String!
    var imagePickerController = UIImagePickerController()
    var uploadPhotoWasClicked : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupNameLabel.isHidden = true
        imagePickerController.delegate = self
        checkPermission()
        setUpElements()
        uploadPhotoBtn.isHidden = true
        insertPhoneTextField.isHidden = true
        addPhoneBtn.isHidden = true
        finishBtn.isHidden = true
        self.groupUsers.append(MainTabController.myPhoneNumber)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Design
    
    func setUpElements() {
        Utilities.styleTextField(insertPhoneTextField)
        Utilities.styleTextField(groupNameTextField)
        Utilities.styleFilledButton(finishBtn)
    }
    
    // MARK: Upload photo
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            photoUrl = url
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func uploadPhotoToCloud(fileURL: URL, randomId: String) {
        let storage = Storage.storage()
        _ = Data()
        let storageRef = storage.reference()
        let localFule = fileURL
        let photoRef = storageRef.child("DogPhotos").child(randomId)
        _ = photoRef.putFile(from: localFule, metadata: nil) { (metadata, err) in
            guard metadata != nil else {
                print(err?.localizedDescription as Any)
                return
            }
            print("Photo upload")
        }
    }
    
    // MARK: Create group btn
    
    @IBAction func CreateGroupClicked(_ sender: Any) {
        self.groupName = groupNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        groupNameTextField.isHidden = true
        groupNameLabel.text = groupName
        groupNameLabel.isHidden = false
        createGroupBtn.isHidden = true
        uploadPhotoBtn.isHidden = false
        insertPhoneTextField.isHidden = false
        addPhoneBtn.isHidden = false
        finishBtn.isHidden = false
    }
    
    // MARK: add phone to group
    
    @IBAction func addPhoneClicked(_ sender: Any) {
        let onlyDigitsNeeds = String(insertPhoneTextField.text!.suffix(12))
        let number = insertPhoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if insertPhoneTextField.text!.count == 13 && insertPhoneTextField.text!.prefix(1)=="+" && stringContainOnlyDigits(text: onlyDigitsNeeds) == true {
            self.groupUsers.append(number)
            insertPhoneTextField.text=""
        } else {
            showErrorAlert()
        }
    }
    
    @IBAction func uploadDogPhoto(_ sender: Any) {
        self.uploadPhotoWasClicked = true
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func finishClicked(_ sender: Any) {
        self.ref = Database.database().reference().child("Groups")
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            var dictionary = [String:Any]()
            dictionary.updateValue(self.groupUsers, forKey: "members")
            dictionary.updateValue(self.groupName as Any, forKey: "name")
            dictionary.updateValue([0,0,0,0,0], forKey: "careStatus")
            let randomId = self.ref.childByAutoId().key
            self.ref.child(randomId!).setValue(dictionary)
            if (self.uploadPhotoWasClicked == true) {
                self.uploadPhotoToCloud(fileURL: self.photoUrl!, randomId: randomId!)
            }
        })
        showAlert()
    }
    
    // MARK: Alerts

    func showAlert() {
        let alertView = UIAlertController(title: "Done", message: "Your group created successfully", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let alertView = UIAlertController(title: "Error", message: "Please insert valid phone number: + sign and than 12 digits", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func stringContainOnlyDigits (text : String) -> Bool {
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(text).isSubset(of: nums)
    }
    
    
}

