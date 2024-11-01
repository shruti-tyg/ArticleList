//
//  ViewController.swift
//  ArticleList
//
//  Created by shruti tyagi on 29/10/24.
//

import UIKit
import SDWebImage

class ArticleListVC: UIViewController {
    @IBOutlet weak var ArticleList_TV: UITableView!
    var article_List : [ArticleListing] = [ArticleListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _ToArticleListData()

    }
    
    func _ToArticleListData()  {
        
        let urlStr =  ConstantsFile.api
        if Reachability.isConnectedToNetwork() {
            startLoader(view: self.view)
            DataProvider.sharedInstance.getMethodToFetchData( url: urlStr, { [self] (json) in
                print(json)
                stopLoader()
                
                if json["status"].string == "ok"{
                    if let list = json["articles"].arrayObject{
                        let article_list = list.map({ (info) -> ArticleListing in
                            ArticleListing.init(object: info)
                        })
                        AppUtils.shared.articleListing = article_list
                        article_List = AppUtils.shared.articleListing!
                    }
                    ArticleList_TV.reloadData()
                }else{
                    Utility.showMessageDialog(onController: self, withTitle:ConstantsFile.msgTitleOfApp, withMessage: json["message"].stringValue)
                }
                
                stopLoader()
            }) {(error) in
                stopLoader()
                
                
            }
        }else{
            stopLoader()
            
            Utility.showMessageDialog(onController: self, withTitle:ConstantsFile.msgTitleOfApp, withMessage: ConstantsFile.noNetworkMessage)
        }
    }
}

extension ArticleListVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article_List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableCell", for: indexPath) as! ArticleTableCell
        if article_List.count > 0{
            let data = article_List[indexPath.row]
            let url = URL.init(string: data.urlToImage ?? "")
            cell.article_Img.sd_setImage(with: url , placeholderImage: UIImage(named: "NoImage"))
            cell.title_Lbl.text = data.title
            cell.description_Lbl.text = data.description
            let date = formattedDateFromString(dateString: data.publishedAt!, outputformat: "MMM dd, yyyy", inputformat:"yyyy-MM-dd'T'HH:mm:ssZ" )
            cell.publishTime_Lbl.text = date
            cell.bgView.dropShadow()
            cell.imgBGView.dropShadow()

        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = self.storyboard!.instantiateViewController(withIdentifier: "ArticleDetail") as? ArticleDetail {
            controller.articleDetail = article_List[indexPath.row]
             self.navigationController?.pushViewController(controller, animated: true)
        }
    }

}

class ArticleTableCell : UITableViewCell {
    @IBOutlet weak var publishTime_Lbl: UILabel!
    @IBOutlet weak var title_Lbl: UILabel!
    @IBOutlet weak var description_Lbl: UILabel!
    @IBOutlet weak var article_Img: UIImageView!
    @IBOutlet weak var auther_Lbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgBGView: UIView!
    @IBOutlet weak var webLinkBtn: UIButton!

}
