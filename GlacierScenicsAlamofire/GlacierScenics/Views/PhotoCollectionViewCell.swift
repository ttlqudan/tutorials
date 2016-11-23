//
//  PhotoCollectionViewCell.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import Alamofire

class PhotoCollectionViewCell: UICollectionViewCell {

    var photosManager: PhotosManager { return .shared }

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var request: Request?
    var photo: Photo!

    func configure(with photo: Photo) {
        self.photo = photo
        reset()
        loadImage()
    }

    func reset() {
        imageView.image = nil
        request?.cancel()
        captionLabel.isHidden = true
    }

    func loadImage() {
        if let image = photosManager.cachedImage(for: photo.url) {
            populate(with: image)
            return
        }
        downloadImage()
    }

    func downloadImage() {
        loadingIndicator.startAnimating()
        request = photosManager.retrieveImage(for: photo.url) { image in
            self.populate(with: image)
        }
    }

    func populate(with image: UIImage) {
        loadingIndicator.stopAnimating()
        imageView.image = image
        captionLabel.text = photo.name
        captionLabel.isHidden = false
    }

    
    
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            imageView.layer.borderWidth = isSelected ? 10 : 0
        }
    }
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
//        imageView.layer.borderColor = themeColor.cgColor
        isSelected = false
    }
}
