
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class DataProvider: NSObject {
    
    class var sharedInstance:DataProvider {
        struct Singleton {
            static let instance = DataProvider()
        }
        return Singleton.instance
    }
    let baseUrl:String = "https://mocki.io/v1/"

    var arrayOfTaggedID :  [[String: Any]] = [[String: Any]]()


    
    func getMethodToFetchData(url:String, _ successBlock:@escaping ( _ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
        
        let urlStr = baseUrl + url
        let headers : HTTPHeaders = [ "Content-Type": "application/json",
                                      "Cache-Control": "no-cache"]
          
        let urlRequest = URLRequest(url: URL(string: urlStr)!)
            URLCache.shared.removeCachedResponse(for: urlRequest)
       
        AF.request(urlStr, method: .get, encoding: JSONEncoding.prettyPrinted, headers: headers, interceptor: nil, requestModifier: nil).response { response in
             switch response.result {
             case .success:
                 if let value : Data = (response.value as? Data) {
                     let json = JSON(value)
                     successBlock(json)

                 }
             case .failure(let error):
                 errorBlock(error as NSError)

             }
         }
     }
    
    
    
}
enum ImageFormat: String {
    case png, jpg, gif, tiff, webp, heic, unknown
}


extension ImageFormat {
    static func get(from data: Data) -> ImageFormat {
        switch data[0] {
        case 0x89:
            return .png
        case 0xFF:
            return .jpg
        case 0x47:
            return .gif
        case 0x49, 0x4D:
            return .tiff
        case 0x52 where data.count >= 12:
            let subdata = data[0...11]

            if let dataString = String(data: subdata, encoding: .ascii),
                dataString.hasPrefix("RIFF"),
                dataString.hasSuffix("WEBP")
            {
                return .webp
            }

        case 0x00 where data.count >= 12 :
            let subdata = data[8...11]

            if let dataString = String(data: subdata, encoding: .ascii),
                Set(["heic", "heix", "hevc", "hevx"]).contains(dataString)
                ///OLD: "ftypheic", "ftypheix", "ftyphevc", "ftyphevx"
            {
                return .heic
            }
        default:
            break
        }
        return .unknown
    }

    var contentType: String {
        return "image/\(rawValue)"
    }
}
