




import UIKit

class UserNameCV: UITableViewCell {
   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var editProfileBT: UIButton! {
        didSet {
            editProfileBT.semanticContentAttribute = UIApplication.shared
                .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        }
    }
    @IBOutlet weak var separator: UIView!
    
    @IBAction func editProfileAction(_ sender: Any) {
    }
}
