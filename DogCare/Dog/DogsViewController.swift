//
//  DogsViewController.swift
//  DogCare
//
//  Created by user167535 on 6/15/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class DogsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // MARK: IBOutlets

    @IBOutlet weak var dogsTable: UITableView!
    @IBOutlet weak var createGroupBtn: UIButton!
    var ref : DatabaseReference!
    var myGroups : [String] = []
    var myGroupIds : [String] = []
    var x : [String] = ["a","b","c"]
    let cellReuseIdentifier = "dog_cell"
    static var currentDogTapped : String = ""
    static var currentDogTappedId : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadDatafromStorage()
        dogsTable.delegate = self
        dogsTable.dataSource = self
    }
    
    @IBAction func refreshBtnClicked(_ sender: Any) {
        uploadDatafromStorage()
    }
    
    // MARK: read data from firebase

    func uploadDatafromStorage() {
        self.myGroups.removeAll()
        self.myGroupIds.removeAll()
        self.ref = Database.database().reference()
        self.ref = self.ref.child("Groups")
        self.ref.observeSingleEvent(of: .value, with: { (snapshot) in
            for group in snapshot.children {
                let snap = group as! DataSnapshot
                let dict = snap.value as! [String: Any]
                let name : String = dict["name"] as! String
                let groupUs : [String] = dict["members"] as! [String]
                let id : String = snap.key
                if groupUs.contains(MainTabController.myPhoneNumber)
                {
                    self.myGroups.append(name)
                    self.myGroupIds.append(id)
                }
                
            }
            self.setupList()
        })
    }
    
    // MARK: Table Settings

    func setupList() {
        dogsTable.delegate = self
        dogsTable.dataSource = self
        dogsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = myGroups[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DogsViewController.currentDogTapped = myGroups[indexPath.row]
        DogsViewController.currentDogTappedId = myGroupIds[indexPath.row]
    }
}
