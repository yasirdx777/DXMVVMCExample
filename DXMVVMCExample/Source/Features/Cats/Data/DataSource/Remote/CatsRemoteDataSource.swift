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
    
    private var networkEngine: NetworkEngineProtocol
    
    init(networkEngine: NetworkEngineProtocol) {
        self.networkEngine = networkEngine
    }
    
    
    func getCatsData() -> Single<PostsModel> {
      networkEngine.request(type: PostsModel.self , endpoint: GalleryEndpoint.getData(query: "Cats"))
    }
}
