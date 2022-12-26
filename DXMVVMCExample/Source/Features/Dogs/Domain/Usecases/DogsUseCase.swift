//
//  DogsUseCase.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol DogsUseCase {
    func execute() -> Single<[DogsPost]>
}

class DogsUseCaseImpl: DogsUseCase {
    private var dogsRepositroy: DogsRepositroy
    
    init(dogsRepositroy: DogsRepositroy) {
        self.dogsRepositroy = dogsRepositroy
    }
    
    func execute() -> Single<[DogsPost]> {
        dogsRepositroy.getDogsData()
    }
}
