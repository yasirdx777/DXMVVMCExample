//
//  ImageLoader.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/16/22.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol ImageLoader {
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoad(_ uuid: UUID)
}

class ImageLoaderImpl: ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }
        
        
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            
            guard let error = error else {
                
                return
            }
            
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
            
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
    
    
}

// sourcery: AutoMockable
protocol UIImageLoader {
    func load(_ url: URL, for imageView: AsyncImageView)
    func cancel(for imageView: AsyncImageView)
}

class UIImageLoaderImpl: UIImageLoader {
    
    private let imageLoader: ImageLoader
    private var uuidMap = [AsyncImageView: UUID]()
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func load(_ url: URL, for imageView: AsyncImageView) {
        let token = imageLoader.loadImage(url) { result in
            
            defer { self.uuidMap.removeValue(forKey: imageView) }
            
            do {
                let image = try result.get()
                
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        
        
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: AsyncImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

