//
//  DogTypeViewController.swift
//  DogCare
//
//  Created by user167535 on 7/19/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit

class DogTypeViewController: UIViewController {
    var criteria: DogCriteria?
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var dogSizeImage: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet private weak var large: UIButton!
    @IBOutlet private weak var medium: UIButton!
    @IBOutlet private weak var small: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    private var selectedSize: dogSize? = .small
    private var selectedAge: dogAge? = .baby
    private var dogSizeSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Show results

    @IBAction func continueBtn(_ sender: Any) {
        if dogSizeSelected == "small" {
            image1.image = UIImage(named: "small1")
            image2.image = UIImage(named: "small2")
            image3.image = UIImage(named: "small3")
        }; if dogSizeSelected == "medium" {
            image1.image = UIImage(named: "medium1")
            image2.image = UIImage(named: "medium2")
            image3.image = UIImage(named: "medium3")
        }; if dogSizeSelected == "large" {
            image1.image = UIImage(named: "large1")
            image2.image = UIImage(named: "large2")
            image3.image = UIImage(named: "large3")
        };
    }
    
    // MARK: Dog size choosen

    @IBAction private func sizeSelected(_ sender: UIButton) {
        style(selected: sender, allButtons: [small, medium, large])
        if let title = sender.titleLabel?.text?.lowercased(), let image = UIImage(named: title)  {
            selectedSize = dogSize(rawValue: title)
            dogSizeSelected = sender.titleLabel?.text?.lowercased() as! String
            dogSizeImage.image = image
        }
    }
    
    private func style(selected: UIButton, allButtons: [UIButton?]) {
        for button in allButtons {
            if let label = button?.titleLabel {
                if button == selected {
                    label.font = UIFont (name: "Avenir-Black", size: 12)
                }
                else {
                    label.font = UIFont (name: "Avenir-Roman", size: 12)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
}

extension String {
    var uppercaseFirstLetter: String {
        guard let firstLetter = first else { return self }
        return String(firstLetter).uppercased() + dropFirst()
    }
}
