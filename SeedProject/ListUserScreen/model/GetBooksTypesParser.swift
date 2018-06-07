//
//  GetBooksTypesParser.swift
//  SeedProject
//
//  Created by Shailendra Suriyal on 07/06/18.
//  Copyright © 2018 In Time Tec. All rights reserved.
//

import UIKit

@objc protocol GetBookTypesParserDelegate: NSObjectProtocol {
    func didReceiveBookTypes(_ bookTypes: [Book])
    @objc optional func didReceiveError()
}

//parser for web service
class GetBooksTypesParser: NSObject, URLSessionDelegate, URLSessionDownloadDelegate {
    
    var webData: Data?
    
    weak var delegate: GetBookTypesParserDelegate?
    
    //initializing a var using closure
    var session: URLSession {
        
        let defaultConfig = URLSessionConfiguration.default
        defaultConfig.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        
        let session1 = URLSession(configuration: defaultConfig, delegate: self, delegateQueue: nil)
        
        return session1
    }
    
    func getBookTypes() {
        /*
         1. Create a URL
         2. Create a Request
         3. Create a connection
         4. Get the response
         5. Get the data
         */
        
        let url = URL(string: "http://localhost:3000/books")
        
        let task = session.downloadTask(with: url!)
        
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        /*
         do {
         try stmt1
         stmt2
         stmt3
         try stmt4
         } catch() {
         }
         */
        do {
            
            webData = try Data(contentsOf: location)
            let responseString = String(data: webData!, encoding: String.Encoding.utf8)
            print("responseString \(responseString!)")
            
            let data = try JSONSerialization.jsonObject(
                with: webData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String: Any]]
            
            // let status = result["Status"] as! Int
            // if status == 200 {
            //let data = result["data"] as! [[String: Any]]
            var bookTypes: [Book] = []
            
            for i in 0..<data.count {
                let bookType = Book(dictionary: data[i])
                bookTypes.append(bookType)
            }
            DispatchQueue.main.async {
                if self.delegate != nil {
                    self.delegate?.didReceiveBookTypes(bookTypes)
                }
            }
            // }
            
        } catch {
            DispatchQueue.main.async {
                if self.delegate != nil {
                    //if this is implemented
                    if self.delegate!.responds(to: #selector(GetBookTypesParserDelegate.didReceiveError)) {
                        self.delegate!.didReceiveError!()
                    }
                }
            }
        }
        
    }
}
