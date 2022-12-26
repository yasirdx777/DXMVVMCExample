//
//  DogsRepositroyImpl.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

class DogsRepositroyImpl: DogsRepositroy {
    
    private var dogsRemoteDataSource: DogsRemoteDataSource
    
    init(dogsRemoteDataSource: DogsRemoteDataSource) {
        self.dogsRemoteDataSource = dogsRemoteDataSource
    }
    
    private let disposeBag = DisposeBag()
    
    func getDogsData() -> Single<[DogsPost]> {
        return Single<[DogsPost]>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            
            self.dogsRemoteDataSource.getDogsData().subscribe(onSuccess: { dogsResponse in
                
                let posts = dogsResponse.results.reduce([DogsPost]()) { (partialResult, postModel) -> [DogsPost] in
                    let post = DogsPost(imageUrl: postModel.urls.regular)
                    var posts = partialResult
                    posts.append(post)
                    return posts
                }
                
                single(.success(posts))
            }, onFailure: { error in
                single(.failure(error))
            }).disposed(by: self.disposeBag)
            
            return Disposables.create {}
        }
    }
}
