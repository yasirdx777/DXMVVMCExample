//
//  DogsRemoteDataSource.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol DogsRemoteDataSource {
    func getDogsData() -> Single<PostsModel>
}

class DogsRemoteDataSourceImpl: DogsRemoteDataSource {
    
    private var restClient: RestClientProtocol
    
    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }
    
    
    func getDogsData() -> Single<PostsModel> {
      restClient.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Dogs"))
    }
}
