



import UIKit
import SideMenu

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTV: UITableView!
    
    var menuItems = [(id:String, name:String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTV.backgroundView = UIImageView(image: UIImage(named: "menu_bg"))

        menuTV.delegate = self
        menuTV.dataSource = self
        menuTV.rowHeight = 70
        
        menuItems.append(("main","الرئيسية"))
        menuItems.append(("about", "لعبة فانتسي"))
        menuItems.append(("news", "نقاطي"))
        menuItems.append(("team", "فريقي"))
        //menuItems.append(("other","ألعاب أخرى"))
        menuItems.append(("matches","التعليمات"))
        //menuItems.append(("resualts", "النتائج"))
        menuItems.append(("roz","أخبار"))
        menuItems.append(("champ","فيديو"))
        menuItems.append(("consalt", "إحصائيات"))
        menuItems.append(("blot", "المباريات"))

        if let _ = User.shared().access_token {
            menuItems.insert(("profile", "profile"), at: 0)
            menuItems.append(("myAccount", "حسابي"))
            menuItems.append(("contactUs","اتصل بنا"))
            menuItems.append(("logout", "تسجيل الخروج"))
        }else{
            menuItems.insert(("login", "login"), at: 0)
            menuItems.append(("contactUs","اتصل بنا"))
        }
        
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .replace
        SideMenuManager.default.menuWidth = 270
        SideMenuManager.default.menuPresentMode = .menuSlideIn
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if User.shared().access_token != nil && indexPath.row == 0 {
            tableView.rowHeight = 90
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuProfileCell", for: indexPath) as! MenuProfileCell
            cell.configCell()
            return cell
        }else if User.shared().access_token == nil && indexPath.row == 0 {
            tableView.rowHeight = 70
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuLoginCell", for: indexPath) as! MenuLoginCell
            cell.configCell()
            return cell
        }else{
            tableView.rowHeight = 60
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            cell.configCell(title: menuItems[indexPath.row].name)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if menuItems[indexPath.row].id == "login" {
            let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        }
        
    }
    
}
