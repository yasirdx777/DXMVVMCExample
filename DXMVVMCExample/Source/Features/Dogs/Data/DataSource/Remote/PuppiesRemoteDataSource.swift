//
//  PuppiesRemoteDataSource.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol PuppiesRemoteDataSource {
    func getPuppiesData() -> Single<PostsModel>
}

class PuppiesRemoteDataSourceImpl: PuppiesRemoteDataSource {
    
    private var restClient: RestClientProtocol
    
    init(restClient: RestClientProtocol) {
        self.restClient = restClient
    }
    
    
    func getPuppiesData() -> Single<PostsModel> {
      restClient.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Puppies"))
    }
}
