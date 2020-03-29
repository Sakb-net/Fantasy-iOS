



import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsIV: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var playIV: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
}
