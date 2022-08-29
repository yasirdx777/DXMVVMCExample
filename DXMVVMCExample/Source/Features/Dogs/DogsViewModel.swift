//
//  FirstViewModel.swift
//  MVVM-C Tutorial
//
//  Created by Alexandre Quiblier on 19/11/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import Foundation

protocol DogsViewModelProtocol {
    var view: DogsViewProtocol? { get set }
    
    func viewDidLoad()
}


final class DogsViewModel: DogsViewModelProtocol{
    weak var view: DogsViewProtocol?
    
    func viewDidLoad() {
        getData()
    }
    
    private func getData(){
        view?.showLoadingIndicator()
        
        
        var dogsListDataSource:DogsListDataSource!
        var puppiesListDataSource:PuppiesListDataSource!
        var networkEngineError:NetworkEngineError?
        
        let urlDownloadQueue = DispatchQueue(label: "me.yasirromaya.dogs")
        let urlDownloadGroup = DispatchGroup()
        
        urlDownloadGroup.enter()
        
        NetworkEngine().request(endpoint: GalleryEndpoint.getData(query: "Dogs")) { (result: Result<APIResponse, NetworkEngineError>)  in
            switch result {
            case .success(let dogsResponse):
                dogsListDataSource = DogsListDataSource(posts: dogsResponse.results)
            case .failure(let error):
                networkEngineError = error
            }
        }
        
        
        NetworkEngine().request(endpoint: GalleryEndpoint.getData(query: "Puppies")) { (result: Result<APIResponse, NetworkEngineError>)  in
            switch result {
            case .success(let puppiesResponse):
                puppiesListDataSource = PuppiesListDataSource(posts: puppiesResponse.results)
            case .failure(let error):
                networkEngineError = error
            }
            urlDownloadQueue.async {
                urlDownloadGroup.leave()
            }
        }
        
        urlDownloadGroup.notify(queue: DispatchQueue.global()) { [weak self]  in
            DispatchQueue.main.async {
                if let error = networkEngineError {
                    self?.view?.showError(error: error)
                }else{
                    self?.view?.hideLoadingIndicator()
                    self?.view?.updateDataSource(dataSources: [dogsListDataSource, puppiesListDataSource])
                    self?.view?.reloadListData()
                }
            }
        }
    }
}
