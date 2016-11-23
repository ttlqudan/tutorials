//
//  AKImageScrollView.swift
//  AKMediaViewer
//
//  Created by Diogo Autilio on 3/18/16.
//  Copyright © 2016 AnyKey Entertainment. All rights reserved.
//

import Foundation
import UIKit

public class AKImageScrollView : UIScrollView, UIScrollViewDelegate {
    
    public var zoomImageView: UIImageView?
    
    var imageSize: CGSize = CGSize.zero
    var pointToCenterAfterResize: CGPoint = CGPoint.zero
    var scaleToRestoreAfterResize: CGFloat = 0.0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        bouncesZoom = true
        decelerationRate = UIScrollViewDecelerationRateFast
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // center the zoom view as it becomes smaller than the size of the screen
        let boundsSize: CGSize = self.bounds.size
        var frameToCenter: CGRect = self.zoomImageView!.frame
        
        // center horizontally
        if (frameToCenter.size.width < boundsSize.width) {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        // center vertically
        if (frameToCenter.size.height < boundsSize.height) {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        self.zoomImageView!.frame = frameToCenter
    }
    
    override public var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let sizeChanging: Bool = !newFrame.size.equalTo(self.frame.size)
            
            if (sizeChanging) {
                prepareToResize()
            }
            
            super.frame = newFrame
            
            if (sizeChanging) {
                recoverFromResizing()
            }
        }
    }
    
    // MARK: - Configure scrollView to display new image
    
    public func displayImage(_ image: UIImage) {
        if(zoomImageView == nil) {
            self.zoomScale = 1.0
            
            // make a new UIImageView for the new image
            zoomImageView = UIImageView.init(image: image)
            self.addSubview(zoomImageView!)
        } else {
            self.zoomImageView!.image = image
        }
        configureForImageSize(image.size)
    }
    
    func configureForImageSize(_ imageSize: CGSize) {
        self.imageSize = imageSize
        self.contentSize = imageSize
        setMaxMinZoomScalesForCurrentBounds()
        self.zoomScale = self.minimumZoomScale
    }
    
    func setMaxMinZoomScalesForCurrentBounds() {
        let boundsSize: CGSize = self.bounds.size
        var maxScale: CGFloat = 1
        
        // calculate min/max zoomscale
        let xScale: CGFloat = boundsSize.width  / imageSize.width    // the scale needed to perfectly fit the image width-wise
        let yScale: CGFloat = boundsSize.height / imageSize.height   // the scale needed to perfectly fit the image height-wise
        let minScale: CGFloat = min(xScale, yScale)                   // use minimum of these to allow the image to become fully visible
        
        // Image must fit the screen, even if its size is smaller.
        let xImageScale: CGFloat = maxScale * (imageSize.width / boundsSize.width)
        let yImageScale: CGFloat = maxScale * (imageSize.height / boundsSize.width)
        var maxImageScale: CGFloat = max(xImageScale, yImageScale)
        
        maxImageScale = max(minScale, maxImageScale)
        maxScale = min(maxScale, maxImageScale)
        
        // If the image is smaller than the screen, force it to be zoomed.
        if (minScale > maxScale) {
            maxScale = minScale
        }
        
        self.maximumZoomScale = maxScale
        self.minimumZoomScale = minScale
    }
    
    // MARK: -
    // MARK: Methods called during rotation to preserve the zoomScale and the visible portion of the image
    
    // MARK: - Rotation support
    
    func prepareToResize() {
        let boundsCenter: CGPoint = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        pointToCenterAfterResize = self.convert(boundsCenter, to: zoomImageView)
        
        scaleToRestoreAfterResize = self.zoomScale
        
        // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
        // allowable scale when the scale is restored.
        if (scaleToRestoreAfterResize <= (self.minimumZoomScale + CGFloat(FLT_EPSILON))) {
            scaleToRestoreAfterResize = 0
        }
    }
    
    func recoverFromResizing() {
        setMaxMinZoomScalesForCurrentBounds()
        
        // Step 1: restore zoom scale, first making sure it is within the allowable range.
        let maxZoomScale: CGFloat = max(self.minimumZoomScale, scaleToRestoreAfterResize)
        self.zoomScale = min(self.maximumZoomScale, maxZoomScale)
        
        // Step 2: restore center point, first making sure it is within the allowable range.
        
        // 2a: convert our desired center point back to our own coordinate space
        let boundsCenter: CGPoint = self.convert(pointToCenterAfterResize, to: zoomImageView)
        
        // 2b: calculate the content offset that would yield that center point
        var offset: CGPoint = CGPoint(x: boundsCenter.x - self.bounds.size.width / 2.0, y: boundsCenter.y - self.bounds.size.height / 2.0)
        
        // 2c: restore offset, adjusted to be within the allowable range
        let maxOffset: CGPoint = maximumContentOffset()
        let minOffset: CGPoint = minimumContentOffset()
        
        var realMaxOffset:CGFloat = min(maxOffset.x, offset.x)
        offset.x = max(minOffset.x, realMaxOffset)
        
        realMaxOffset = min(maxOffset.y, offset.y)
        offset.y = max(minOffset.y, realMaxOffset)
        
        self.contentOffset = offset
    }
    
    func maximumContentOffset() -> CGPoint {
        let contentSize: CGSize = self.contentSize
        let boundsSize: CGSize = self.bounds.size
        return CGPoint(x: contentSize.width - boundsSize.width, y: contentSize.height - boundsSize.height)
    }
    
    func minimumContentOffset() -> CGPoint {
        return CGPoint.zero
    }
}
