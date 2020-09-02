




import UIKit
import SideMenu

class HomeVC: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    
    var addTeam = 0
    var homePresenter = HomePresenter()
    var news = [News]()
    var fixtures = [Fixtures]()
    var publicPoints = PublicPoints()
    var isLoggedin = false
    var publicPointsTitles = ["GameWeek".localized, "Overall Points".localized, "Overall Rank".localized, "Free Transfers".localized, "GameWeek Transfers Made".localized]
    var indexPoint = 0
    var cellCount = 0

//    @IBOutlet weak var myPointsView: UIView!
//    @IBOutlet weak var myTeamView: UIView!
//    @IBOutlet weak var transferesView: UIView!
//    @IBOutlet weak var myPointsIV: UIImageView!
//    @IBOutlet weak var myTeamIV: UIImageView!
//    @IBOutlet weak var transferesIV: UIImageView!
//
//    @IBOutlet weak var linksView: UIStackView!
    @IBOutlet weak var averagePointsLbl: UILabel!
    @IBOutlet weak var userPointsLbl: UILabel!
    @IBOutlet weak var highestPointsLbl: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var chooseTeamView: UIView!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var signinBT: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var mainIV: UIImageView!
    @IBOutlet weak var weeklyScedualTV: UITableView!
   
    @IBOutlet weak var chooseYourTeamBT: UIButton!
   
    @IBAction func signinAction(_ sender: Any) {
        if User.shared().access_token == nil {
        let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(loginVC, animated: true)
        }else {
            User.shared().logoutUser()
            self.usernameLabel.text = ""
            self.signinBT.setTitle("Login".localized, for: .normal)
        }
    }
    
    @IBAction func ShowSideMenuAction(_ sender: Any) {
         let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
        present(menu, animated: true, completion: nil)

    }
    @IBAction func ChooseYourTeamAction(_ sender: Any) {
        if addTeam == 1 {
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
        navigationController!.removeViewController(LoginVC.self)
        self.navigationController?.navigationBar.isHidden = true
//        myPointsIV.image = UIImage(named: "sponsor_header")
//        myTeamIV.image = UIImage(named: "sponsor_header")
//        transferesIV.image = UIImage(named: "sponsor_header")
//        UserDefaults.standard.set(0, forKey: "add_team")
        
        roundCornerForViews ()
        if User.shared().access_token == nil {
            self.usernameLabel.text = ""
            self.signinBT.setTitle("Login".localized, for: .normal)
        }else {
            self.usernameLabel.text = "Not".localized + User.shared().display_name!
        }
        getPublicPoints()
    }
    override func viewWillAppear(_ animated: Bool) {
        if User.shared().access_token == nil {
            self.usernameLabel.text = ""
            self.signinBT.setTitle("Login".localized, for: .normal)
        }else {
            self.usernameLabel.text = "Not".localized + User.shared().display_name!
        }
        let email = User.shared().email
        addTeam = UserDefaults.standard.integer(forKey: email ?? "")
        if addTeam == 1 {
                    self.pointsView.isHidden = false
                    self.chooseTeamView.isHidden = true
        //            self.linksView.isHidden = false
                }else{
                    self.pointsView.isHidden = true
                    self.chooseTeamView.isHidden = false
        //            self.linksView.isHidden = true
                }
        getMainScreenInfo()
        getPublicPoints()
        getHomePoints()
    }
    @objc func myPointsAction(sender : UITapGestureRecognizer) {
        let myPointsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyPointsVC") as! MyPointsVC
        self.navigationController?.pushViewController(myPointsVC, animated: true)
    }
    
    @objc func myTeamAction(sender : UITapGestureRecognizer) {
        let myTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyTeamVC") as! MyTeamVC
        self.navigationController?.pushViewController(myTeamVC, animated: true)
    }
    
    @objc func transferesAction(sender : UITapGestureRecognizer) {
        let pitchVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PitchVC") as! PitchVC
        pitchVC.pageType = 1
        self.navigationController?.pushViewController(pitchVC, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.fixtures.count < 3 && self.fixtures.count > 0{
            if addTeam == 0{
                cellCount = self.fixtures.count + 3
            return cellCount
            }else {
                cellCount = self.fixtures.count + 4
                return cellCount
            }
        } else {
        if addTeam == 0{
            if self.fixtures.count == 0 {
                cellCount = 1
                return cellCount
            }else {
                cellCount = 6
                return cellCount
            }
        }else {
            if self.fixtures.count == 0 {
                cellCount = 7
                return cellCount
            }else {
                cellCount = 12
                return cellCount
            }
        }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "FixtureHeaderCell", for: indexPath) as! FixtureHeaderCell
        cell1.backgroundView = UIImageView(image: UIImage(named: "sponsor_header"))
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "FixtureCell", for: indexPath) as! FixtureCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "FixtureFooterCell", for: indexPath) as! FixtureFooterCell
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "LinksCell", for: indexPath) as! LinksCell
        let cell5 = tableView.dequeueReusableCell(withIdentifier: "PublicPointsCell", for: indexPath) as! PublicPointsCell
        let cell6 = tableView.dequeueReusableCell(withIdentifier: "SponsorsTVC", for: indexPath) as! SponsorsTVC

        cell3.backgroundView = UIImageView(image: UIImage(named: "sponsor_header"))
        if addTeam == 1 {
            if indexPath.row == 0 {
                let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(self.myPointsAction))
                cell4.myPointsView.addGestureRecognizer(gesture1)
                let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.myTeamAction))
                cell4.myTeamView.addGestureRecognizer(gesture2)
                let gesture3 = UITapGestureRecognizer(target: self, action:  #selector(self.transferesAction))
                cell4.transferesView.addGestureRecognizer(gesture3)
                return cell4
            }else if indexPath.row == 1 && self.fixtures.count > 0 {
                return cell1
            }else if indexPath.row == 2 && self.fixtures.count > 0 {
                return fillCells(cell: cell2, index: indexPath.row - 1)
            }else if indexPath.row == 3 && self.fixtures.count > 1 {
                return fillCells(cell: cell2, index: indexPath.row - 1)
            }else if indexPath.row == 4 && self.fixtures.count > 2 {
                return fillCells(cell: cell2, index: indexPath.row - 1)
            }else if indexPath.row == 3 && self.fixtures.count == 1{
                return cell3
            }else if indexPath.row == 4 && self.fixtures.count == 2 {
                return cell3
            }else if indexPath.row == 5 && self.fixtures.count == 3 {
                return cell3
            }else if indexPath.row == cellCount - 1 {
                return cell6
            }else {
                if indexPoint < 5 {
                   
                    if indexPoint == 0 {
                        cell5.pointsLbl.text = publicPointsTitles[indexPoint] + " 34"
                        if let gwPoints = publicPoints.sum_total_subeldwry{
                        cell5.titleLbl.text = String(gwPoints)
                        }
                        indexPoint += 1
                    }else if indexPoint == 1{
                        cell5.pointsLbl.text = publicPointsTitles[indexPoint]
                        if let overallPoints = publicPoints.sum_total_points{
                        cell5.titleLbl.text = String(overallPoints)
                        }
                        indexPoint += 1
                    }else if indexPoint == 2 {
                        cell5.pointsLbl.text = publicPointsTitles[indexPoint]
                        if let overallRank = publicPoints.sort_final_users{
                        cell5.titleLbl.text = String(overallRank)
                        }
                        indexPoint += 1
                    }else if indexPoint == 3 {
                        cell5.pointsLbl.text = publicPointsTitles[indexPoint]
                        if let freeTrans = publicPoints.total_changes{
                        cell5.titleLbl.text = String(freeTrans)
                        }
                        indexPoint += 1
                    }else if indexPoint == 4 {
                        cell5.pointsLbl.text = publicPointsTitles[indexPoint]
                        if let gwTrans = publicPoints.game_week_changes{
                        cell5.titleLbl.text = String(gwTrans)
                        }
                        indexPoint = 0
                    }
                }
                cell5.contentView.layer.borderWidth = 1
                cell5.contentView.layer.borderColor = UIColor.gray.cgColor

                return cell5
            }
            }else{
            if indexPath.row == 0 && self.fixtures.count > 0{
                return cell1
            }else if indexPath.row == 1 && self.fixtures.count > 0 {
                return fillCells(cell: cell2, index: indexPath.row - 1)
            }else if indexPath.row == 2 && self.fixtures.count > 1 {
                return fillCells(cell: cell2, index: indexPath.row - 1)
            }else if indexPath.row == 3 && self.fixtures.count > 2 {
                return fillCells(cell: cell2, index: indexPath.row - 1)
            }else if indexPath.row == cellCount - 1 {
                return cell6
            }else {
                return cell3
            }
            }
    }
    func fillCells (cell : FixtureCell, index : Int) -> FixtureCell{
//        cell.firstClubName.text = self.fixtures[0].match_group![index].name_first
//        cell.secondClubName.text = self.fixtures[0].match_group![index].name_second
//        cell.timeLabel.text = self.fixtures[0].match_group![index].time
//        cell.firstClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[0].match_group![index].image_first! ), placeholderImage: UIImage(named: "placeholder"))
//        cell.secondClubIV.sd_setImage(with: URL(string: Urls.baseUrl+self.fixtures[0].match_group![index].image_second! ), placeholderImage: UIImage(named: "placeholder"))
//        
//        cell.delegate = self
//        let firstScore = self.fixtures[0].match_group![index].first_goon
//        let secondScore = self.fixtures[0].match_group![index].second_goon
//        var firstScoreString = ""
//        var secondScoreString = ""
//        if let score1 = firstScore{
//            firstScoreString = String(score1)
//        }
//        if let score2 = secondScore{
//            secondScoreString = String(score2)
//        }
//            cell.scoreLabel.text = firstScoreString + " - " + secondScoreString
//            
//            let date = stringToDate(dateString: self.fixtures[0].match_group![index].date!)
//                   if date > Date() {
//                    cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 0)
//                   } else {
//                       cell.hideLabel(scoreLabel: cell.scoreLabel, timeLabel: cell.timeLabel, type: 1)
//                   }
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
            
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getPublicPoints(){
        self.showLoader()
        PointsPresenter().getPublicPoints(onSuccess: { (publicPoints) in
            self.publicPoints = publicPoints
            self.weeklyScedualTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func getHomePoints(){
        self.showLoader()
        PointsPresenter().getHomePoints(onSuccess: { (homePoints, mainData) in
            if let totalP = homePoints.user_total_sum {
                self.userPointsLbl.text = String(totalP)
            }
            
            if let highP = homePoints.heigh_point {
                self.highestPointsLbl.text = String(highP)
            }
            
            if let avgP = homePoints.total_avg {
                self.averagePointsLbl.text = String(avgP)
            }
            let gw = mainData.num_week
            UserDefaults.standard.set(mainData.end_date , forKey: "END_DATE")
            if let gameWeek = gw {
                UserDefaults.standard.set(gameWeek, forKey: "GAME_WEEK")
            }
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
    func roundCornerForViews (){
        roundViewCornersNoShadow(view: view1)
        roundViewCornersNoShadow(view: view2)
        roundViewCornersNoShadow(view: view3)

        roundViewCorners(view: self.firstView)
//        roundViewCorners(view: self.weeklyScedualTV)
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
