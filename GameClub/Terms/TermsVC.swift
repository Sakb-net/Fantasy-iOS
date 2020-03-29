//
//  TermsVC.swift
//  GameClub
//
//  Created by Basma on 2/26/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit

class TermsVC: ParentViewController {
    var isChecked = false
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cbBT: UIButton!
    @IBOutlet weak var startBT: UIButton!
    @IBAction func cbAction(_ sender: Any) {
        if !isChecked {
            self.cbBT.backgroundColor = UIColor.green
            self.isChecked = true
            self.startBT.isEnabled = true
        }else {
            self.cbBT.backgroundColor = UIColor.white
            self.isChecked = false
            self.startBT.isEnabled = false
        }
    }
    @IBAction func startAction(_ sender: Any) {
        let favTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "FavTeamVC") as! FavTeamVC
        self.navigationController?.pushViewController(favTeamVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cbBT.layer.borderColor = UIColor.darkGray.cgColor
        self.cbBT.layer.borderWidth = 3.0
        roundViewCornersNoShadow(view: self.startBT)
        self.showLoader()
        getTerms(onSuccess: { (terms) in
            self.textView.text = terms
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getTerms(onSuccess: @escaping (String) -> Void, onFailure: @escaping (String?) -> Void ) -> Void
    {
        let url = Urls().getTerms()
        
        let parameters:[String:Any] = [
            "lang": HelperMethods.getCurrentLanguage()        ]
        
        ServiceManager.callAPI(url: url, method: .post, parameters: parameters, custumHeaders: nil) { (error, response) in
            
            if response != nil
            {
                let statusCode = response!["StatusCode"].intValue
                if statusCode == 0 {
                    if let data = response!["data"]["content"].string {
                        onSuccess(data)
                    }else{
                        onFailure("Oops, Error occured")
                    }
                }else{
                    let message = response!["Message"].stringValue
                    onFailure(message)
                }
            }
            else
            {
                onFailure(error!.localizedDescription)
            }
        }
    }
    
}
