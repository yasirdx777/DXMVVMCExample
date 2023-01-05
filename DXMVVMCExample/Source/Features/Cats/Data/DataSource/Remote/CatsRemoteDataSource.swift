//
//  CatsRemoteDataSource.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol CatsRemoteDataSource {
    func getCatsData() -> Single<PostsModel>
}

class CatsRemoteDataSourceImpl: CatsRemoteDataSource {
    
    private var restClient: RestClientProtocol
    
    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }
    
    
    func getCatsData() -> Single<PostsModel> {
      restClient.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Cats"))
    }
}
