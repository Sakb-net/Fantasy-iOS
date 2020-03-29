//
//  VedioCell.swift
//  AlAhliFC
//
//  Created by Mohammed Saleh on 7/1/19.
//  Copyright © 2019 me. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VedioCell: UITableViewCell {

    @IBOutlet weak var vedioContainer: WKYTPlayerView!
    @IBOutlet weak var vedioTitle: UILabel!
    
    func configCell(video:Videos){
        applyDesign()
        vedioContainer.load(withVideoId: video.upload_id ?? "")
        vedioTitle.text = video.name
        
        //vedioContainer.loadVideo(byURL: "https://www.youtube.com/watch?v=4hIj6n_2nc4", startSeconds: 0.0, suggestedQuality: .auto)
    }
    
    func applyDesign(){
        
        vedioContainer.layer.cornerRadius = 10
        
        vedioTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        vedioTitle.textColor = Color.darkText.value
    }
}
