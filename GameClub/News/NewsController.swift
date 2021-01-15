



import UIKit
import SideMenu

class NewsController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var headerTiltle: UILabel!
    var isNews = true
    var newsPresenter = NewsPresenter()
//    var videosPresenter = VideosPresenter()
    var newsList = [News]()
//    var videos = [Videos]()
    var canLoadMoreData = true
    
    @IBOutlet weak var newsTV: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainIV: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainPlayBT: UIButton!
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func mainPlayAction(_ sender: Any) {
    }
    
     @IBAction func menuAction(_ sender: Any) {
            let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! UISideMenuNavigationController
            present(menu, animated: true, completion: nil)
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isNews{
            return self.newsList.count - 1
//        } else {
//            return self.videos.count - 1
//        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
//        if isNews {
        cell.newsIV.sd_setImage(with: URL(string: Urls.baseUrl+self.newsList[indexPath.row+1].image! ), placeholderImage: UIImage(named: "placeholder"))
        cell.newsLabel.text = self.newsList[indexPath.row+1].name
        cell.newsDateLabel.text = self.newsList[indexPath.row+1].date
        roundViewCorners(view: cell.containerView)
        cell.newsIV.layer.cornerRadius = 10
        cell.newsIV.clipsToBounds = true
//        } else {
//            cell.playIV.isHidden = false
//            cell.newsIV.sd_setImage(with: URL(string: Urls.baseUrl+self.videos[indexPath.row+1].image! ), placeholderImage: UIImage(named: "placeholder"))
//            cell.newsLabel.text = self.videos[indexPath.row+1].name
//            cell.newsDateLabel.text = self.videos[indexPath.row+1].date
//            roundViewCorners(view: cell.containerView)
//            cell.newsIV.layer.cornerRadius = 10
//            cell.newsIV.clipsToBounds = true
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isNews {
            let newsDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
            newsDetailsVC.news = self.newsList[indexPath.row+1]
            self.navigationController?.pushViewController(newsDetailsVC, animated: true)
        }else {
//            let videoDetailsVC = Storyboard().mainStoryboard.instantiateViewController(withIdentifier: "VideoDetailsVC") as! VideoDetailsVC
//            videoDetailsVC.video = self.videos[indexPath.row+1]
//            self.navigationController?.pushViewController(videoDetailsVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTV.delegate = self
        self.newsTV.dataSource = self
        self.newsTV.separatorStyle = .none
        addRoundCornersAndShadows()
        if isNetworkReachable{
            if isNews {
                getNews()
            } else {
//                getVideos()
//                self.headerTiltle.text = "Videos".localized
//                self.mainPlayBT.isHidden = false
            }
        }else{
            self.showAlert(title: "", message: "Internet is not available", shouldpop: true)
        }
    }
    
    func getNews(){
        self.showLoader()
        newsPresenter.getNews(numPage: 0, onSuccess: { (news) in
            if news.isEmpty {
                self.canLoadMoreData = false
            }
            self.newsList += news
            self.mainIV.sd_setImage(with: URL(string: Urls.baseUrl+self.newsList[0].image! ), placeholderImage: UIImage(named: "placeholder"))
            self.titleLabel.text = self.newsList[0].name
            self.dateLabel.text = self.newsList[0].date
            self.newsTV.reloadData()
            self.hideLoader()
        }) { (errorMessage) in
            self.hideLoader()
            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
        }
    }
    
//    func getVideos(){
//        self.showLoader()
//        videosPresenter.getVideos(numPage: 0, onSuccess: { (videos) in
//            if videos.isEmpty {
//                self.canLoadMoreData = false
//            }
//            self.videos += videos
//            self.mainIV.sd_setImage(with: URL(string: Urls.baseUrl+self.videos[0].image! ), placeholderImage: UIImage(named: "placeholder"))
//            self.titleLabel.text = self.videos[0].name
//            self.newsTV.reloadData()
//            self.hideLoader()
//        }) { (errorMessage) in
//            self.hideLoader()
//            self.showAlert(title: "", message: errorMessage ?? "", shouldpop: false)
//        }
//    }
    
    func addRoundCornersAndShadows(){
        roundViewCorners(view: mainView)
        self.mainIV.layer.cornerRadius = 10
        self.mainIV.clipsToBounds = true
        self.shadowView.layer.cornerRadius = 10
        self.shadowView.clipsToBounds = true
    }

}
