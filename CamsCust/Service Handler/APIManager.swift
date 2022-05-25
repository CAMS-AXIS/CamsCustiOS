//  APIManager.swift
//  Back4App
//  Created by webskitters on 24/12/19.
//  Copyright © 2019 webskitters. All rights reserved.
import UIKit
import Foundation
import SwiftyJSON
typealias completionService = (_ data: JSON, _ response: URLResponse, _ error: Error?) -> Void
typealias completionService1 = ( _ data: Data,  _ response: URLResponse, _ error: Error?) -> Void

class APIManager: NSObject {

    override init() {
        super.init()
    }
    
    func sendPostRequest(_ dictionary: [String: Any], withMethod method: String, withCompletion block: @escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //print("Dict-----\(dictionary)")
        let postData: Data? = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        request.httpBody = postData
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
            else {
                if block != nil {
                    
                    
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendGetRequest(_ dictionary: [AnyHashable: Any], withMethod method: String, withCompletion block:@escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    
                    
                    do{
                        let jsondata = try JSON(data: tempData, options: [])
                        block(jsondata, tempResponse, error)
                    }
                    catch{}
                }
            }
            else {
                if block != nil {
                   
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendGetRequestWithAccessToken(_ dictionary: [String: Any],accessToken : String, withMethod method: String, withCompletion block: @escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "x-access-token")
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    
                    
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{
                       
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
                
            }
            else {
                if block != nil {
                    
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendGetRequestWithAccessTokenWithQueryParams(value : String, key : String, withMethod method: String, withCompletion block: @escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var urlComponents = URLComponents(string: method)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: key, value: value)
        ]
        
        let request = NSMutableURLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        print(request)
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
            else {
                if block != nil {
                    
                    
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendPostRequestWithQueryParams(dic : [String : Any], withMethod method: String, withCompletion block: @escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var urlComponents = URLComponents(string: method)!
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in dic {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems!.append(queryItem)
        }
        
        
        let request = NSMutableURLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        print(request)
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
            else {
                if block != nil {
                    
                    
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendGetRequestWithQueryParams(dic : [String : Any], withMethod method: String, withCompletion block: @escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var urlComponents = URLComponents(string: method)!
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in dic {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems!.append(queryItem)
        }
        
        
        let request = NSMutableURLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        print(request)
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
            else {
                if block != nil {
                    
                    
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        print(error.localizedDescription)
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendGetRequestWithAccessTokenSearch(search : String, accessToken : String, withMethod method: String, withCompletion block: @escaping completionService1) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var urlComponents = URLComponents(string: method)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "search", value: search)
        ]

        let request = NSMutableURLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        print(request)
        
        let dataTask = session.dataTask(with: request as URLRequest){ (data,response,error) in
            if error != nil{
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    block(tempData, tempResponse, error)
                }
            }
            else {
                if block != nil {
                    block(data!, response!, error)
                }
            }
        }
        
        dataTask.resume()
    }
    func sendPostRequestWithAccessToken(_ dictionary: [String: Any],accessToken : String, withMethod method: String, withCompletion block: @escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(accessToken, forHTTPHeaderField: "x-access-token")
        //print("Dict-----\(dictionary)")
        let postData: Data? = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        request.httpBody = postData
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                    }
                }
            }
            else {
                if block != nil {
                    
                    
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{
                        DataManager.shared.showLoader(text: "Please try again")
                        DataManager.shared.hideLoader(delay: 0.5)
                        
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    func sendGetRequestWithHeader(_ dictionary: [AnyHashable: Any], withMethod method: String, withCompletion block:@escaping completionService) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "GET"
        request.addValue("vindecoder.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        request.addValue("9ae5ed0409mshbe730bf5b2b36e2p1e301ejsn71fd47744f94", forHTTPHeaderField: "X-RapidAPI-Key")
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    
                    
                    do{
                        let jsondata = try JSON(data: tempData, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, tempResponse, error)
                    }
                    catch{}
                }
            }
            else {
                if block != nil {
                    do{
                        let jsondata = try JSON(data: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        block(jsondata, response!, error)
                    }
                    catch{}
                }
            }
        }
        dataTask.resume()
    }
    func sendGetRequestForAccessTokenWithData(with accessToken:String,withParams dictionary: [AnyHashable: Any], withMethod method: String, withCompletion block:@escaping completionService1) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "GET"
        request.addValue(accessToken, forHTTPHeaderField: "x-access-token")
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    block(tempData, tempResponse, error)
                }
            }
            else {
                if block != nil {
                    block(data!, response!, error)
                }
            }
        }
        
        dataTask.resume()
    }
    func sendPostRequestMultipleImageForMultiPartWithAccessToken(_ accessToken: String, andparam dictionary: [String: Any], withMethod method: String, withImage uploadImage:UIImage, withCompletion block: @escaping completionService1) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(accessToken, forHTTPHeaderField: "x-access-token")
        request.httpBody = createBodyWithParameters(parameters: dictionary, boundary: boundary) as Data
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    block(tempData, tempResponse, error)
                }
                // return
            }
            else {
                
                if block != nil {
                    block(data!, response!, error)
                }
            }
        }
        dataTask.resume()
    }
    
    func sendPostRequestWithMultipleImageForMultiPartWithAccessToken(_ accessToken: String, andparam dictionary: [String: Any], withMethod method: String, withImage uploadImage:[UIImage], withCompletion block: @escaping completionService1) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(accessToken, forHTTPHeaderField: "x-access-token")
        request.httpBody = createBodyWithParameters(parameters: dictionary, boundary: boundary) as Data
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    block(tempData, tempResponse, error)
                }
                // return
            }
            else {
                
                if block != nil {
                    block(data!, response!, error)
                }
            }
        }
        dataTask.resume()
    }
    func sendPostRequestMultipleImageForMultiPart(param dictionary: [String: Any], withMethod method: String, withImage uploadImage:UIImage, withCompletion block: @escaping completionService1) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let request = NSMutableURLRequest(url: URL(string: method)!)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
         request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue(accessToken, forHTTPHeaderField: "x-access-token")
        request.httpBody = createBodyWithParameters(parameters: dictionary, boundary: boundary) as Data
        let dataTask = session.dataTask(with: request as URLRequest) { (data,response,error) in
            if error != nil{
                
                print(error!.localizedDescription)
                if block != nil {
                    let tempData : Data = Data()
                    let tempResponse : URLResponse = URLResponse()
                    block(tempData, tempResponse, error)
                }
                // return
            }
            else {
                
                if block != nil {
                    block(data!, response!, error)
                }
            }
        }
        
        dataTask.resume()
    }
    
    func createBodyWithParameters(parameters: [String: Any],boundary: String) -> NSData {
        let body = NSMutableData()
        
        print("parameters===",parameters)
        var i = 0
        for (key, value) in parameters {
            
            print("key:\(key) and value:\(value)")
            
            if(value is String || value is NSString){
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
            else if(value is Bool){
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
            else if (value is [String]){
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        
            else if(value is UIImage){
                
                
                if let data = (value as! UIImage).jpegData(compressionQuality:0.7){
                    
                    let filename = "image\(i).jpg"
                    
                    let mimetype = "image/*"
                    
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                    body.append(data)
                    body.appendString("\r\n")
                    i = i+1
                    
                }
                else{
                    let filename = "image\(i).jpg"
                    
                    let mimetype = "image/*"
                    
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                    body.append(Data())
                    body.appendString("\r\n")
                    i = i+1
                }
                
            }
                
            else if(value is [UIImage]){
                
                var j = 0
                
                for image in value as! [UIImage] {
                    let filename = "image\(j).jpg"
                    let data = image.jpegData(compressionQuality:0.7)
                    let mimetype = "image/*"
                    
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                    body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                    body.append(data!)
                    body.appendString("\r\n")
                    j = j+1
                }
            }
            
            
            else if(value is [NSData]){
                
                var j = 0
                
                for data in value as! [NSData] {
                    let filename = "upload.mov"
                        let mimetype = "video/mov"

                        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
                        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
                    body.append(data as Data)
                    j = j+1
                }
            }
            else if(value is NSData){
              
                let filename = "upload.mov"
                let mimetype = "video/mov"
                
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append(value as! Data)
                i = i+1
                
            }
        }
        body.appendString("--\(boundary)--\r\n")
        return body
    }
    
    
    
    func createBody(parameters: [AnyHashable: Any],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"meal\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    
    func getDataFromUrl(url: URL, withCompletion block: @escaping completionService1) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil{
                return
            }
            else {
                if block != nil{
                    block(data!, response!, error)
                }
            }
            
            }.resume()
    }
    func downloadImage(url: URL, withImage imageView:UIImageView) {
        print("Download Started")
        //        var actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        //        showActivityIndicatory(imgView: imageView, and: actInd)
        getDataFromUrl(url: url) { (data, response, error)  in
            guard error == nil else { return }
            print(response.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                // actInd.stopAnimating()
                imageView.image = UIImage(data: data)
            }
        }
    }
}
