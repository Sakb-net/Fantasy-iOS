//
//  VideoDetailsVC.swift
//  GameClub
//
//  Created by Basma on 2/27/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoDetailsVC: ParentViewController {

    var video = Videos()
    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNetworkReachable{
            self.playerView.load(withVideoId: video.upload_id ?? "")
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
        self.titleLabel.text = self.video.name
        self.textView.text = self.video.content
    }
    
}
