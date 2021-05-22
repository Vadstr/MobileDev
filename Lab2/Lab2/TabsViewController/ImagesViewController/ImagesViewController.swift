//
//  ImagesViewController.swift
//  Lab2
//
//  Created by Vadim on 09.05.2021.
//

import UIKit
import Alamofire

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var images: [ImageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collection.setCollectionViewLayout(CustomLayout(), animated: false)
        findImages()
    }
    
    func findImages() {
        activityIndicator.startAnimating()
        AF.request("https://pixabay.com/api/",parameters: ["key":"19193969-87191e5db266905fe8936d565","per_page":"21","q":"red+car"])
            .validate()
            .responseDecodable(of: ImageArray.self) { [weak self] (response) in
                self?.activityIndicator.stopAnimating()
                guard let response = response.value else { return }
                self?.images = response.hits
                self?.collection.reloadData()
            }
        
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell" , for: indexPath) as! ImageCollectionViewCell
        cell.imageView.sd_setImage(with: URL(string: images[indexPath.row].webformatURL), placeholderImage: UIImage(systemName: "car.2.fill"))
        return cell
    }
}
