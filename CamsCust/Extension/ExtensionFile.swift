//  ExtensionFile.swift
//  Created by webskitters on 26/12/19.
//  Copyright © 2019 webskitters. All rights reserved.
import Foundation
import UIKit
extension UIStoryboard {
    func instantiateViewController<T:UIViewController>(type: T.Type) -> T? {
        debugPrint(type)
        var fullName: String = NSStringFromClass(T.self)
        if let range = fullName.range(of:".", options:.backwards, range:nil, locale: nil){
            fullName = fullName.substring(from: range.upperBound)
        }
        return self.instantiateViewController(withIdentifier:fullName) as? T
    }
    class func mainStoryboard()->UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    class func tabBarStoryboard()->UIStoryboard{
        return UIStoryboard(name: "TabBar", bundle: nil)
    }
}
extension UITableView {
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - frame.size.height
        if y < 0 { return }
        setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }
}

extension UIImageView{
    func imageRound(){
        self.contentMode = .scaleToFill
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}
extension UIView{
    func AddShadow(){
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 4.0); //Here your control your spread
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3.0 //Here your control your blur
        self.clipsToBounds = true
    }
    func shadowWithColor(){
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 4.0); //Here your control your spread
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0 //Here your control your blur

    }
    func AddShadowLowerView(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height: 1)
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,y: bounds.maxY - layer.shadowRadius,width: self.frame.size.width*2,height: layer.shadowRadius)).cgPath
    }
    func shadowWithRound(){
         self.layer.cornerRadius = 25
         self.layer.shadowColor = UIColor.gray.cgColor
         self.layer.shadowOffset = CGSize(width: 0.5, height: 4.0); //Here your control your spread
         self.layer.shadowOpacity = 0.5
         self.layer.shadowRadius = 5.0 //Here your control your blur

     }
    
    func setNormalView(){
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
    
}
extension UIAlertController{
    func alertMessage(title:String,message:String,buttonText:String,viewController:UIViewController,completionHandler:(()->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button click...")
        }
        alert.addAction(action)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
}
extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
extension UITextField{
    func setTextField(txt:String){
        self.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        self.attributedPlaceholder = NSAttributedString(string:txt, attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
    func setTextFieldWhite(txt:String){
        self.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
        self.attributedPlaceholder = NSAttributedString(string:txt, attributes:[NSAttributedString.Key.foregroundColor: UIColor.white])
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.6
        self.layer.borderColor = UIColor.gray.cgColor
        self.clipsToBounds = true
    }
}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
extension UIView {
    func setupView(){
        self.layer.borderColor = UIColor.init(red: 87.0/255.0, green: 146.0/255.0, blue: 221.0/255.0, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 28
        self.clipsToBounds = true
    }
    func viewShadow(){
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1.0
        self.layer.cornerRadius = 15
    }
    
    
    func viewShadow1(){
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1.0
        self.layer.cornerRadius = 30
    }
    
    func SetCornerRadious(vw : UIView)
    {
        vw.layer.cornerRadius = vw.frame.size.height * 0.5
        vw.clipsToBounds = true
    }
    
}
extension UIButton{
    func setupButton(){
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension UIFont{
    class func fontOswaldExtraLight(fontSize:CGFloat) -> UIFont? {
        return UIFont(name: "oswald_extra_light", size: fontSize)
    }
    class func fontPoppinsLight(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "poppins_light", size: fontSize)
    }
    class func fontPoppinsMedium(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "poppins-medium", size: fontSize)
    }
    class func fontOswaldMedium(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "oswald_medium", size: fontSize)
    }
    class func fontPoppinsBold(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "poppins_bold", size: fontSize)
    }
    class func fontPoppinsRegular(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "poppins-regular", size: fontSize)
    }
    class func fontOswaldRegular(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "oswald_regular", size: fontSize)
    }
    class func fontOswaldSemiBold(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "oswald_semi_bold", size: fontSize)
    }
    class func fontOswaldBold(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "oswald_bold", size: fontSize)
    }
    class func fontOswaldLight(fontSize:CGFloat)->UIFont? {
        return UIFont(name: "oswald_light", size: fontSize)
    }
}
extension String {

   func removeHTMLTag() -> String {

       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

    }

}
extension UIImage {
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    // image with rounded corners
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
class ColorPickerView : UIView {

var onColorDidChange: ((_ color: UIColor) -> ())?

let saturationExponentTop:Float = 2.0
let saturationExponentBottom:Float = 1.3

let grayPaletteHeightFactor: CGFloat = 0.1
var rect_grayPalette = CGRect.zero
var rect_mainPalette = CGRect.zero

// adjustable
var elementSize: CGFloat = 1.0 {
    didSet {
        setNeedsDisplay()
    }
}

override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
}

private func setup() {

    self.clipsToBounds = true
    let touchGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.touchedColor(gestureRecognizer:)))
    touchGesture.minimumPressDuration = 0
    touchGesture.allowableMovement = CGFloat.greatestFiniteMagnitude
    self.addGestureRecognizer(touchGesture)
}



override func draw(_ rect: CGRect) {
    let context = UIGraphicsGetCurrentContext()

    rect_grayPalette = CGRect(x: 0, y: 0, width: rect.width, height: rect.height * grayPaletteHeightFactor)
    rect_mainPalette = CGRect(x: 0, y: rect_grayPalette.maxY,
                              width: rect.width, height: rect.height - rect_grayPalette.height)

    // gray palette
    for y in stride(from: CGFloat(0), to: rect_grayPalette.height, by: elementSize) {

        for x in stride(from: (0 as CGFloat), to: rect_grayPalette.width, by: elementSize) {
            let hue = x / rect_grayPalette.width

            let color = UIColor(white: hue, alpha: 1.0)

            context!.setFillColor(color.cgColor)
            context!.fill(CGRect(x:x, y:y, width:elementSize, height:elementSize))
        }
    }

    // main palette
    for y in stride(from: CGFloat(0), to: rect_mainPalette.height, by: elementSize) {

        var saturation = y < rect_mainPalette.height / 2.0 ? CGFloat(2 * y) / rect_mainPalette.height : 2.0 * CGFloat(rect_mainPalette.height - y) / rect_mainPalette.height
        saturation = CGFloat(powf(Float(saturation), y < rect_mainPalette.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
        let brightness = y < rect_mainPalette.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect_mainPalette.height - y) / rect_mainPalette.height

        for x in stride(from: (0 as CGFloat), to: rect_mainPalette.width, by: elementSize) {
            let hue = x / rect_mainPalette.width

            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)

            context!.setFillColor(color.cgColor)
            context!.fill(CGRect(x:x, y: y + rect_mainPalette.origin.y,
                                 width: elementSize, height: elementSize))
        }
    }
}



func getColorAtPoint(point: CGPoint) -> UIColor
{
    var roundedPoint = CGPoint(x:elementSize * CGFloat(Int(point.x / elementSize)),
                               y:elementSize * CGFloat(Int(point.y / elementSize)))

    let hue = roundedPoint.x / self.bounds.width


    // main palette
    if rect_mainPalette.contains(point)
    {
        // offset point, because rect_mainPalette.origin.y is not 0
        roundedPoint.y -= rect_mainPalette.origin.y

        var saturation = roundedPoint.y < rect_mainPalette.height / 2.0 ? CGFloat(2 * roundedPoint.y) / rect_mainPalette.height
            : 2.0 * CGFloat(rect_mainPalette.height - roundedPoint.y) / rect_mainPalette.height

        saturation = CGFloat(powf(Float(saturation), roundedPoint.y < rect_mainPalette.height / 2.0 ? saturationExponentTop : saturationExponentBottom))
        let brightness = roundedPoint.y < rect_mainPalette.height / 2.0 ? CGFloat(1.0) : 2.0 * CGFloat(rect_mainPalette.height - roundedPoint.y) / rect_mainPalette.height

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    // gray palette
    else{

        return UIColor(white: hue, alpha: 1.0)
    }
}


@objc func touchedColor(gestureRecognizer: UILongPressGestureRecognizer){
    let point = gestureRecognizer.location(in: self)
    let color = getColorAtPoint(point: point)

    self.onColorDidChange?(color)
  }
}

extension UIColor {
    
    public var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
}
extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
   extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


extension UITextView {

    private class PlaceholderLabel: UILabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            label.textColor = UIColor.lightGray
            addSubview(label)
            return label
        }
    }

    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)

            textStorage.delegate = self
        }
    }

}

extension UITextView: NSTextStorageDelegate {

    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

}

class LineView : UIView {

    /// An array of optional UIColors (clearColor is used when nil is provided) defining the color of each segment.
    var colors : [UIColor?] = [UIColor?]() {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// An array of CGFloat values to define how much of the view each segment occupies. Should add up to 1.0.
    var values : [CGFloat] = [CGFloat]() {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        let r = self.bounds // the view's bounds
        let numberOfSegments = values.count // number of segments to render

        let ctx = UIGraphicsGetCurrentContext() // get the current context

        var cumulativeValue:CGFloat = 0 // store a cumulative value in order to start each line after the last one
        for i in 0..<numberOfSegments {

            ctx!.setFillColor(colors[i]?.cgColor ?? UIColor.clear.cgColor) // set fill color to the given color if it's provided, else use clearColor
            ctx!.fill(CGRect(x: 0, y: cumulativeValue*r.size.height, width: r.size.width, height: values[i]*r.size.height)) // fill that given segment

            cumulativeValue += values[i] // increment cumulative value
        }
    }
}

extension UIView {
    @IBInspectable
    var isRoundCornered: Bool {
        get {
            return self.isRoundCornered
        }
        set {
            layer.cornerRadius = self.frame.size.height / 2
            self.clipsToBounds = true
        }
    }

    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension Date {
    ///
    /// Provides a humanised date. For instance: 1 minute, 1 week ago, 3 months ago
    ///
    /// - Parameters:
    //      - numericDates: Set it to true to get "1 year ago", "1 month ago" or false if you prefer "Last year", "Last month"
    ///
    func timeAgo(numericDates:Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = self < now ? self : now
        let latest =  self > now ? self : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        //print("")
        //print(components)
        if let year = components.year {
            if (year >= 2) {
                return "\(year) years ago"
            } else if (year >= 1) {
                return numericDates ?  "1 year ago" : "Last year"
            }
        }
        if let month = components.month {
            if (month >= 2) {
                return "\(month) months ago"
            } else if (month >= 1) {
                return numericDates ? "1 month ago" : "Last month"
            }
        }
        if let weekOfMonth = components.weekOfMonth {
            if (weekOfMonth >= 2) {
                return "\(weekOfMonth) weeks ago"
            } else if (weekOfMonth >= 1) {
                return numericDates ? "1 week ago" : "Last week"
            }
        }
        if let day = components.day {
            if (day >= 2) {
                return "\(day) days ago"
            } else if (day >= 1) {
                return numericDates ? "1 day ago" : "Yesterday"
            }
        }
        if let hour = components.hour {
            if (hour >= 2) {
                return "\(hour) hours ago"
            } else if (hour >= 1) {
                return numericDates ? "1 hour ago" : "An hour ago"
            }
        }
        if let minute = components.minute {
            if (minute >= 2) {
                return "\(minute) minutes ago"
            } else if (minute >= 1) {
                return numericDates ? "1 minute ago" : "A minute ago"
            }
        }
        if let second = components.second {
            if (second >= 3) {
                return "\(second) seconds ago"
            }
        }
        return "Just now"
    }
}
