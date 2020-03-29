



import UIKit

class AppMainLabel: UILabel
{
    
    @IBInspectable var size:CGFloat = FontSizes().normalFontSize
    
    override func layoutSubviews()
    {
        self.font = UIFont.init(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        self.lineBreakMode = .byWordWrapping
        self.textColor = Color.theme.value
    }
}
