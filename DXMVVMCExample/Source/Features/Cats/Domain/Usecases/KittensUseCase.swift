//
//  KittensUseCase.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol KittensUseCase {
    func execute() -> Single<[CatsPost]>
}

class KittensUseCaseImpl: KittensUseCase {
    private var kittensRepositroy: KittensRepositroy
    
    init(kittensRepositroy: KittensRepositroy) {
        self.kittensRepositroy = kittensRepositroy
    }
    
    func execute() -> Single<[CatsPost]> {
        kittensRepositroy.getKittensData()
    }
}
