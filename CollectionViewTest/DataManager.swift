//
//  DataManager.swift
//  CollectionViewTest
//
//  Created by AryaSreenivasan on 22/03/18.
//  Copyright © 2018 AryaSreenivasan. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    var title : String = ""
    var rows : NSMutableArray = []
    
    init(responseDict: NSDictionary) {
        super.init()
        
        if let titleFromResponse = responseDict.object(forKey: "title") as? String {
            self.title = titleFromResponse
        }
        if let rowsFromResponse = responseDict.object(forKey: "rows") as? NSArray {
            self.rows = NSMutableArray(array:rowsFromResponse)
        } 
    }
}
