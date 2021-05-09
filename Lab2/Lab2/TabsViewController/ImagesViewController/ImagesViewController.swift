//
//  ImagesViewController.swift
//  Lab2
//
//  Created by Vadim on 09.05.2021.
//

import UIKit

class ImagesViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    var images: [UIImage] = []
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "ImageCollectionViewCell")
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        collection.setCollectionViewLayout(CustomLayout(), animated: false)
    }
    
    @IBAction func createNewAction(_ sender: Any) {
        imagePicker.present()
    }
}

extension ImagesViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        images.append(image!)
        collection.reloadData()
    }
}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell" , for: indexPath) as! ImageCollectionViewCell
        let image = images[indexPath.row]
        cell.imageView.image = image
        return cell
    }
}
