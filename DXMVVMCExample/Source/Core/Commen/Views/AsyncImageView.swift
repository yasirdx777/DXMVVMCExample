//
//  AsyncImageView.swift
//  DXCats
//
//  Created by iQ on 8/25/22.
//

import Foundation
import UIKit


class AsyncImageView: UIView {
    private var _image : UIImage?
    
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
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
