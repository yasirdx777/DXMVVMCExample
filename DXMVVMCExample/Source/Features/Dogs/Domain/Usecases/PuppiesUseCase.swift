//
//  PuppiesUseCase.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol PuppiesUseCase {
    func execute() -> Single<[DogsPost]>
}

class PuppiesUseCaseImpl: PuppiesUseCase {
    private var puppiesRepositroy: PuppiesRepositroy
    
    init(puppiesRepositroy: PuppiesRepositroy) {
        self.puppiesRepositroy = puppiesRepositroy
    }
    
    func execute() -> Single<[DogsPost]> {
        puppiesRepositroy.getPuppiesData()
    }
}
