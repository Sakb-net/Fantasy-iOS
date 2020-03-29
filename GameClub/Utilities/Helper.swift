




import Foundation
import UIKit
import SwiftyJSON

var screenWidth:CGFloat {
    return UIScreen.main.bounds.width
}

var screenHeight:CGFloat {
    return UIScreen.main.bounds.height
}

func getTextViewHeight(text: String, font: UIFont = UIFont(name: AppFont().appFontNoraml, size: FontSizes().normalFontSize)!) -> CGFloat {
    let textSize: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: font])
    var height: CGFloat = (textSize.width / UIScreen.main.bounds.width) * font.pointSize
    
    var lineBreaks: CGFloat = 0
    if text.contains("\n") {
        for char in text {
            if char == "\n" {
                lineBreaks += (font.pointSize + 12)
            }
        }
    }
    
    height += lineBreaks
    return height
}

func getCurrentDate() -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let formattedDate = format.string(from: date)
    return formattedDate
}

func getModelYears() -> [Int]{
    var years = [Int]()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: Date())
    for i in 1975...currentYear {
        years.append(i)
    }
    return years
}

func getJsonObjectFromStringJson(stringJson:String) -> JSON? {
    let data = stringJson.data(using: .utf8)!
    do {
        let json = try JSON(data: data)
        print(json)
        
        return json
    } catch let error as NSError {
        print(error)
        return nil
    }
}

extension UITableView {
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}

func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
    let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    view.layer.mask = mask
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

/*
 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 if let touch = touches.first {
 if let touchedView = touch.view, touchedView != containerView {
 self.dismiss(animated: true, completion: nil)
 }
 }
 }
*/
