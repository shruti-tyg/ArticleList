
//
//  Untitled.swift
//  ArticleList
//
//  Created by shruti tyagi on 30/10/24.
//
import UIKit
import SDWebImage

class ArticleDetail: UIViewController {
    @IBOutlet weak var ArticleDetail_TV: UITableView!
    @IBOutlet weak var likeBtn: UIButton!
    var articleDetail : ArticleListing?
    var likedArticleArray : [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.ArticleDetail_TV.rowHeight = UITableView.automaticDimension
        self.ArticleDetail_TV.estimatedRowHeight = 300
        _toUpdateView()

    }
    func _toUpdateView()  {
        if AppData().likedArticle.contains(articleDetail!.title!){
            likeBtn.setImage(UIImage(named: "RedHeart"), for: .normal)
        }else{
            likeBtn.setImage(UIImage(named: "HeartIcon"), for: .normal)

        }
        
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    @IBAction func openLink(_ sender: Any){
        guard let url = URL(string: articleDetail!.htmlUrl!) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func likeBtnAct(_ sender: UIButton){
          likedArticleArray = AppData().likedArticle as! [String]
          print(likedArticleArray)
        if likeBtn.image(for: .normal ) == UIImage(named: "HeartIcon"){
            likeBtn.setImage(UIImage(named: "RedHeart"), for: .normal)
            likedArticleArray.insert(articleDetail!.title!, at: likedArticleArray.count)
            print(likedArticleArray)
        }else{
            likeBtn.setImage(UIImage(named: "HeartIcon"), for: .normal)
            let index = likedArticleArray.firstIndex(of: articleDetail!.title!)
            likedArticleArray.remove(at: index!)
            print(likedArticleArray)

        }
        AppData().likedArticle = likedArticleArray as NSArray
        print(AppData().likedArticle)


    }
}

extension ArticleDetail : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableCell", for: indexPath) as! ArticleTableCell
        
            let url = URL.init(string: articleDetail!.urlToImage ?? "")
            cell.article_Img.sd_setImage(with: url , placeholderImage: UIImage(named: "NoImage"))
            cell.title_Lbl.text = articleDetail!.title
            cell.description_Lbl.text = articleDetail!.content
            let date = offsetFrom(dateString: articleDetail!.publishedAt!, inputformat: "yyyy-MM-dd'T'HH:mm:ssZ")
            cell.publishTime_Lbl.text = date + " ago"
            cell.auther_Lbl.text = "Auther: " + articleDetail!.author!
            cell.bgView.dropShadow()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   

}

