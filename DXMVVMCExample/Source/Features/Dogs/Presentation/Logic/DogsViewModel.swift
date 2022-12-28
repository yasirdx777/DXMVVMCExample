//
//  DogsViewModel.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift
import RxCocoa

final class DogsViewModel {
    
    private var dogsUseCase: DogsUseCase
    private var puppiesUseCase: PuppiesUseCase
    
    init(dogsUseCase: DogsUseCase, puppiesUseCase: PuppiesUseCase) {
        self.dogsUseCase = dogsUseCase
        self.puppiesUseCase = puppiesUseCase
    }
    
    private let disposeBag = DisposeBag()
    
    private let _success = BehaviorRelay<[[DogsPost]]>(value: [])
    private let _loading = BehaviorRelay<Bool>(value: false)
    private let _failure = BehaviorRelay<String?>(value: nil)
    
    var success: Driver<[[DogsPost]]> {
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
        
        let dogsRequest = dogsUseCase.execute().asObservable()
        let puppiesRequest = puppiesUseCase.execute().asObservable()
        
        let combinedRequests = Observable.combineLatest(dogsRequest, puppiesRequest).asSingle()
        
        combinedRequests.subscribe(onSuccess: { (dogsResponse, puppiesResponse) in
            self._success.accept([dogsResponse, puppiesResponse])
            self._loading.accept(false)
        }, onFailure: { error in
            self._failure.accept(error.localizedDescription)
            self._loading.accept(false)
        }).disposed(by: disposeBag)
    }
}
