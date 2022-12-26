//
//  CatsRepositroyImpl.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

class CatsRepositroyImpl: CatsRepositroy {
    
    private var catsRemoteDataSource: CatsRemoteDataSource
    
    init(catsRemoteDataSource: CatsRemoteDataSource) {
        self.catsRemoteDataSource = catsRemoteDataSource
    }
    
    private let disposeBag = DisposeBag()
    
    func getCatsData() -> Single<[CatsPost]> {
        return Single<[CatsPost]>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            
            self.catsRemoteDataSource.getCatsData().subscribe(onSuccess: { catsResponse in
                
                let posts = catsResponse.results.reduce([CatsPost]()) { (partialResult, postModel) -> [CatsPost] in
                    let post = CatsPost(imageUrl: postModel.urls.regular)
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
