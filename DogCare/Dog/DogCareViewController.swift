//
//  DogCareViewController.swift
//  DogCare
//
//  Created by user167535 on 6/16/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class DogCareViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private var dogWalkBtn: [UIButton]!
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet private var dogFoodBtn: [UIButton]!
    @IBOutlet weak var dogImage: UIImageView!
    
    var ref : DatabaseReference!
    var dogName : String = ""
    var dogId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogName = (DogsViewController.currentDogTapped)
        dogId = DogsViewController.currentDogTappedId
        dogNameLabel.text = dogName
        getCurrentStatusFromStorage()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let ref = storageRef.child("DogPhotos").child(dogId)
        dogImage.layer.borderWidth = 1
        dogImage.layer.borderColor = UIColor.black.cgColor
        dogImage.sd_setImage(with: ref)
    }

    // MARK: Show profile image

    func getImageName(image: UIImage) -> String{
        let x : String = image.description
        let splited = x.split(separator: " ")
        return String(splited[2])
    }

    func getCurrentStatusFromStorage() {
        self.ref = Database.database().reference()
        self.ref = self.ref.child("Groups").child(dogId)
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let dict = snapshot.value as! [String: Any]
            let status : [Int] = dict["careStatus"] as! [Int]
            self.updateImages(status: status)
        })
    }

    // MARK: Update dog details

    func updateImages(status : [Int]) {
        if(status[0] == 1) {
            self.dogFoodBtn[0].setImage(#imageLiteral(resourceName: "foodColor"), for: UIControl.State.normal)
        }
        if(status[1] == 1) {
            self.dogFoodBtn[1].setImage(#imageLiteral(resourceName: "foodColor"), for: UIControl.State.normal)
        }
        if(status[2] == 1) {
            self.dogWalkBtn[0].setImage(#imageLiteral(resourceName: "walkingColor"), for: UIControl.State.normal)
        }
        if(status[3] == 1) {
            self.dogWalkBtn[1].setImage(#imageLiteral(resourceName: "walkingColor"), for: UIControl.State.normal)
        }
        if(status[4] == 1) {
            self.dogWalkBtn[2].setImage(#imageLiteral(resourceName: "walkingColor"), for: UIControl.State.normal)
        }
    }

    // MARK: reset

    @IBAction func resetBtnClicked(_ sender: Any) {
        self.ref = Database.database().reference().child("Groups")
            self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
               self.ref.child(self.dogId).child("careStatus").setValue([0,0,0,0,0])
        })
        for button in dogWalkBtn {
            button.setImage(#imageLiteral(resourceName: "walkingBlack"), for: UIControl.State.normal)
        }
        for button in dogFoodBtn {
            button.setImage(#imageLiteral(resourceName: "foodBlack"), for: UIControl.State.normal)
        }
    }

    // MARK: clicked on details

    @IBAction func foodDogClicked(_ sender: UIButton) {
        if (getImageName(image : dogFoodBtn[sender.tag].currentImage!) == "foodBlack)") {
            dogFoodBtn[sender.tag].setImage(#imageLiteral(resourceName: "foodColor"), for: UIControl.State.normal)
        } else {
            dogFoodBtn[sender.tag].setImage(#imageLiteral(resourceName: "foodBlack"), for: UIControl.State.normal)
        }
    }

    @IBAction func walkDogClicked(_ sender: UIButton) {
        if (getImageName(image : dogWalkBtn[sender.tag].currentImage!) == "walkingBlack)") {
            dogWalkBtn[sender.tag].setImage(#imageLiteral(resourceName: "walkingColor"), for: UIControl.State.normal)
        } else {
            dogWalkBtn[sender.tag].setImage(#imageLiteral(resourceName: "walkingBlack"), for: UIControl.State.normal)
        }
    }

    @IBAction func updateBtnClicked(_ sender: Any) {
        var updateArray = [0,0,0,0,0]
        if (getImageName(image : dogFoodBtn[0].currentImage!) == "foodColor)") {
            updateArray[0] = 1
        }
        if (getImageName(image : dogFoodBtn[1].currentImage!) == "foodColor)") {
            updateArray[1] = 1
        }
        if (getImageName(image : dogWalkBtn[0].currentImage!) == "walkingColor)") {
            updateArray[2] = 1
        }
        if (getImageName(image : dogWalkBtn[1].currentImage!) == "walkingColor)") {
            updateArray[3] = 1
        }
        if (getImageName(image : dogWalkBtn[2].currentImage!) == "walkingColor)") {
            updateArray[4] = 1
        }
         self.ref = Database.database().reference().child("Groups")
             self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
                self.ref.child(self.dogId).child("careStatus").setValue(updateArray)
        })
        showAlert()
    }
    
    // MARK: Alert

    func showAlert() {
             let alertView = UIAlertController(title: "Done", message: "Your changes updated successfully", preferredStyle: .alert)
             alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             self.present(alertView, animated: true, completion: nil)
         }

}
