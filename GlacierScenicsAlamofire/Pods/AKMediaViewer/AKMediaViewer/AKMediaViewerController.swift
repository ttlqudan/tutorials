//
//  AKMediaViewerController.swift
//  AKMediaViewer
//
//  Created by Diogo Autilio on 3/18/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

let kDefaultOrientationAnimationDuration: TimeInterval = 0.4
let kDefaultControlMargin: CGFloat = 5

// MARK: - PlayerView

public class PlayerView: UIView {
    
    override public class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    func player() -> AVPlayer {
        return (layer as! AVPlayerLayer).player!
    }
    
    func setPlayer(_ player: AVPlayer) {
        (layer as! AVPlayerLayer).player = player
    }
}

// MARK: - AKMediaViewerController

public class AKMediaViewerController : UIViewController, UIScrollViewDelegate {
    
    public var tapGesture = UITapGestureRecognizer()
    public var doubleTapGesture = UITapGestureRecognizer()
    public var controlMargin: CGFloat = 0.0
    public var playerView: UIView?
    public var imageScrollView = AKImageScrollView()
    public var controlView: UIView?
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var accessoryView: UIView!
    @IBOutlet var contentView: UIView!
    
    var accessoryViewTimer: Timer?
    var player: AVPlayer?
    var previousOrientation: UIDeviceOrientation = UIDeviceOrientation.unknown
    var activityIndicator : UIActivityIndicatorView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(AKMediaViewerController.handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        controlMargin = kDefaultControlMargin
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(AKMediaViewerController.handleTap(_:)))
        tapGesture.require(toFail: doubleTapGesture)
        
        view.addGestureRecognizer(tapGesture)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if(player != nil) {
            player!.currentItem!.removeObserver(self, forKeyPath: "presentationSize")
        }
        
        mainImageView = nil
        contentView = nil
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 1
        accessoryView.alpha = 0
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(AKMediaViewerController.orientationDidChangeNotification(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        super.viewDidAppear(animated)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    func isParentSupportingInterfaceOrientation(_ toInterfaceOrientation : UIInterfaceOrientation) -> Bool {
        switch(toInterfaceOrientation)
        {
        case UIInterfaceOrientation.portrait:
            return parent!.supportedInterfaceOrientations.contains(UIInterfaceOrientationMask.portrait)
            
        case UIInterfaceOrientation.portraitUpsideDown:
            return parent!.supportedInterfaceOrientations.contains(UIInterfaceOrientationMask.portraitUpsideDown)
            
        case UIInterfaceOrientation.landscapeLeft:
            return parent!.supportedInterfaceOrientations.contains(UIInterfaceOrientationMask.landscapeLeft)
            
        case UIInterfaceOrientation.landscapeRight:
            return parent!.supportedInterfaceOrientations.contains(UIInterfaceOrientationMask.landscapeRight)
            
        case UIInterfaceOrientation.unknown:
            return true
        }
    }
    
    override public func beginAppearanceTransition(_ isAppearing: Bool, animated: Bool) {
        if(!isAppearing) {
            accessoryView.alpha = 0
            playerView?.alpha = 0
        }
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(playerView != nil) {
            playerView!.frame = mainImageView.bounds
        }
    }
    
    // MARK: - Public
    
    public func updateOrientationAnimated(_ animated: Bool) {
        
        var transform: CGAffineTransform?
        var frame: CGRect
        var duration: TimeInterval = kDefaultOrientationAnimationDuration
        
        if (UIDevice.current.orientation == previousOrientation) {
            return
        }
        
        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation) && UIDeviceOrientationIsLandscape(previousOrientation)) ||
            (UIDeviceOrientationIsPortrait(UIDevice.current.orientation) && UIDeviceOrientationIsPortrait(previousOrientation))
        {
            duration *= 2
        }
        
        if(UIDevice.current.orientation == UIDeviceOrientation.portrait) || isParentSupportingInterfaceOrientation(UIApplication.shared.statusBarOrientation) {
            transform = CGAffineTransform.identity
        } else {
            switch (UIDevice.current.orientation)
            {
                case UIDeviceOrientation.landscapeRight:
                    if(parent!.interfaceOrientation == UIInterfaceOrientation.portrait) {
                        transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
                    } else {
                        transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                    }
                    break
                    
                case UIDeviceOrientation.landscapeLeft:
                    if(parent!.interfaceOrientation == UIInterfaceOrientation.portrait) {
                        transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                    } else {
                        transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
                    }
                    break
                    
                case UIDeviceOrientation.portrait:
                    transform = CGAffineTransform.identity
                    break
                    
                case UIDeviceOrientation.portraitUpsideDown:
                    transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                    break
                    
                case UIDeviceOrientation.faceDown: return
                case UIDeviceOrientation.faceUp: return
                case UIDeviceOrientation.unknown: return
            }
        }
        
        if (animated) {
            frame = contentView.frame
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.contentView.transform = transform!
                self.contentView.frame = frame
            })
        } else {
            frame = self.contentView.frame
            self.contentView.transform = transform!
            self.contentView.frame = frame
        }
        self.previousOrientation = UIDevice.current.orientation
    }
    
    public func showPlayerWithURL(_ url: URL) {
        playerView = PlayerView.init(frame: mainImageView.bounds)
        mainImageView.addSubview(self.playerView!)
        playerView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth , UIViewAutoresizing.flexibleHeight]
        playerView!.isHidden = true
        
        // install loading spinner for remote files
        if(!url.isFileURL) {
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            self.activityIndicator!.frame = UIScreen.main.bounds
            self.activityIndicator!.hidesWhenStopped = true
            view.addSubview(self.activityIndicator!)
            self.activityIndicator!.startAnimating()
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.player = AVPlayer(url: url)
            (self.playerView as! PlayerView).setPlayer(self.player!)
            self.player!.currentItem?.addObserver(self, forKeyPath: "presentationSize", options: NSKeyValueObservingOptions.new, context: nil)
            self.layoutControlView()
            self.activityIndicator?.stopAnimating()
        })
    }
    
    public func focusDidEndWithZoomEnabled(_ zoomEnabled: Bool) {
        if(zoomEnabled && (playerView == nil)) {
            installZoomView()
        }
        
        view.setNeedsLayout()
        showAccessoryView(true)
        playerView?.isHidden = false
        player?.play()
        
        addAccessoryViewTimer()
    }
    
    public func defocusWillStart() {
        if(playerView == nil) {
            uninstallZoomView()
        }
        pinAccessoryView()
        player?.pause()
    }
    
    // MARK: - Private
    
    func addAccessoryViewTimer() {
        if (player != nil) {
            accessoryViewTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(AKMediaViewerController.removeAccessoryViewTimer), userInfo: nil, repeats: false)
        }
    }
    
    func removeAccessoryViewTimer() {
        accessoryViewTimer?.invalidate()
        showAccessoryView(false)
    }
    
    func installZoomView() {
        let scrollView: AKImageScrollView = AKImageScrollView.init(frame: contentView.bounds)
        scrollView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        scrollView.delegate = self
        imageScrollView = scrollView
        contentView.insertSubview(scrollView, at: 0)
        scrollView.displayImage(mainImageView.image!)
        self.mainImageView.isHidden = true
        
        imageScrollView.addGestureRecognizer(doubleTapGesture)
    }
    
    func uninstallZoomView() {
        let frame: CGRect = contentView.convert(imageScrollView.zoomImageView!.frame, from: imageScrollView)
        imageScrollView.isHidden = true
        mainImageView.isHidden = false
        mainImageView.frame = frame
    }
    
    func isAccessoryViewPinned() -> Bool {
        return (accessoryView.superview == view)
    }
    
    func pinView(_ view: UIView) {
        let frame: CGRect = self.view.convert(view.frame, from: view.superview)
        view.transform = view.superview!.transform
        self.view.addSubview(view)
        view.frame = frame
    }
    
    func pinAccessoryView() {
        // Move the accessory views to the main view in order not to be rotated along with the media.
        pinView(accessoryView)
    }
    
    func showAccessoryView(_ visible: Bool) {
        if(visible == accessoryViewsVisible()) {
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.allowUserInteraction], animations: { () -> Void in
            self.accessoryView.alpha = (visible ? 1 : 0)
            }, completion: nil)
    }
    
    func accessoryViewsVisible() -> Bool {
        return (accessoryView.alpha == 1)
    }
    
    func layoutControlView() {
        var frame: CGRect
        let videoFrame: CGRect
        let titleFrame: CGRect
        
        if(isAccessoryViewPinned()) {
            return
        }
        
        if(self.controlView == nil) {
            let controlView: AKVideoControlView = AKVideoControlView.videoControlView()
            controlView.translatesAutoresizingMaskIntoConstraints = false
            controlView.scrubbing.player = player
            self.controlView = controlView
            accessoryView.addSubview(self.controlView!)
        }
        
        videoFrame = buildVideoFrame()
        frame = self.controlView!.frame
        frame.size.width = self.view.bounds.size.width - self.controlMargin * 2
        frame.origin.x = self.controlMargin
        titleFrame = self.controlView!.superview!.convert(titleLabel.frame, from: titleLabel.superview)
        frame.origin.y =  titleFrame.origin.y - frame.size.height - self.controlMargin
        if(videoFrame.size.width > 0) {
            frame.origin.y = min(frame.origin.y, videoFrame.maxY - frame.size.height - self.controlMargin as CGFloat)
        }
        self.controlView!.frame = frame
        
    }
    
    func buildVideoFrame() -> CGRect {
        if(self.player!.currentItem!.presentationSize.equalTo(CGSize.zero)) {
            return CGRect.zero
        }
        
        var frame: CGRect = AVMakeRect(aspectRatio: self.player!.currentItem!.presentationSize, insideRect: self.playerView!.bounds)
        frame = frame.integral
        
        return frame
    }
    
    // MARK: - Actions
    
    func handleTap(_ gesture: UITapGestureRecognizer) {
        if(imageScrollView.zoomScale == imageScrollView.minimumZoomScale) {
            showAccessoryView(!accessoryViewsVisible())
        }
    }
    
    func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        var frame: CGRect = CGRect.zero
        var location: CGPoint
        var contentView: UIView
        var scale: CGFloat
        
        if(imageScrollView.zoomScale == imageScrollView.minimumZoomScale) {
            scale = imageScrollView.maximumZoomScale
            contentView = imageScrollView.delegate!.viewForZooming!(in: imageScrollView)!
            location = gesture.location(in: contentView)
            frame = CGRect(x: location.x*imageScrollView.maximumZoomScale - imageScrollView.bounds.size.width/2, y: location.y*imageScrollView.maximumZoomScale - imageScrollView.bounds.size.height/2, width: imageScrollView.bounds.size.width, height: imageScrollView.bounds.size.height)
        } else {
            scale = imageScrollView.minimumZoomScale
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
            self.imageScrollView.zoomScale = scale
            self.imageScrollView.layoutIfNeeded()
            if (scale == self.imageScrollView.maximumZoomScale) {
                self.imageScrollView.scrollRectToVisible(frame, animated: false)
            }
            }, completion: nil)
    }
    
    // MARK: - <UIScrollViewDelegate>
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageScrollView.zoomImageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        showAccessoryView(imageScrollView.zoomScale == imageScrollView.minimumZoomScale)
    }
    
    // MARK: - Notifications
    
    func orientationDidChangeNotification(_ notification: Notification) {
        updateOrientationAnimated(true)
    }
    
    // MARK: - KVO
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        view.setNeedsLayout()
    }
}
