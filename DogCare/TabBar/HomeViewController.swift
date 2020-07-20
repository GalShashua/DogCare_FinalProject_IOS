//
//  HomeViewController.swift
//  DogCare
//
//  Created by user167535 on 6/11/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseUI
import Photos

class HomeViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: Firebase read profile details
    private var myGroups : [String] = []
    var ref : DatabaseReference!
    var ref2 : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("UsersPhotos").child(MainTabController.myUid ?? "")
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.sd_setImage(with: ref)
        updateDetails()
    }
    
    func updateDetails() {
        self.ref = Database.database().reference()
        self.ref = self.ref.child("Users").child(MainTabController.myUid)
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as! [String: Any]
            let firstName : String = dict["firstName"] as! String
            let lastName : String = dict["lastName"] as! String
            let email : String = dict["email"] as! String
            self.userNameLabel.text = firstName + " " + lastName
            self.userEmailLabel.text = email
            
        })
        
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}
