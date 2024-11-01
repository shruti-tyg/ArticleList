
import Foundation
import UIKit

public typealias Parameter = [String:Any]



struct ConstantsFile
{
    static let appVersion =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let baseUrl:String = "https://mocki.io/v1/"


    
    static let api =  "e91eafa6-46f7-4bd1-87f7-2770c7b7e194"

    
    static let msgTitleOfApp : String = "Task App"
    static let noNetworkMessage : String = "Please check your internet connection and try again"

  

}
