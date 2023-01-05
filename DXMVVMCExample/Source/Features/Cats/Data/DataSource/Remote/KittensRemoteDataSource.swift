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
    
    private var restClient: RestClientProtocol
    
    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }
    
    
    func getKittensData() -> Single<PostsModel> {
      restClient.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Kittens"))
    }
}
