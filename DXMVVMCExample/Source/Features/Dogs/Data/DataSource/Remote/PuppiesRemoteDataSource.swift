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
    
    private var networkEngine: NetworkEngineProtocol
    
    init(networkEngine: NetworkEngineProtocol) {
        self.networkEngine = networkEngine
    }
    
    
    func getPuppiesData() -> Single<PostsModel> {
      networkEngine.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Puppies"))
    }
}
