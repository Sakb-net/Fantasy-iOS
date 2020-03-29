



import UIKit

class AppMainButton: UIButton
{
    
    @IBInspectable var size:CGFloat = FontSizes().normalFontSize
    
    override func layoutSubviews()
    {
        self.titleLabel?.font =  UIFont.init(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        self.setTitleColor(Color.lightText.value, for: .normal)
        self.layer.cornerRadius = 5
        self.backgroundColor = Color.darkBackground.value
    }
}

