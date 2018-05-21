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
    var loading = UIImage(named: "loading")
    var noImageAvailable = UIImage(named: "noImageAvailable")
    var rowsArray : NSMutableArray = []
    var flagsArray : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Get response from API Manager Class
    func fetchDataFromAPI() {
        ApiManager().fetchDataFromAPI { (completionValue) in
            let dataManagerObject : DataManager = DataManager(responseDict: completionValue)
            self.navigationItem.title = dataManagerObject.title
            DispatchQueue.main.async {
                self.rowsArray = dataManagerObject.rows
                for _i in 0..<self.rowsArray.count {
                    self.flagsArray.add(String(_i))
                }
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - Table View Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! CollectionViewCell
        cell.cellImageView.image = loading;
        cell.titleLabel.text = "";
        
        if let indexDict = rowsArray.object(at: indexPath.row) as? NSDictionary {
            let rowsManagerObject : RowsManager = RowsManager(indexDict: indexDict)
            cell.titleLabel.text = rowsManagerObject.title
            
            // Fetch image async using JMImageCache Library
            var urlString = rowsManagerObject.imageHref
            urlString = urlString.replacingOccurrences(of: " ", with: "%20")
            cell.activityIndicator.startAnimating()
            JMImageCache.shared().image(for: URL(string:urlString), completionBlock: { (image) in
                cell.cellImageView.image = image
                cell.activityIndicator.stopAnimating()
                // To reload index once the image is loaded
                if (self.flagsArray.object(at: indexPath.row) as! NSString).isEqual(to: "0") {
                    self.flagsArray.replaceObject(at: indexPath.row, with: "0")
                    collectionView.reloadItems(at: [indexPath])
                }
            }, failureBlock: { (request, response, error) in
                cell.cellImageView.image = self.noImageAvailable
                cell.activityIndicator.stopAnimating()
            })
        }
        return cell
    }
    
    // MARK: - UICollectionViewFlowLayoutDelegate (To resize the cells according to content)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var sizeValue = CGSize(width: 200, height: 135) // Default Thumbnail Image Size
        if let indexDict = rowsArray.object(at: indexPath.row) as? NSDictionary {
            let rowsManagerObject : RowsManager = RowsManager(indexDict: indexDict)
            var urlString = rowsManagerObject.imageHref
            urlString = urlString.replacingOccurrences(of: " ", with: "%20")
            JMImageCache.shared().image(for: URL(string:urlString), completionBlock: { (image) in
                sizeValue = (image?.size)!
                if sizeValue.width > UIScreen.main.bounds.size.width {
                    sizeValue = CGSize(width: collectionView.frame.size.width, height: ((UIScreen.main.bounds.size.width*(image?.size.height)!)/(image?.size.width)!))
                }
            }, failureBlock: { (request, response, error) in
            })
        }
        return sizeValue
    }
    
    func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // To call flow layout always, when the collection view bounds change
        return true
    }


}

