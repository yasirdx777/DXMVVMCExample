//
//  KittensRemoteDataSource.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol KittensRemoteDataSource {
    func getKittensData() -> Single<PostsModel>
}

class KittensRemoteDataSourceImpl: KittensRemoteDataSource {
    
    private var networkEngine: NetworkEngineProtocol
    
    init(networkEngine: NetworkEngineProtocol) {
        self.networkEngine = networkEngine
    }
    
    
    func getKittensData() -> Single<PostsModel> {
      networkEngine.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Kittens"))
    }
}
