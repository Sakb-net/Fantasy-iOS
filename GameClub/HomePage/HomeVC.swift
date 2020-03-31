




import UIKit
import SideMenu

class HomeVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var homePresenter = HomePresenter()
    var news = [News]()
    var fixtures = [Fixtures]()
    var isLoggedin = false
    
    @IBOutlet weak var signinBT: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var mainIV: UIImageView!
    @IBOutlet weak var weeklyScedualTV: UITableView!
    @IBOutlet weak var latestNewsStackView: UIStackView!
    @IBOutlet weak var latestVideosStackView: UIStackView!
    @IBOutlet weak var latestNewsFirstView: UIView!
    @IBOutlet weak var latestNewsSecondView: UIView!
    @IBOutlet weak var latestVideosFirstView: UIView!
    @IBOutlet weak var latestVideosSecondView: UIView!
    @IBOutlet weak var chooseYourTeamBT: UIButton!
    @IBOutlet weak var NewsImage1: UIImageView!
    @IBOutlet weak var NewsTitle1: UILabel!
    @IBOutlet weak var NewsDate1: UILabel!
    @IBOutlet weak var NewsImage2: UIImageView!
    @IBOutlet weak var NewsTitle2: UILabel!
    @IBOutlet weak var NewsDate2: UILabel!
    @IBOutlet weak var VideosImage1: UIImageView!
    @IBOutlet weak var VideosTitle1: UILabel!
    @IBOutlet weak var VideosDate1: UILabel!
    @IBOutlet weak var VideosImage2: UIImageView!
    @IBOutlet weak var VideosTitle2: UILabel!
    @IBOutlet weak var VideosDate2: UILabel!
    @IBAction func signinAction(_ sender: Any) {
        if User.shared().access_token == nil {
        let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
        }else {
            User.shared().logoutUser()
            self.usernameLabel.text = "هل لديك حساب"
            self.signinBT.setTitle("تسجيل دخول", for: .normal)
        }
    }
    
    @IBAction func ShowSideMenuAction(_ sender: Any) {
         let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)

    }
    @IBAction func ChooseYourTeamAction(_ sender: Any) {
        let added_team = UserDefaults.standard.integer(forKey: "add_team")
        if added_team == 1 {
            let myTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyTeamVC") as! MyTeamVC
            self.navigationController?.pushViewController(myTeamVC, animated: true)
        }else {
            let myTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PitchVC") as! PitchVC
            self.navigationController?.pushViewController(myTeamVC, animated: true)
        }
        
    }
    @IBAction func moreNewsAction(_ sender: Any) {
        
        let newsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsController") as! NewsController
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    @IBAction func moreVideosAction(_ sender: Any) {
        let newsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsController") as! NewsController
        newsVC.isNews = false
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        roundCornerForViews ()
        getMainScreenInfo()
        if User.shared().access_token == nil {
            self.usernameLabel.text = "هل لديك حساب"
            self.signinBT.setTitle("تسجيل دخول", for: .normal)
        }else {
            self.usernameLabel.text = "لست " + User.shared().display_name!
        }
    let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.openNewsDetails))
    self.latestNewsFirstView.addGestureRecognizer(gesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fixtures.count < 3{
            return self.fixtures.count + 2
        } else {
        return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "FixtureHeaderCell", for: indexPath) as! FixtureHeaderCell
        cell1.backgroundView = UIImageView(image: UIImage(named: "sponsor_header"))
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "FixtureCell", for: indexPath) as! FixtureCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "FixtureFooterCell", for: indexPath) as! FixtureFooterCell
        cell3.backgroundView = UIImageView(image: UIImage(named: "sponsor_header"))

        if indexPath.row == 0 {
            return cell1
        }else if indexPath.row == 1 && self.fixtures.count > 0 {
            return fillCells(cell: cell2, index: indexPath.row - 1)
        }else if indexPath.row == 2 && self.fixtures.count > 1 {
            return fillCells(cell: cell2, index: indexPath.row - 1)
        }else if indexPath.row == 3 && self.fixtures.count > 2 {
            return fillCells(cell: cell2, index: indexPath.row - 1)
        }else {
            return cell3
        }

    }
    
    func fillCells (cell : FixtureCell, index : Int) -> FixtureCell{
        cell.firstClubName.text = self.fixtures[0].match_group![index].name_first
        cell.secondClubName.text = self.fixtures[0].match_group![index].name_second
        cell.timeLabel.text = self.fixtures[0].match_group![index].time
        cell.firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[0].match_group![index].image_first! ), placeholderImage: UIImage(named: "placeholder"))
        cell.secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[0].match_group![index].image_second! ), placeholderImage: UIImage(named: "placeholder"))
        
        cell.delegate = self
        let firstScore = self.fixtures[0].match_group![index].first_goon
        let secondScore = self.fixtures[0].match_group![index].second_goon
        var firstScoreString = ""
        var secondScoreString = ""
        if let score1 = firstScore{
            firstScoreString = String(score1)
        }
        if let score2 = secondScore{
            secondScoreString = String(score2)
        }
            cell.scoreLabel.text = firstScoreString + " - " + secondScoreString
            
            let date = stringToDate(dateString: self.fixtures[0].match_group![index].date!)
                   if date > Date() {
                    cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 0)
                   } else {
                       cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 1)
                   }
        return cell
    }
    
    @objc func openNewsDetails(sender : UITapGestureRecognizer) {
        let newsLink = self.news[0].link
    }
    
    func getMainScreenInfo(){
        self.showLoader()
        homePresenter.getHomeDetails(onSuccess: { (news, videos, fixtures) in
            self.news = news
            self.fixtures = fixtures
            self.weeklyScedualTV.delegate = self
            self.weeklyScedualTV.dataSource = self
            self.weeklyScedualTV.reloadData()

//            self.mainIV.sd_setImage(with: URL(string: Urls.baseUrl+news[1].image! ), placeholderImage: UIImage(named: "placeholder"))
//            self.mainLabel.text = news[0].name
//            self.mainDateLabel.text = news[0].date
            self.NewsImage1.sd_setImage(with: URL(string: Urls.baseUrl+news[0].image! ), placeholderImage: UIImage(named: "placeholder"))
            self.NewsTitle1.text = news[0].name
            self.NewsDate1.text = news[0].date
            self.NewsImage2.sd_setImage(with: URL(string: Urls.baseUrl+news[1].image! ), placeholderImage: UIImage(named: "placeholder"))
            self.NewsTitle2.text = news[1].name
            self.NewsDate2.text = news[1].date
            self.VideosImage1.sd_setImage(with: URL(string: Urls.baseUrl+videos[0].image! ), placeholderImage: UIImage(named: "placeholder"))
            self.VideosTitle1.text = videos[0].name
            self.VideosDate1.text = videos[0].date
            self.VideosImage2.sd_setImage(with: URL(string: Urls.baseUrl+videos[1].image! ), placeholderImage: UIImage(named: "placeholder"))
            self.VideosTitle2.text = videos[1].name
            self.VideosDate2.text = videos[1].date
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func roundCornerForViews (){
        
        roundViewCorners(view: self.firstView)
        roundViewCorners(view: self.weeklyScedualTV)
        roundViewCorners(view: self.latestNewsFirstView)
        roundViewCorners(view: self.latestNewsSecondView)
        roundViewCorners(view: self.latestVideosFirstView)
        roundViewCorners(view: self.latestVideosSecondView)
        roundViewCorners(view: self.chooseYourTeamBT)
        self.mainIV.layer.cornerRadius = 10
        self.mainIV.clipsToBounds = true
        
    }
    
    func stringToDate(dateString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:dateString)!
        return date
    }
    
    func getCurrentDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return result
    }
}
extension HomeVC : HideScoreLabel {
    func hideScoreLabel(scoreLabel: UILabel, timeLabel: UILabel, type: Int) {
        if type == 0 {
            scoreLabel.isHidden = true
            timeLabel.isHidden = false
        }else {
            scoreLabel.isHidden = false
            timeLabel.isHidden = true
        }
    }
}
