//
//  InjectionContainer.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 12/18/22.
//

import Foundation


// Core Feature
extension Container {
    static let networkEngine = Factory<NetworkEngineProtocol> { NetworkEngine() as NetworkEngineProtocol}
    
    static let imageLoader = Factory<ImageLoader> { ImageLoaderImpl() as ImageLoader}
    static let uiImageLoader = Factory<UIImageLoader> { UIImageLoaderImpl(imageLoader: Container.imageLoader()) as UIImageLoader}
    
    static let navigationController = Factory { CustomNavigationController() }
    
    static let appTabBarController = Factory { AppTabBarController() }
}

// Cats Feature
extension Container {
    static let catsRemoteDataSource = Factory<CatsRemoteDataSource> { CatsRemoteDataSourceImpl(networkEngine: Container.networkEngine()) as CatsRemoteDataSource}
    static let kittensRemoteDataSource = Factory<KittensRemoteDataSource> { KittensRemoteDataSourceImpl(networkEngine: Container.networkEngine()) as KittensRemoteDataSource}
    
    static let catsRepositroy = Factory<CatsRepositroy> { CatsRepositroyImpl(catsRemoteDataSource: Container.catsRemoteDataSource()) as CatsRepositroy}
    static let kittensRepositroy = Factory<KittensRepositroy> { KittensRepositroyImpl(kittensRemoteDataSource: Container.kittensRemoteDataSource()) as KittensRepositroy}
    
    static let catsUseCase = Factory<CatsUseCase> { CatsUseCaseImpl(catsRepositroy: Container.catsRepositroy()) as CatsUseCase}
    static let kittensUseCase = Factory<KittensUseCase> { KittensUseCaseImpl(kittensRepositroy: Container.kittensRepositroy()) as KittensUseCase}
    
    static let catsViewModel = Factory { CatsViewModel(catsUseCase: Container.catsUseCase(), kittensUseCase: Container.kittensUseCase()) }
    
    static let catsCoordinator = Factory { CatsCoordinator(navigationController: Container.navigationController()) }
    
    static let catsViewController = Factory { CatsViewController(viewModel: Container.catsViewModel()) }
}


// Dogs Feature
extension Container {
    static let dogsRemoteDataSource = Factory<DogsRemoteDataSource> { DogsRemoteDataSourceImpl(networkEngine: Container.networkEngine()) as DogsRemoteDataSource}
    static let puppiesRemoteDataSource = Factory<PuppiesRemoteDataSource> { PuppiesRemoteDataSourceImpl(networkEngine: Container.networkEngine()) as PuppiesRemoteDataSource}
    
    static let dogsRepositroy = Factory<DogsRepositroy> { DogsRepositroyImpl(dogsRemoteDataSource: Container.dogsRemoteDataSource()) as DogsRepositroy}
    static let puppiesRepositroy = Factory<PuppiesRepositroy> { PuppiesRepositroyImpl(puppiesRemoteDataSource: Container.puppiesRemoteDataSource()) as PuppiesRepositroy}
    
    static let dogsUseCase = Factory<DogsUseCase> { DogsUseCaseImpl(dogsRepositroy: Container.dogsRepositroy()) as DogsUseCase}
    static let puppiesUseCase = Factory<PuppiesUseCase> { PuppiesUseCaseImpl(puppiesRepositroy: Container.puppiesRepositroy()) as PuppiesUseCase}
    
    static let dogsViewModel = Factory { DogsViewModel(dogsUseCase: Container.dogsUseCase(), puppiesUseCase: Container.puppiesUseCase()) }
    
    static let dogsCoordinator = Factory { DogsCoordinator(navigationController: Container.navigationController()) }
    
    static let dogsViewController = Factory { DogsViewController(viewModel: Container.dogsViewModel()) }
}
