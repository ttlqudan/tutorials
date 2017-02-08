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

class PhotosCollectionViewController: UICollectionViewController , AKMediaViewerDelegate, PhotoUrlDelegate {

    var mediaFocusManager: AKMediaViewerManager?
    var statusBarHidden: Bool = false
    var photosManager: PhotosManager { return .shared }

    //MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
        
        photosManager.delegate = self
        
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
    
    // delegate call (for update collection view)
    func finishedDownloading(photos: [Photo]) {
        DispatchQueue.main.async {  // 메인 스레드 지금은 없어도 됨.
            self.collectionView?.reloadData()
            self.photosManager.reachedEndOfItems = false;    // load 할께 끝났는지 체크는 ? (무한 로딩 방지 필요)
        }
    }

    //MARK: - Collection View Setup
    public func registerCollectionViewCells() {
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: photoCellIdentifier)
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" view cnt : \(photosManager.photos.count)")
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
        let url = URL(string: photosManager.photos[index].url)
        return url!
    }
    func mediaViewerManager(_ manager: AKMediaViewerManager, titleForView view: UIView) -> String {
        return photosManager.photos[view.tag].name
    }
    func mediaViewerManagerWillAppear(_ manager: AKMediaViewerManager) {
        /*
         *  Call here setDefaultDoneButtonText, if you want to change the text and color of default "Done" button
         *  eg: mediaFocusManager!.setDefaultDoneButtonText("Panda", withColor: UIColor.purple)
         */
        self.statusBarHidden = true
        if (self.responds(to: #selector(UIViewController.setNeedsStatusBarAppearanceUpdate))) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    func mediaViewerManagerWillDisappear(_ mediaFocusManager: AKMediaViewerManager) {
        self.statusBarHidden = false
        if (self.responds(to: #selector(UIViewController.setNeedsStatusBarAppearanceUpdate))) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override open var prefersStatusBarHidden: Bool {
        get {
            return self.statusBarHidden
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            //reach bottom
            print("end")
            photosManager.loadPicture()
        }
        
        if (scrollView.contentOffset.y < 0){
            //reach top
            print("top")
        }
        
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            //not top and not bottom
            print("no top or end")
        }
    }
    
}

//MARK: - CollectionView Flow Layout
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = view.bounds.size
        let spacing: CGFloat = 0.5
        let width = (viewSize.width / 3) - spacing * 2
        let height = (viewSize.width / 3) - spacing
        return CGSize(width: width, height: height)
    }

}
