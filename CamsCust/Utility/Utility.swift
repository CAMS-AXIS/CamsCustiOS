//
//  Utility.swift

//  Copyright © 2020 webskitters. All rights reserved.
//

import UIKit

class Utility : NSObject{
    override init() {
        super.init()
    }
    class func getUserDefault() -> UserDefaults {
        let userDefaults = UserDefaults.standard
        return userDefaults
    }
    class func syncUserDefault(_ userDefaults:UserDefaults) {
        
        userDefaults.synchronize()
    }
    class func saveObject(inUserDefaults object: Any, forKey key: String) {
        
        let userDef: UserDefaults? = Utility.getUserDefault()
        userDef?.set(object, forKey: key)
        Utility.syncUserDefault(userDef!)
    }
    class func deleteObject(_ key: String) {
        let userDef: UserDefaults? = Utility.getUserDefault()
        userDef?.removeObject(forKey: key)
        //set(object, forKey: key)
        Utility.syncUserDefault(userDef!)
    }
    class func getObjectForKey(_ key: String) -> Any {
        var object: Any?
        let userDef: UserDefaults? = Utility.getUserDefault()
        object = userDef?.object(forKey: key)
        return object
    }
    class func getUserID() -> String {
        var object: Any?
        let userDef: UserDefaults? = Utility.getUserDefault()
        // object = userDef?.object(forKey: Constants.USER_ID)
        return String(format:"%@",object as! CVarArg)
    }
    class func isExistObjectForKey(_ key: String) -> Bool {
        var object: Any?
        let userDef: UserDefaults? = Utility.getUserDefault()
        object = userDef?.object(forKey: key)
        if  object != nil {
            return true
        }
        else {
            return false
        }
    }
    class func removeObjectFromUserDefaults(forKey key: String) {
        let userDef: UserDefaults? = Utility.getUserDefault()
        userDef?.removeObject(forKey: key)
        Utility.syncUserDefault(userDef!)
    }
    class func alertWithMessage(title:String,message:String,buttonText:String,viewController:UIViewController,completionHandler:(()->())?) {
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
    class func alertWithOkMessage(title:String,message:String,buttonText:String,viewController:UIViewController,completionHandler:(()->())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction) in
            completionHandler?()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    class func showAlert(message: String, vc: UIViewController)
    {
        let alert = UIAlertController(title: Constant.variableText.appName, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: Constant.variableText.ok, style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    class func validateEmail(_ enteredEmail:String) -> Bool
    {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    class func validateBlankString(_ string : String) -> Bool{
          let trimmed = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
          return trimmed.isEmpty
    }
    
    class func convertDateString(dateString : String!, fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
        if dateString != nil && dateString != ""
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = sourceFormat
            let date = dateFormatter.date(from: dateString)
            dateFormatter.dateFormat = desFormat
            return dateFormatter.string(from: date!)
        }
        return ""
    }
    class func validateUsername(_ enteredName:String) -> Bool
    {
            let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
            return predicateTest.evaluate(with: enteredName)
    }
    class func checkTextSufficientComplexity(text : String) -> Bool{
        
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        print("\(capitalresult)")
        
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")
        
        
        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        
        let specialresult = texttest.evaluate(with: text)
        print("\(specialresult)")
        
        return capitalresult && numberresult && specialresult
        
    }
    
    
}
