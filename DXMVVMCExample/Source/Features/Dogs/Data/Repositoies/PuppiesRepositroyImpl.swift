//
//  PuppiesRepositroyImpl.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

class PuppiesRepositroyImpl: PuppiesRepositroy {
    
    private var puppiesRemoteDataSource: PuppiesRemoteDataSource
    
    init(puppiesRemoteDataSource: PuppiesRemoteDataSource) {
        self.puppiesRemoteDataSource = puppiesRemoteDataSource
    }
    
    private let disposeBag = DisposeBag()
    
    func getPuppiesData() -> Single<[DogsPost]> {
        return Single<[DogsPost]>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            
            self.puppiesRemoteDataSource.getPuppiesData().subscribe(onSuccess: { catsResponse in
                
                let posts = catsResponse.results.reduce([DogsPost]()) { (partialResult, postModel) -> [DogsPost] in
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
