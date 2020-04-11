



import UIKit

enum Color {
    
    case theme
    case lightTheme
    case border
    case shadow
    
    case goalKeeper
    case defender
    case mid
    case attacker
    case sub
    
    case selectedPlayer
    
    case darkBackground
    case lightBackground
    case intermidiateBackground
    
    case darkText
    case lightText
    case intermidiateText
    case yellowText
    
    case affirmation
    case negation
    
    case badge
    // 1
    case custom(hexString: String, alpha: Double)
    // 2
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}
