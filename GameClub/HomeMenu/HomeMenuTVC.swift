




import UIKit

class HomeMenuTVC: UITableViewController {
    
    let menuTitles = ["الرئيسية","نقاطي","فريقي","اجراء انتقالات","قواعد اللعبة","أخبار","فيديو","إحصائيات","المباريات","الجوائز","الدوريات","المساعدة","اتصل بنا","تسجيل خروج"]
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.separatorStyle = .none
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "menu_bg"))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.menuTitles.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "UserNameCV", for: indexPath) as! UserNameCV
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "MenuTitlesCV", for: indexPath)
        cell1.backgroundColor = UIColor.clear
        cell2.backgroundColor = UIColor.clear

        if indexPath.row == 0 {
            cell1.userName.text = User.shared().display_name
            return cell1
        } else {
            cell2.textLabel?.text = self.menuTitles[indexPath.row-1]
            cell2.textLabel?.textAlignment = .right
            cell2.textLabel?.font = UIFont(name: "HelveticaNeueW23forSKY-Reg", size: 20)
            cell2.textLabel?.textColor = UIColor.white

            return cell2
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == 0 {
            let accountVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
            self.navigationController?.pushViewController(accountVC, animated: true)
        }
        else if indexPath.row == 1 {
            let homeVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.navigationController?.pushViewController(homeVC, animated: true)
        }else if indexPath.row == 2 {
            let myPointsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyPointsVC") as! MyPointsVC
            self.navigationController?.pushViewController(myPointsVC, animated: true)
        }else if indexPath.row == 3 {
            let myTeamVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "MyTeamVC") as! MyTeamVC
            self.navigationController?.pushViewController(myTeamVC, animated: true)
        }else if indexPath.row == 4 {
            let pitchVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PitchVC") as! PitchVC
            pitchVC.pageType = 1
            self.navigationController?.pushViewController(pitchVC, animated: true)
        }else if indexPath.row == 5 {
            let instructionsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "InstructionsVC") as! InstructionsVC
            instructionsVC.pageNum = 0
            self.navigationController?.pushViewController(instructionsVC, animated: true)
        }else if indexPath.row == 6 {
            let newsController = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsController") as! NewsController
            self.navigationController?.pushViewController(newsController, animated: true)
        }else if indexPath.row == 7 {
            let newsController = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsController") as! NewsController
            newsController.isNews = false
            self.navigationController?.pushViewController(newsController, animated: true)
        }else if indexPath.row == 8 {
            let statisticsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "StatisticsVC") as! StatisticsVC
            self.navigationController?.pushViewController(statisticsVC, animated: true)
        }else if indexPath.row == 9 {
            let fixturesVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "FixturesVC") as! FixturesVC
            self.navigationController?.pushViewController(fixturesVC, animated: true)
        }else if indexPath.row == 10 {
            let prizesVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "PrizesVC") as! PrizesVC
            self.navigationController?.pushViewController(prizesVC, animated: true)
        }else if indexPath.row == 11 {
            let leaguesVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LeaguesVC") as! LeaguesVC
            self.navigationController?.pushViewController(leaguesVC, animated: true)
        }else if indexPath.row == 12 {
            let instructionsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "InstructionsVC") as! InstructionsVC
            instructionsVC.pageNum = 1
            self.navigationController?.pushViewController(instructionsVC, animated: true)
        }else if indexPath.row == 13 {
            let contactUsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            self.navigationController?.pushViewController(contactUsVC, animated: true)
        }else if indexPath.row == 14 {
            UserDefaults.standard.set(0, forKey: "add_team")
            User.shared().logoutUser()
            let loginVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        }
    }


}
