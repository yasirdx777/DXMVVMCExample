//
//  AsyncImageView.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/25/22.
//

import Foundation
import UIKit


class AsyncImageView: UIView {
    private var _image : UIImage?
    private let imageLoader = Container.uiImageLoader()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        @UsesAutoLayout
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(activityIndicator)
        
        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        self.addConstraints([centerX, centerY])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var image: UIImage? {
        get {
            return _image
        }
        set {
            _image = newValue
            layer.contents = nil
            guard let image = newValue else { return }
            DispatchQueue.global(qos : .userInitiated) .async {
                let decodedImage = self.decodedImage(image)
                DispatchQueue.main.async {
                    self.layer.contents = decodedImage? .cgImage
                }
            }
        }
    }
    
    func decodedImage (_ image : UIImage ) -> UIImage? {
        guard let newImage = image.cgImage else { return nil }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context = CGContext(data : nil, width : newImage.width , height : newImage.height, bitsPerComponent : 8, bytesPerRow : newImage.width * 4 , space: colorSpace, bitmapInfo : CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.draw( newImage , in : CGRect(x : 0 , y : 0, width : newImage.width, height : newImage.height))
        
        let decodedImage = context? .makeImage()
        if let decodedImage = decodedImage {
            return UIImage( cgImage : decodedImage)
        }
        return nil
    }
    
}


extension AsyncImageView {
  func loadImage(at url: URL) {
      imageLoader.load(url, for: self)
  }

  func cancelImageLoad() {
      imageLoader.cancel(for: self)
  }
}
