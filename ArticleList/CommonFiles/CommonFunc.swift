
import UIKit
import SVProgressHUD

//********************************* Constants *************************************

 let SCREEN_SIZE  = UIScreen.main.bounds
 let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
 let STORYBOARD = UIStoryboard.init(name: "Main", bundle: nil)

//******************************** Show/Hide Hud ********************************//

func showHud(_ title: String?) {
    DispatchQueue.main.async {
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.flat)
        SVProgressHUD.setBackgroundColor(.lightGray)
       // SVProgressHUD.setForegroundColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        if title == "" || title == nil {
            SVProgressHUD.show()
        } else {
            SVProgressHUD.show(withStatus: title)
        }
    }
}

func hideHud () {
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
}



//MARK:-******************************** Show Alert ********************************//

func showAlert(_ title: String?, message: String, onView sender:UIViewController) {
    
    DispatchQueue.main.async {
        showAlert(title, message: message, withAction: nil, with: true, andTitle: "Ok", onView: sender)
    }
}



//MARK:-****************************** Alert message method ******************************//

func showAlert(_ title: String?, message: String, withAction addAction:UIAlertAction?, with isCancel:Bool, andTitle cancelTitle:String, onView sender:UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
    let cancelAction = UIAlertAction(title:cancelTitle, style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        // Add the actions
        if isCancel == true {
            alertController.addAction(cancelAction)
        }
        
        if let action = addAction {
            alertController.addAction(action)
        }
        
        // Present the controller
        sender.present(alertController, animated: true, completion: nil)
    
}






//MARK:-****************************** date format method ******************************//

func formattedDateFromString(dateString: String,  outputformat: String,  inputformat: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputformat
   // "yyyy-MM-dd HH:mm:ss"

    if let date = inputFormatter.date(from: dateString) {

        let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = outputformat

        return outputFormatter.string(from: date)
    }

    return nil
}
func offsetFrom(dateString: String,  inputformat: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputformat
    let date = inputFormatter.date(from: dateString)
    let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
    let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date!, to: Date())

    let seconds = "\(difference.second ?? 0)s"
    let minutes = "\(difference.minute ?? 0)m" + " " + seconds
    let hours = "\(difference.hour ?? 0)h" + " " + minutes
    let days = "\(difference.day ?? 0)d" + " " + hours

    if let day = difference.day, day          > 0 { return days }
    if let hour = difference.hour, hour       > 0 { return hours }
    if let minute = difference.minute, minute > 0 { return minutes }
    if let second = difference.second, second > 0 { return seconds }
    return ""
}

//MARK:-****************************** Shadow method ******************************//
extension UIView{
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 5)
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
       
    }
}
//MARK:-****************************** Rescale Image ******************************//

func setProfileImage(imageToResize: UIImage, onImageView: UIImageView) -> UIImage
{
    let width = imageToResize.size.width
    let height = imageToResize.size.height

    var scaleFactor: CGFloat

    if(width > height)
    {
        scaleFactor = onImageView.frame.size.height / height;
    }
    else
    {
        scaleFactor = onImageView.frame.size.width / width;
    }

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width * scaleFactor, height * scaleFactor), false, 0.0)
    imageToResize.draw(in: CGRectMake(0, 0, width * scaleFactor, height * scaleFactor))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return resizedImage!;
}
