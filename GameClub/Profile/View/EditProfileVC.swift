//
//  EditProfileVC.swift
//  GameClub
//
//  Created by Basma on 5/8/20.
//  Copyright © 2020 Basma. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SideMenu

class EditProfileVC: ParentViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var favTeamPresenter = FavTeamPresenter()
    var presenter = ProfilePresenter()
    var teams = [FavTeam]()
    var teamLink = "1424e73e6d6f0269c9b6a28b2ae0974779"
    var imagePicker = UIImagePickerController()
    var imgLink = ""

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var cameraBT: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usernameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var favTeamBT: UIButton!
    @IBOutlet weak var changeProfileBT: UIButton!
    @IBOutlet weak var menuBT: UIButton!
    @IBOutlet weak var backBT: UIButton!
    @IBAction func cameraAction(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func menuAction(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
               present(menu, animated: true, completion: nil)
    }
    @IBAction func faveTeamAction(_ sender: Any) {
        tableView.isHidden = false
    }
    @IBAction func changeProfileAction(_ sender: Any) {
        let username = self.usernameTF.text ?? ""
        let emailAddress = self.emailTF.text ?? ""
//        guard let username = self.usernameTF.text, username != "" else {
//                  self.showAlert(title: "", message: "الرجاء إدخال اسم المستخدم", shouldpop: false)
//                  return
//              }
//        guard let emailAddress = self.emailTF.text, emailAddress != "" else {
//            self.showAlert(title: "", message: "الرجاء إدخال البريد الالكتروني", shouldpop: false)
//            return
//        }
      
        let parameters = [username, emailAddress, teamLink, self.imgLink]
        self.showLoader()
               presenter.updateProfile(updatedParameters: parameters,onSuccess: { (message) in
                   self.showAlert(title: "", message: message, shouldpop: false)
                    UserDefaults.standard.set(emailAddress, forKey: "email")
                   self.hideLoader()
               }) { (errorMessage) in
                   self.hideLoader()
                   self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
               }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewConfig()
        imagePicker.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let apiImgLink = User.shared().image ?? ""
        let imageLink = apiImgLink.replacingOccurrences(of: "https://fantgame.sakb-co.com.sa/", with: "")
        userImage.sd_setImage(with: URL(string: Urls.baseUrl +  imageLink), placeholderImage: UIImage(named: "user"))
        getTeams()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
        cell.nameLbl.text = self.teams[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        teamLink = self.teams[indexPath.row].link ?? "1424e73e6d6f0269c9b6a28b2ae0974779"
        favTeamBT.setTitle(self.teams[indexPath.row].name, for: .normal)
        tableView.isHidden = true
    }
    
    func getTeams(){
        self.showLoader()
        favTeamPresenter.getTeams(onSuccess: { (teams) in
            self.teams = teams
            self.tableView.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage

        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        userImage.image = newImage
        let imgString = convertImageToBase64String(img: newImage)
        self.showLoader()
        presenter.uploadImage(imageBase64: imgString, onSuccess: { (link) in
            self.imgLink = link
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
        dismiss(animated: true)
    }
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    func viewConfig(){
        roundViewCorners(view: containerView)
        roundViewCorners(view: tableView)
        roundCameraBT(view: cameraBT)
        roundViewCornersNoShadow(view: changeProfileBT)
        roundViewCornersNoShadow(view: userImage)
        self.emailTF.textAlignment = .right
        self.usernameTF.textAlignment = .right
        self.usernameTF.titleLabel.textAlignment = .right
        self.emailTF.titleLabel.textAlignment = .right
    }
    
    func roundCameraBT(view : UIView){
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
    }
}
