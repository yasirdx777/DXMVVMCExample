//
//  CatsViewModel.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/12/22.
//

import Foundation
import RxCocoa
import RxSwift

final class CatsViewModel {
    
    private var catsUseCase: CatsUseCase
    private var kittensUseCase: KittensUseCase
    
    init(catsUseCase: CatsUseCase, kittensUseCase: KittensUseCase) {
        self.catsUseCase = catsUseCase
        self.kittensUseCase = kittensUseCase
    }
    
    private let disposeBag = DisposeBag()
    
    private let _success = BehaviorRelay<[[CatsPost]]>(value: [])
    private let _loading = BehaviorRelay<Bool>(value: false)
    private let _failure = BehaviorRelay<String?>(value: nil)
    
    var success: Driver<[[CatsPost]]> {
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
        
        
        
        let catsRequest = catsUseCase.execute().asObservable()
        let kittensRequest = kittensUseCase.execute().asObservable()
        
        let combinedRequests = Observable.combineLatest(catsRequest, kittensRequest).asSingle()
        
        combinedRequests.subscribe(onSuccess: { (catsResponse, kittensResponse) in
            self._success.accept([catsResponse, kittensResponse])
        }, onFailure: { error in
            self._failure.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
