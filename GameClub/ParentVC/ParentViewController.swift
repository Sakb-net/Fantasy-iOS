




import UIKit
import Reachability
import NVActivityIndicatorView
import SDWebImage
import SwiftSVG

class ParentViewController: UIViewController
{
    
    var activityIndicatorView:NVActivityIndicatorView!
    var menuBtn:UIButton!
    
//    lazy var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action:
//            #selector(MainScreenVC.handleRefresh(_:)),
//                                 for: UIControl.Event.valueChanged)
//        refreshControl.tintColor = Color.theme.value
//        
//        return refreshControl
//    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        createLoader()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        InternetConnection.shared.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        InternetConnection.shared.removeListener(listener: self)
    }
    
    func showAlert(title: String?, message: String?, shouldpop: Bool) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.blue
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            
            if shouldpop
            {
                if let navController = self.navigationController
                {
                    navController.popViewController(animated: true)
                }
                else
                {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true)
    }
    
    func showLoader() {
        activityIndicatorView.startAnimating()
    }
    
    func hideLoader() {
        activityIndicatorView.stopAnimating()
    }
    
    func showConfirmationAlert(title: String?, message: String?, confirmCompletion: (() -> Void)?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.blue
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
            
            if confirmCompletion != nil
            {
                confirmCompletion!()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    private func createLoader(){
        let height = 80
        let width = 80
        let x = (self.view.frame.width / 2) - CGFloat(width / 2)
        let y = (self.view.frame.height / 2) - CGFloat(height / 2)
        let frame = CGRect(x: x, y: y, width: 70, height: 70)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballClipRotatePulse, color: Color.attacker.value, padding: 0)
        self.view.addSubview(activityIndicatorView)
    }
    
}


extension ParentViewController: NetworkStatusListener
{
    func networkStatusDidChange(status: Reachability.Connection)
    {
        switch status {
        case .none:
            debugPrint("not connected")
           NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: false)
        case .wifi, .cellular:
            NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: true)
        }
    }
    
    func roundViewCorners(view : UIView){
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.175).cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
    }
    
    func roundViewCornersNoShadow(view : UIView){
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
}
extension UIButton
{
    func setSvgImgFnc(svgImjFileNameVar: String, ClrVar: UIColor)
    {
        setImage((getSvgImgFnc(svgFileName: svgImjFileNameVar, ClrVar : ClrVar)), for: .normal)
    }
}

func getSvgImgFnc(svgFileName: String, ClrVar: UIColor) -> UIImage
{
    let svgURL = Bundle.main.url(forResource: "wehdah", withExtension: "svg")
    let svgVyuVar = UIView(SVGURL: svgURL!)

    /* The width, height and viewPort are set to 100

        <svg xmlns="http://www.w3.org/2000/svg"
            width="100%" height="100%"
            viewBox="0 0 100 100">

        So we need to set UIView Rect also same
    */

    svgVyuVar.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    for svgVyuLyrIdx in svgVyuVar.layer.sublayers!
    {
        for subSvgVyuLyrIdx in svgVyuLyrIdx.sublayers!
        {
            if(subSvgVyuLyrIdx.isKind(of: CAShapeLayer.self))
            {
                let SvgShpLyrIdx = subSvgVyuLyrIdx as? CAShapeLayer
                SvgShpLyrIdx!.fillColor = ClrVar.cgColor
            }
        }
    }
    return svgVyuVar.getImgFromVyuFnc()
}
extension UIView
{
    func getImgFromVyuFnc() -> UIImage
    {
        UIGraphicsBeginImageContext(self.frame.size)

        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        return image!
    }
}
