//
//  ViewController.swift
//  DogCare
//
//  Created by user167535 on 6/10/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    // MARK: IBOutlets

    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        setUpVideo()
//    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)        
    }
    
    // MARK: Video

//    func setUpVideo() {
//        let bundlePath = Bundle.main.path(forResource: "video", ofType: "mp4")
//        guard bundlePath != nil else {
//            return
//        }
//        let url = URL(fileURLWithPath: bundlePath!)
//        let item = AVPlayerItem(url: url)
//        videoPlayer = AVPlayer(playerItem: item)
//        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
//        videoPlayerLayer?.frame = CGRect(x:-self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
//        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
//        videoPlayer?.playImmediately(atRate: 1)
//    }

}

