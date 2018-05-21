//
//  DetailViewController.swift
//  CollectionViewTest
//
//  Created by Arya Sreenivasan on 23/03/18.
//  Copyright © 2018 AryaSreenivasan. All rights reserved.
//

import Foundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var portraitBanner: UIImageView!
    @IBOutlet weak var portraitTextView: UITextView!
    @IBOutlet weak var landscapeBanner: UIImageView!
    @IBOutlet weak var landscapeTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var passedDict : RowsManager!
    var noImageAvailable = UIImage(named: "noImageAvailable")
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title
        self.navigationItem.title = passedDict.title
        
        // Set image and detail text
        var urlString = passedDict.imageHref
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        activityIndicator.startAnimating()
        JMImageCache.shared().image(for: URL(string:urlString), completionBlock: { (image) in
            self.portraitBanner.image = image
            self.landscapeBanner.image = image
            self.activityIndicator.stopAnimating()
            }, failureBlock: { (request, response, error) in
                self.portraitBanner.image = self.noImageAvailable
                self.landscapeBanner.image = self.noImageAvailable
                self.activityIndicator.stopAnimating()
        })

        portraitTextView.text = passedDict.descriptionString
        landscapeTextView.text = passedDict.descriptionString
    }
}

        
