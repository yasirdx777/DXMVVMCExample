//
//  DogsRepositroy.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/26/22.
//

import Foundation
import RxSwift

// sourcery: AutoMockable
protocol DogsRepositroy {
    func getDogsData() -> Single<[DogsPost]>
}
