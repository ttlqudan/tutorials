//
//  PhotosCollectionViewController.swift
//  GlacierScenics
//
//  Created by Todd Kramer on 1/30/16.
//  Copyright © 2016 Todd Kramer. All rights reserved.
//

import UIKit
import AKMediaViewer

private let photoCellIdentifier = "PhotoCell"

class PhotosCollectionViewController: UICollectionViewController , AKMediaViewerDelegate {

    var mediaFocusManager: AKMediaViewerManager?
//    var statusBarHidden: Bool = false
    var photosManager: PhotosManager { return .shared }

    /*
    var largePhotoIndexPath: NSIndexPath? {
        didSet {
            //2
            var indexPaths = [IndexPath]()
            if let largePhotoIndexPath = largePhotoIndexPath {
                indexPaths.append(largePhotoIndexPath as IndexPath)
            }
            if let oldValue = oldValue {
                indexPaths.append(oldValue as IndexPath)
            }
            //3
            collectionView?.performBatchUpdates({
                self.collectionView?.reloadItems(at: indexPaths)
            }) { completed in
                //4
                if let largePhotoIndexPath = self.largePhotoIndexPath {
                    self.collectionView?.scrollToItem(
                        at: largePhotoIndexPath as IndexPath,
                        at: .centeredVertically,
                        animated: true)
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                     shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if largePhotoIndexPath == indexPath as NSIndexPath {
            largePhotoIndexPath = nil
        } else {
            largePhotoIndexPath = indexPath as NSIndexPath
        }
        
//        largePhotoIndexPath = largePhotoIndexPath == indexPath ? nil : indexPath
        return false
    }
 */
//    // New code
//    if indexPath == largePhotoIndexPath {
//    let flickrPhoto = photoForIndexPath(indexPath)
//    var size = collectionView.bounds.size
//    size.height -= topLayoutGuide.length
//    size.height -= (sectionInsets.top + sectionInsets.right)
//    size.width -= (sectionInsets.left + sectionInsets.right)
//    return flickrPhoto.sizeToFillWidthOfSize(size)
//    }
    
    /*
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ObjectIdentifier, for: indexPath) as! FlickrPhotoCell
        var flickrPhoto = photoForIndexPath(indexPath)
        
        //1
        cell.activityIndicator.stopAnimating()
        
        //2
        guard indexPath == largePhotoIndexPath else {
            cell.imageView.image = flickrPhoto.thumbnail
            return cell
        }
        
        //3
        guard flickrPhoto.largeImage == nil else {
            cell.imageView.image = flickrPhoto.largeImage
            return cell
        }
        
        //4
        cell.imageView.image = flickrPhoto.thumbnail
        cell.activityIndicator.startAnimating()
        
        //5
        flickrPhoto.loadLargeImage { loadedFlickrPhoto, error in
            
            //6
            cell.activityIndicator.stopAnimating()
            
            //7
            guard loadedFlickrPhoto.largeImage != nil && error == nil else {
                return
            }
            
            //8
            if let cell = collectionView.cellForItem(at: indexPath) as? FlickrPhotoCell, 
                indexPath == self.largePhotoIndexPath  {
                cell.imageView.image = loadedFlickrPhoto.largeImage
            }
        }
        
        return cell
    }
*/
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    //MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
        
        // akmedia setting
        mediaFocusManager = AKMediaViewerManager.init()
        mediaFocusManager!.delegate = self
        mediaFocusManager!.elasticAnimation = true
        mediaFocusManager!.focusOnPinch = true
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        collectionView?.collectionViewLayout.invalidateLayout()
    }

    //MARK: - Collection View Setup

    func registerCollectionViewCells() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: photoCellIdentifier)
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosManager.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: photo(at: indexPath))
        cell.imageView.tag = indexPath.row

        mediaFocusManager!.installOnView(cell.imageView)
        return cell
    }

    func photo(at indexPath: IndexPath) -> Photo {
        let photos = photosManager.photos
        print("photo at index : #\(indexPath.row)")
        return photos[indexPath.row]
    }
    
    
    // http://stackoverflow.com/questions/31735228/how-to-make-a-simple-collection-view-with-swift
    // MARK: - UICollectionViewDelegate protocol
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!" + " row: #\(indexPath.row)")

    
        //mediaViewerManager.startFocusingView(mediaView)
//        selectedImage = cellImages[indexPath.row] as String
//        selectedLabels = cellLabels[indexPath.row] as String
//        self.performSegueWithIdentifer("showDetail", sender: self)
        
        
    }
    
    
    // change background color when user touches cell
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        
        cell?.isHighlighted = true
        cell?.backgroundColor = UIColor.red
    }
    
    // change background color back when user releases touch
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.isHighlighted = false
        cell?.backgroundColor = UIColor.cyan
    }

    
    
    // MARK: - <AKMediaViewerDelegate>
    func parentViewControllerForMediaViewerManager(_ manager: AKMediaViewerManager) -> UIViewController {
        return self
    }
    func mediaViewerManager(_ manager: AKMediaViewerManager,  mediaURLForView view: UIView) -> URL {
        let index: Int = view.tag
        //        let name: NSString = mediaNames[index] as NSString
        //        let url: URL = Bundle.main.url(forResource: name.deletingPathExtension, withExtension: name.pathExtension)!
//        let url: URL = NSURL("")

        print("mediaUrlForView index : #\(index)")
        let url = URL(string: photosManager.photos[index].url)
        //return URL(string: url)!
        return url!
        //        return "";
    }
    func mediaViewerManager(_ manager: AKMediaViewerManager, titleForView view: UIView) -> String {
        let url: URL = mediaViewerManager(manager, mediaURLForView: view)
        let fileExtension: String = url.pathExtension.lowercased()
        let isVideo: Bool = fileExtension == "mp4" || fileExtension == "mov"
        //TODO another message
        return (isVideo ? "Videos are also supported." : "Of course, you can zoom in and out on the image.")
    }
    func mediaViewerManagerWillAppear(_ manager: AKMediaViewerManager) {
        /*
         *  Call here setDefaultDoneButtonText, if you want to change the text and color of default "Done" button
         *  eg: mediaFocusManager!.setDefaultDoneButtonText("Panda", withColor: UIColor.purple)
         */
//        self.statusBarHidden = true
        if (self.responds(to: #selector(UIViewController.setNeedsStatusBarAppearanceUpdate))) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    func mediaViewerManagerWillDisappear(_ mediaFocusManager: AKMediaViewerManager) {
//        self.statusBarHidden = false
        if (self.responds(to: #selector(UIViewController.setNeedsStatusBarAppearanceUpdate))) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
//        override open var prefersStatusBarHidden: Bool {
//            get {
//                return self.statusBarHidden
//            }
//        }
    
    
}

//MARK: - CollectionView Flow Layout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let spacing: CGFloat = 0.5
        let width = (viewSize.width / 2) - spacing
        let height = (viewSize.width / 3) - spacing
        return CGSize(width: width, height: height)
    }

}
