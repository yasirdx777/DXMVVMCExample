//
//  FirstViewModel.swift
//  MVVM-C Tutorial
//
//  Created by Alexandre Quiblier on 19/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class CatsViewModel {
    
    private var networkEngine: NetworkEngineProtocol
    private var coordinator: RootCoordinator
    
    init(coordinator: RootCoordinator, networkEngine: NetworkEngineProtocol) {
        self.coordinator = coordinator
        self.networkEngine = networkEngine
    }
    
    private let _success = BehaviorRelay<[UITableViewDataSource]>(value: [])
    private let _loading = BehaviorRelay<Bool>(value: false)
    private let _failure = BehaviorRelay<String?>(value: nil)
    
    var success: Driver<[UITableViewDataSource]> {
        return _success.asDriver()
    }
    
    var loading: Driver<Bool> {
        return _loading.asDriver()
    }
    
    var failure: Driver<String?> {
        return _failure.asDriver()
    }
    

    
    func fetchData(){
        
        _loading.accept(true)
        
        var catsListDataSource:CatsListDataSource!
        var kittensListDataSource:KittensListDataSource!
        var networkEngineError:NetworkEngineError?
        
        let urlDownloadQueue = DispatchQueue(label: "me.yasirromaya.cats")
        let urlDownloadGroup = DispatchGroup()
        
        urlDownloadGroup.enter()
        
        networkEngine.request(endpoint: GalleryEndpoint.getData(query: "Cats")) { (result: Result<APIResponse, NetworkEngineError>)  in
            switch result {
            case .success(let catsResponse):
                catsListDataSource = CatsListDataSource(posts: catsResponse.results)
            case .failure(let error):
                networkEngineError = error
            }
        }
        
        networkEngine.request(endpoint: GalleryEndpoint.getData(query: "Kittens")) { (result: Result<APIResponse, NetworkEngineError>)  in
            switch result {
            case .success(let kittensResponse):
                kittensListDataSource = KittensListDataSource(posts: kittensResponse.results)
            case .failure(let error):
                networkEngineError = error
            }
            
            urlDownloadQueue.async {
                urlDownloadGroup.leave()
            }
        }
        
        urlDownloadGroup.notify(queue: DispatchQueue.global()) { [weak self]  in
            DispatchQueue.main.async {
                self?._loading.accept(false)
                if let error = networkEngineError {
                    self?._failure.accept(error.localizedDescription)
                }else{
                    self?._success.accept([catsListDataSource, kittensListDataSource])
                }
            }
        }
    }
}
