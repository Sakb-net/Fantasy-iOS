//
//  NewsDetailsVC.swift
//  GameClub
//
//  Created by Basma on 2/27/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController {
    var news = News()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = self.news.name
        self.contentLabel.text = self.news.content
        self.imageView.sd_setImage(with: URL(string: Urls.baseUrl+self.news.image! ), placeholderImage: UIImage(named: "placeholder"))
    }
    


}
