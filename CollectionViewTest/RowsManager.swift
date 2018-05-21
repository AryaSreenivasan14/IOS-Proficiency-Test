//
//  RowsManager.swift
//  CollectionViewTest
//
//  Created by Arya Sreenivasan on 22/03/18.
//  Copyright © 2018 AryaSreenivasan. All rights reserved.
//

import Foundation

class RowsManager: NSObject {
    var title : String = ""
    var descriptionString : String = ""
    var imageHref : String = ""
    
    init(indexDict: NSDictionary) {
        super.init()
        
        if let titleFromResponse = indexDict.object(forKey: "title") as? String {
            self.title = titleFromResponse
        }
        if let titleFromResponse = indexDict.object(forKey: "description") as? String {
            self.descriptionString = titleFromResponse
        }
        if let titleFromResponse = indexDict.object(forKey: "imageHref") as? String {
            self.imageHref = titleFromResponse
        }
    }
}
