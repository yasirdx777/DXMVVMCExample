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
    
    private var networkEngine: NetworkEngineProtocol
    
    init(networkEngine: NetworkEngineProtocol) {
        self.networkEngine = networkEngine
    }
    
    
    func getDogsData() -> Single<PostsModel> {
      networkEngine.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Dogs"))
    }
}
