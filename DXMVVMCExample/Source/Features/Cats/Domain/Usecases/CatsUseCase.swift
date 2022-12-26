//
//  CatsUseCase.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol CatsUseCase {
    func execute() -> Single<[CatsPost]>
}

class CatsUseCaseImpl: CatsUseCase {
    private var catsRepositroy: CatsRepositroy
    
    init(catsRepositroy: CatsRepositroy) {
        self.catsRepositroy = catsRepositroy
    }
    
    func execute() -> Single<[CatsPost]> {
        catsRepositroy.getCatsData()
    }
}
