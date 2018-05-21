//
//  ApiManager.swift
//  CollectionViewTest
//
//  Created by Arya Sreenivasan on 22/03/18.
//  Copyright © 2018 AryaSreenivasan. All rights reserved.
//

import Foundation

class ApiManager: NSObject {
    
    var apiUrlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    func fetchDataFromAPI(completion: @escaping (NSDictionary) -> ()) {
        let url = URL(string:apiUrlString)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                completion([:])
                return
            }
            
            if var responseString = String(data: data, encoding: .ascii) {
                responseString =  responseString.replacingOccurrences(of: "\n", with: "")
                responseString =  responseString.replacingOccurrences(of: "\t", with: "")
                print("responseString = \(responseString)")
                
                if let data = responseString.replacingOccurrences(of: "\n", with: "\\n").data(using: String.Encoding.utf8) {
                    do {
                        let responseDict = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary
                        NSLog("responseDict \(responseDict)")
                        completion(responseDict!)
                        return
                    } catch {
                        NSLog("ERROR \(error.localizedDescription)")
                        completion([:])
                        return
                    }
                }
            }
            completion([:])
            return
        }
        task.resume()
    } 
}
