




import UIKit

class AppMainTextField: UITextField
{
    
    @IBInspectable var size:CGFloat = FontSizes().normalFontSize
    
    override func layoutSubviews()
    {
        self.font = UIFont.init(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)
        self.textColor = Color.theme.value
        self.layer.borderColor = Color.border.value.cgColor
        self.layer.borderWidth = 1
        self.addDoneButtonOnKeyboard()
    }
    
}

