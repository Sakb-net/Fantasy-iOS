


import UIKit
import SDWebImage

class MenuProfileCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    func configCell() {
        applyDesign()
        userImage.sd_setImage(with: URL(string: User.shared().image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        
        userName.text = User.shared().display_name
    }
    
    func applyDesign() {
        userImage.layer.cornerRadius = 30
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.borderWidth = 1
        userImage.clipsToBounds = true
        
        userName.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        userName.textColor = UIColor.white
        
    }
    

}
