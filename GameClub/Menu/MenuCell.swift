



import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuItemTitle: UILabel!
    
    func configCell(title:String){
        applyDesign()
        
        self.menuItemTitle.text = title
    }
    
    func applyDesign(){
        menuItemTitle.font = UIFont(name: AppFont().appFontNoraml, size: FontSizes().largeFontSize)
        menuItemTitle.textColor = Color.darkText.value
    }
}
