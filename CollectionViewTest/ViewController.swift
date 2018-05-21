//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Arya Sreenivasan on 21/5/18.
//  Copyright © 2018 AryaSreenivasan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Get response from API Manager Class
    func fetchDataFromAPI() {
        ApiManager().fetchDataFromAPI { (completionValue) in
            let dataManagerObject : DataManager = DataManager(responseDict: completionValue)
            print(dataManagerObject)
        }
    }
    // MARK: - Table View Methiods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CollectionViewCell
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

