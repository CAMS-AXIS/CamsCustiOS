//
//  Extensions.swift
//  Neyyar Elearning App
//
//  Created by Prakash Vaghasiya on 03/12/20.
//

import Foundation
import UIKit
import AVKit
import FirebaseDynamicLinks

struct ScreenSize {
    static let SCREEN_BOUNDS = UIScreen.main.bounds
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let FRAME = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
}

let appWindow: UIWindow? = {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
    }
    
    return UIApplication.shared.delegate?.window ?? nil
}()

// Device Compatibility
struct K_DEVICE {
    static var isIpadAndMac: Bool {
        if #available(iOS 14.0, *) {
            return (UIDevice.current.userInterfaceIdiom == .mac) || (UIDevice.current.userInterfaceIdiom == .pad)
        }
        return (UIDevice.current.userInterfaceIdiom == .pad)
    }
    static var isMac: Bool {
        if #available(iOS 14.0, *) {
            return (UIDevice.current.userInterfaceIdiom == .mac)
        } else {
            #if targetEnvironment(macCatalyst)
            return true
            #endif
        }
        return false
    }
    static var isIpad: Bool {
        return (UIDevice.current.userInterfaceIdiom == .pad)
    }
    static let isIphone         = (UIDevice.current.userInterfaceIdiom == .phone)
    static let isUnspecified    = (UIDevice.current.userInterfaceIdiom == .unspecified)
}


//MARK: - Date Extensions
extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }

    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                          .withTime,
                                          .withDashSeparatorInDate,
                                          .withColonSeparatorInTime]
        return formatter
    }()
}
//MARK: - Devices Extensions
extension UIDevice {
    
    //::
    static let FRAME = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    //static let IS_TV = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.TV
    
    static let IS_IPHONE_4_OR_LESS =  IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH == 1125.0
    static let IS_IPHONE_LESS_THAN_6 =  IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH < 667.0
    static let IS_IPHONE_LESS_THAN_OR_EQUAL_6 =  IS_IPHONE && ScreenSize.SCREEN_MAX_LENGTH <= 667.0
    
    static let IS_IPHONE_4_OR_LESS_MIN =  IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH < 320.0
    static let IS_IPHONE_5_MIN = IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH == 320.0
    static let IS_IPHONE_6_MIN = IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_6P_MIN = IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_X_MIN = IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH == 375.0
    static let IS_IPHONE_7P_MIN = IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH == 414.0
    static let IS_IPHONE_LESS_THAN_6_MIN =  IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH < 375.0
    static let IS_IPHONE_LESS_THAN_OR_EQUAL_6_MIN =  IS_IPHONE && ScreenSize.SCREEN_MIN_LENGTH <= 375.0
    static let IS_IPAD_ = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO_11 = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1194.0
    static let IS_IPAD_AIR = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1180.0
    static let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH >= 1180 && ScreenSize.SCREEN_MAX_LENGTH <= 1366.0
    //::
    
    
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2426:
            return .iPhone_11Pro
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        default:
            return .unknown
        }
    }
    
}
extension UILabel{
    
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    public var requiredWidth: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.width
    }
}
extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
//MARK: - UIColor Extensions
extension UIColor {
    static func random(from colors: [UIColor]) -> UIColor? {
        return colors.randomElement()
    }
    convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

//MARK: - UIViewController Extensions
extension UIViewController {

    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    func displayToast(message:String)  {
        self.view.makeToast(message, duration: 1.0, position: .center)
        
    }
    //MARK: clear all user default data
    
    func removeUserDefaultValue(key: String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    //::
    public func loadViewController(Storyboard:String,ViewController:String) -> UIViewController
    {
        let storyBoard = UIStoryboard(name: Storyboard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: ViewController)
        return vc
    }
    
    func topMostUIController() -> UIViewController {
        var topController: UIViewController = (appWindow?.rootViewController!)!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    //::
}

//::
extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return ""
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func isValid() -> Bool {
        return (self.isEmpty || self == "" || self == nil || self == "(null)") || self.blank() ? false : true
        
    }
    
    func blank() -> Bool {
        let trimmed = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    
    func isBegin(with string:NSString) -> Bool {
        return self.hasPrefix(string as String) ? true : false
    }
    
    func isEnd(With string : NSString) -> Bool {
        return self.hasSuffix(string as String) ? true : false
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    /**
     Check email
     */
    func isValidEmail() -> Bool {
        let regex : NSString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regex : NSString = "^(?=.*[a-z])(?=.*)(?=.*\\d)(?=.*[$@$!%*?&])[a-z\\d$@$!%*?&]{8,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    /**
     URL validation
     */
    func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    /**
     phone number
     */
    func isValidPhoneNumber() -> Bool {
        let regex : NSString = "^[0-9]\\d{9}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{7,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    /**
     Name with character & white space
     */
    
    func isValidName() -> Bool {
        let regex : NSString = "([A-Za-z ]+)"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
     
    /**
     url
     */
    func isValidUrl() -> Bool {
        let regex : NSString = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    func substring(_ startIndex: Int, length: Int) -> String {
        let start =  self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: startIndex + length)
        return String(self[start..<end])
    }
    
    func hexStringToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func htmlToAttributes() -> NSMutableAttributedString {
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
            NSAttributedString.DocumentType.html]
        let attributedString = (try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                               options: options,
                                                               documentAttributes: nil)) ?? NSMutableAttributedString (string: self)
        return attributedString
    }
    
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(encodedOffset: index)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func addCharacterSpacing(kernValue: Double = 1.15) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        if self.count > 0 {
            attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
        }
        return attributedString
    }
}
//::

//MARK: - UIImageView Extension
extension UIImageView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension String {

  func epoch(dateFormat: String = "d MMMM yyyy", timeZone: String? = nil) -> TimeInterval? {
    // building the formatter
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    if let timeZone = timeZone { formatter.timeZone = TimeZone(identifier: timeZone) }

    // extracting the epoch
    let date = formatter.date(from: self)
    return date?.timeIntervalSince1970
  }

}
extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            // Fallback on earlier versions
            for view in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}
extension UITableView{
    
    func addTableShadow(){
        /*  self.layer.shadowColor = UIColor.lightGray.cgColor
         self.layer.shadowRadius = 5
         self.layer.shadowOpacity = 0.5
         self.layer.shadowOffset = .zero
         self.layer.masksToBounds = false
         */
        self.layer.shadowColor = UIColor.lightGray.cgColor//UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 3.0
    }
}

//::

extension String {
    func replacingLastOccurrenceOfString(_ searchString: String,
                with replacementString: String,
                caseInsensitive: Bool = true) -> String
        {
            let options: String.CompareOptions
            if caseInsensitive {
                options = [.backwards, .caseInsensitive]
            } else {
                options = [.backwards]
            }

            if let range = self.range(of: searchString,
                    options: options,
                    range: nil,
                    locale: nil) {

                return self.replacingCharacters(in: range, with: replacementString)
            }
            return self
        }
}
//MARK:- UITableViewCell
extension UITableViewCell {
    
    // Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}

//MARK:- UICollectionViewCell
extension UICollectionViewCell {
    
    // Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}
//::
extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
           let asset: AVAsset = AVAsset(url: url)
           let imageGenerator = AVAssetImageGenerator(asset: asset)
           do {
               let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
               
               return UIImage(cgImage: thumbnailImage)
           } catch let error {
               print(error)
           }
           return nil
    }
}

//MARK: - UIView Extension

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.tintColor = .gray
            button.setImage(UIImage(named: "pwd"), for: .normal)
        }else{
            button.tintColor = .gray
            button.setImage(UIImage(named: "pwd"), for: .normal)

        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}
//MARK: - UIView Extension
extension UIView{
    
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.addSublayer(borderLayer)
        return borderLayer
    }
    
    func activityStartAnimating(){
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        //backgroundView.alpha = 0.1
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.tag = 475647
        self.addSubview(backgroundView)
        
        let containerView = UIView()
        containerView.frame = CGRect.init(x: 0, y: 0, width: 175, height: 160)
        containerView.center = CGPoint(x:backgroundView.bounds.width/2,y:backgroundView.bounds.height/2)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor.clear
        //containerView.alpha = 0.8
        backgroundView.addSubview(containerView)
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = CGPoint(x:containerView.bounds.width/2,y:containerView.bounds.height/2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor(red: 97.0/255.0, green: 186.0/255.0, blue: 150.0/255.0, alpha: 1.0)
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        containerView.addSubview(activityIndicator)
        
        let lblLoading = UILabel()
        lblLoading.frame = CGRect(x: 0, y: containerView.bounds.height-30, width: containerView.bounds.width, height: 25)
        //lblLoading.text = "Loading..."
        lblLoading.font = lblLoading.font.withSize(22)
        lblLoading.textAlignment = NSTextAlignment.center
        lblLoading.textColor = UIColor.white
        containerView.addSubview(lblLoading)
        
    }
    func activityStartAnimatingWithMsg(textData:String){
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        //backgroundView.alpha = 0.1
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.tag = 475647
        self.addSubview(backgroundView)
        
        let containerView = UIView()
        containerView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 160)
        containerView.center = CGPoint(x:backgroundView.bounds.width/2,y:backgroundView.bounds.height/2)
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = UIColor.black
        containerView.alpha = 0.8
        backgroundView.addSubview(containerView)
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = CGPoint(x:containerView.bounds.width/2,y:containerView.bounds.height/2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        containerView.addSubview(activityIndicator)
        
        let lblLoading = UILabel()
        lblLoading.frame = CGRect(x: 0, y: containerView.bounds.height-30, width: containerView.bounds.width, height: 25)
        lblLoading.text = textData
        lblLoading.font = lblLoading.font.withSize(22)
        lblLoading.textAlignment = NSTextAlignment.center
        lblLoading.textColor = UIColor.white
        containerView.addSubview(lblLoading)
        
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, cornerRadius: CGFloat, viewFrame:CGRect, currentView:UIView ) {
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16.0),
            currentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            currentView.heightAnchor.constraint(equalTo: self.heightAnchor),
            currentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, cornerRadius: CGFloat, frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradientLayer.frame = frame
        gradientLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
        if layer.sublayers?.count ?? 0 >= 1 {
            layer.sublayers?.remove(at: 0)
        }
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        print(gradientLayer.frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientBackgroundwithDirection(colorTop: UIColor, colorBottom: UIColor, cornerRadius: CGFloat, viewFrame:CGRect, currentView:UIView ) {
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            currentView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 16.0),
            currentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            currentView.heightAnchor.constraint(equalTo: self.heightAnchor),
            currentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        var gradientLayer = CAGradientLayer()
        if let existingLayer = (layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
            gradientLayer = existingLayer
        }
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.cornerRadius = cornerRadius
        layer.cornerRadius = cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // SET SHADOW
    func setShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor//UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 3.0
    }
    func setShadowRed() {
        layer.shadowColor = UIColor.red.cgColor//UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 3.0
    }
    
    class var nibView: UINib? {
      return UINib(nibName: String(describing: self), bundle: nil)
    }
    //::
    public func addShadowWithCornerRadius(cornerRadius: CGFloat, maskedCorners: CACornerMask, color: UIColor, offset: CGSize, opacity: Float, shadowRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskedCorners
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
    }
    
    public func addShadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
    }
    
    public func addCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    public func applyBorder(_ width: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = borderColor.cgColor
    }
    
    func addDragging(){
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedAction(_ :)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func draggedAction(_ pan:UIPanGestureRecognizer){
        
        let translation = pan.translation(in: self.superview)
        self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        pan.setTranslation(CGPoint.zero, in: self.superview)
    }
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    enum ViewSide {
        case Top, Bottom, Left, Right
    }

    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color.cgColor

        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        case .Bottom:
            border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        case .Right:
            border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        }

        layer.addSublayer(border)
    }
    
    //::
}

//::
extension Date {
        
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }

}
//::
//MARK: - UIButton Extension
extension UIButton {
    @IBInspectable override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    
    func alignTextBelow(spacing: CGFloat = 6.0) {
        if let image = self.imageView?.image {
            let imageSize: CGSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -imageSize.width, bottom: -(imageSize.height), right: 0.0)
            let labelString = NSString(string: self.titleLabel!.text!)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
    
}

//MARK: - UINavigationController Extension
extension UINavigationController {
    func setCustomNavigationBar(title:String,barColor:UIColor) {
        
        self.title = title
        navigationController?.navigationBar.barTintColor = barColor
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    func displayNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
}

var hasTopNotch: Bool {
    if #available(iOS 11.0, tvOS 11.0, *) {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first?.safeAreaInsets.top ?? 0 > 20
        }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    return false
}

extension UIView {
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}



func setGradient(_ view:UIView, _ colors :[UIColor]) {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [colors[0].cgColor,colors[1].cgColor]
    gradient.locations = [0.0 , 1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = view.frame
    gradient.cornerRadius = 10.0
    view.layer.insertSublayer(gradient, at: 0)
}
extension UIView {


func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
  layer.masksToBounds = false
  layer.shadowColor = color.cgColor
  layer.shadowOpacity = opacity
  layer.shadowOffset = offSet
  layer.shadowRadius = radius

  layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
  layer.shouldRasterize = true
  layer.rasterizationScale = scale ? UIScreen.main.scale : 1
}
    
    
//    func dropShadow(scale: Bool = true) {
//      layer.masksToBounds = false
//      layer.shadowColor = UIColor.gray.cgColor
//      layer.shadowOpacity = 0.5
//      layer.shadowOffset = CGSize(width: -1, height: 1)
//      layer.shadowRadius = 10
//
//      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//      layer.shouldRasterize = true
//      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
    
    func animShow() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    
    func animHide() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension UIViewController {
    
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }

        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}
func delay(delay: Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func convertInAnotherDateFormatter(dateFormatter1: String, dateformatter2: String, date: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = dateFormatter1
    let showDate = inputFormatter.date(from: date) ?? Date()
    inputFormatter.dateFormat = dateformatter2
    return inputFormatter.string(from: showDate)
}

func getDateFromTimeStamp(timeStamp : Double, format : String) -> String {
    var date = Date()
    let dateStr = String(Int(timeStamp))
    if dateStr.count > 10 {
        date = Date(timeIntervalSince1970: (timeStamp / 1000))
    } else {
        date = Date(timeIntervalSince1970: timeStamp)
    }
    
    let dayTimePeriodFormatter = DateFormatter()
    dayTimePeriodFormatter.dateFormat = format
    dayTimePeriodFormatter.timeZone = TimeZone.current
    //dayTimePeriodFormatter.locale = Locale(identifier: "en_US_POSIX")
    let dateString = dayTimePeriodFormatter.string(from: date)
    return dateString
}

func getDateFromString(dateString : String) -> Date {
    if !dateString.isEmpty {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        //dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.date(from: dateString)!
    }
    return Date()
}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

func createDynamicLinkForProfileWithFirebase( userId:String, userImage:String , superViewController:UIViewController,username: String) {
    
    guard let link = URL(string:"https://simiyon.page.link/simi123" + "?" + userId) else {
        return
        
    }
    let dynamicLinksDomain = "https://simiyon.page.link"
    let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomain)
    
    linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.quytech.Video-Consultancy")
    linkBuilder?.iOSParameters?.appStoreID = "1605902406"
    linkBuilder?.iOSParameters?.minimumAppVersion = "1.0"
    
    linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.quytech.Video-Consultancy")
    linkBuilder?.androidParameters?.minimumVersion = 1
    
    linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
    linkBuilder?.socialMetaTagParameters?.title = "\(username)"
    linkBuilder?.socialMetaTagParameters?.descriptionText = ""  //courseTitle
    
    if let encoded = userImage.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
        linkBuilder?.socialMetaTagParameters?.imageURL = URL.init(string:userImage)
    }
    linkBuilder?.link = link
  //  guard let longURL = linkBuilder?.url else { return }
    print("The long dynamic link is \(link)")
    
    let activityViewController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
    superViewController.present(activityViewController, animated: true) {
    }
    
    
    
//    linkBuilder?.shorten(completion: { (url, warnings, error) in
//
//        guard let url = url else { return }
//        print("The short URL is: \(url.absoluteString)")
//        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
//        superViewController.present(activityViewController, animated: true) {
//        }
//    })
    
}
