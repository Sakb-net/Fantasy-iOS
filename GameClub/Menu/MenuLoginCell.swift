


import UIKit

class MenuLoginCell: UITableViewCell {

    @IBOutlet weak var goToLogin: UILabel!
    
    
    func configCell() {
        applyDesign()
    }

    func applyDesign(){
        goToLogin.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
    }
}
