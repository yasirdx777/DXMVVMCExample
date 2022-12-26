// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import RxSwift
import RxCocoa


@testable import DXMVVMCExample




















class CatsRemoteDataSourceMock: CatsRemoteDataSource {



    //MARK: - getCatsData

    var getCatsDataCallsCount = 0
    var getCatsDataCalled: Bool {
        return getCatsDataCallsCount > 0
    }
    var getCatsDataReturnValue: Single<PostsModel>!
    var getCatsDataClosure: (() -> Single<PostsModel>)?

    func getCatsData() -> Single<PostsModel> {
        getCatsDataCallsCount += 1
        if let getCatsDataClosure = getCatsDataClosure {
            return getCatsDataClosure()
        } else {
            return getCatsDataReturnValue
        }
    }

}
class CatsRepositroyMock: CatsRepositroy {



    //MARK: - getCatsData

    var getCatsDataCallsCount = 0
    var getCatsDataCalled: Bool {
        return getCatsDataCallsCount > 0
    }
    var getCatsDataReturnValue: Single<[CatsPost]>!
    var getCatsDataClosure: (() -> Single<[CatsPost]>)?

    func getCatsData() -> Single<[CatsPost]> {
        getCatsDataCallsCount += 1
        if let getCatsDataClosure = getCatsDataClosure {
            return getCatsDataClosure()
        } else {
            return getCatsDataReturnValue
        }
    }

}
class CatsUseCaseMock: CatsUseCase {



    //MARK: - execute

    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReturnValue: Single<[CatsPost]>!
    var executeClosure: (() -> Single<[CatsPost]>)?

    func execute() -> Single<[CatsPost]> {
        executeCallsCount += 1
        if let executeClosure = executeClosure {
            return executeClosure()
        } else {
            return executeReturnValue
        }
    }

}
class CoordinatorMock: Coordinator {


    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController {
        get { return underlyingNavigationController }
        set(value) { underlyingNavigationController = value }
    }
    var underlyingNavigationController: UINavigationController!

    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startClosure: (() -> Void)?

    func start() {
        startCallsCount += 1
        startClosure?()
    }

}
class DogsRemoteDataSourceMock: DogsRemoteDataSource {



    //MARK: - getDogsData

    var getDogsDataCallsCount = 0
    var getDogsDataCalled: Bool {
        return getDogsDataCallsCount > 0
    }
    var getDogsDataReturnValue: Single<PostsModel>!
    var getDogsDataClosure: (() -> Single<PostsModel>)?

    func getDogsData() -> Single<PostsModel> {
        getDogsDataCallsCount += 1
        if let getDogsDataClosure = getDogsDataClosure {
            return getDogsDataClosure()
        } else {
            return getDogsDataReturnValue
        }
    }

}
class DogsRepositroyMock: DogsRepositroy {



    //MARK: - getDogsData

    var getDogsDataCallsCount = 0
    var getDogsDataCalled: Bool {
        return getDogsDataCallsCount > 0
    }
    var getDogsDataReturnValue: Single<[DogsPost]>!
    var getDogsDataClosure: (() -> Single<[DogsPost]>)?

    func getDogsData() -> Single<[DogsPost]> {
        getDogsDataCallsCount += 1
        if let getDogsDataClosure = getDogsDataClosure {
            return getDogsDataClosure()
        } else {
            return getDogsDataReturnValue
        }
    }

}
class DogsUseCaseMock: DogsUseCase {



    //MARK: - execute

    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReturnValue: Single<[DogsPost]>!
    var executeClosure: (() -> Single<[DogsPost]>)?

    func execute() -> Single<[DogsPost]> {
        executeCallsCount += 1
        if let executeClosure = executeClosure {
            return executeClosure()
        } else {
            return executeReturnValue
        }
    }

}
class ImageLoaderMock: ImageLoader {



    //MARK: - loadImage

    var loadImageCallsCount = 0
    var loadImageCalled: Bool {
        return loadImageCallsCount > 0
    }
    var loadImageReceivedArguments: (url: URL, completion: (Result<UIImage, Error>) -> Void)?
    var loadImageReceivedInvocations: [(url: URL, completion: (Result<UIImage, Error>) -> Void)] = []
    var loadImageReturnValue: UUID?
    var loadImageClosure: ((URL, @escaping (Result<UIImage, Error>) -> Void) -> UUID?)?

    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        loadImageCallsCount += 1
        loadImageReceivedArguments = (url: url, completion: completion)
        loadImageReceivedInvocations.append((url: url, completion: completion))
        if let loadImageClosure = loadImageClosure {
            return loadImageClosure(url, completion)
        } else {
            return loadImageReturnValue
        }
    }

    //MARK: - cancelLoad

    var cancelLoadCallsCount = 0
    var cancelLoadCalled: Bool {
        return cancelLoadCallsCount > 0
    }
    var cancelLoadReceivedUuid: UUID?
    var cancelLoadReceivedInvocations: [UUID] = []
    var cancelLoadClosure: ((UUID) -> Void)?

    func cancelLoad(_ uuid: UUID) {
        cancelLoadCallsCount += 1
        cancelLoadReceivedUuid = uuid
        cancelLoadReceivedInvocations.append(uuid)
        cancelLoadClosure?(uuid)
    }

}
class KittensRemoteDataSourceMock: KittensRemoteDataSource {



    //MARK: - getKittensData

    var getKittensDataCallsCount = 0
    var getKittensDataCalled: Bool {
        return getKittensDataCallsCount > 0
    }
    var getKittensDataReturnValue: Single<PostsModel>!
    var getKittensDataClosure: (() -> Single<PostsModel>)?

    func getKittensData() -> Single<PostsModel> {
        getKittensDataCallsCount += 1
        if let getKittensDataClosure = getKittensDataClosure {
            return getKittensDataClosure()
        } else {
            return getKittensDataReturnValue
        }
    }

}
class KittensRepositroyMock: KittensRepositroy {



    //MARK: - getKittensData

    var getKittensDataCallsCount = 0
    var getKittensDataCalled: Bool {
        return getKittensDataCallsCount > 0
    }
    var getKittensDataReturnValue: Single<[CatsPost]>!
    var getKittensDataClosure: (() -> Single<[CatsPost]>)?

    func getKittensData() -> Single<[CatsPost]> {
        getKittensDataCallsCount += 1
        if let getKittensDataClosure = getKittensDataClosure {
            return getKittensDataClosure()
        } else {
            return getKittensDataReturnValue
        }
    }

}
class KittensUseCaseMock: KittensUseCase {



    //MARK: - execute

    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReturnValue: Single<[CatsPost]>!
    var executeClosure: (() -> Single<[CatsPost]>)?

    func execute() -> Single<[CatsPost]> {
        executeCallsCount += 1
        if let executeClosure = executeClosure {
            return executeClosure()
        } else {
            return executeReturnValue
        }
    }

}
class NetworkEngineProtocolMock: NetworkEngineProtocol {



    //MARK: - request<T: Codable>

    var requestTypeEndpointCallsCount = 0
    var requestTypeEndpointCalled: Bool {
        return requestTypeEndpointCallsCount > 0
    }
    var requestTypeEndpointReceivedArguments: (type: T.Type, endpoint: Endpoint)?
    var requestTypeEndpointReceivedInvocations: [(type: T.Type, endpoint: Endpoint)] = []
    var requestTypeEndpointReturnValue: Single<T>!
    var requestTypeEndpointClosure: ((T.Type, Endpoint) -> Single<T>)?

    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Single<T> {
        requestTypeEndpointCallsCount += 1
        requestTypeEndpointReceivedArguments = (type: type, endpoint: endpoint)
        requestTypeEndpointReceivedInvocations.append((type: type, endpoint: endpoint))
        if let requestTypeEndpointClosure = requestTypeEndpointClosure {
            return requestTypeEndpointClosure(type, endpoint)
        } else {
            return requestTypeEndpointReturnValue
        }
    }

}
class PuppiesRemoteDataSourceMock: PuppiesRemoteDataSource {



    //MARK: - getPuppiesData

    var getPuppiesDataCallsCount = 0
    var getPuppiesDataCalled: Bool {
        return getPuppiesDataCallsCount > 0
    }
    var getPuppiesDataReturnValue: Single<PostsModel>!
    var getPuppiesDataClosure: (() -> Single<PostsModel>)?

    func getPuppiesData() -> Single<PostsModel> {
        getPuppiesDataCallsCount += 1
        if let getPuppiesDataClosure = getPuppiesDataClosure {
            return getPuppiesDataClosure()
        } else {
            return getPuppiesDataReturnValue
        }
    }

}
class PuppiesRepositroyMock: PuppiesRepositroy {



    //MARK: - getPuppiesData

    var getPuppiesDataCallsCount = 0
    var getPuppiesDataCalled: Bool {
        return getPuppiesDataCallsCount > 0
    }
    var getPuppiesDataReturnValue: Single<[DogsPost]>!
    var getPuppiesDataClosure: (() -> Single<[DogsPost]>)?

    func getPuppiesData() -> Single<[DogsPost]> {
        getPuppiesDataCallsCount += 1
        if let getPuppiesDataClosure = getPuppiesDataClosure {
            return getPuppiesDataClosure()
        } else {
            return getPuppiesDataReturnValue
        }
    }

}
class PuppiesUseCaseMock: PuppiesUseCase {



    //MARK: - execute

    var executeCallsCount = 0
    var executeCalled: Bool {
        return executeCallsCount > 0
    }
    var executeReturnValue: Single<[DogsPost]>!
    var executeClosure: (() -> Single<[DogsPost]>)?

    func execute() -> Single<[DogsPost]> {
        executeCallsCount += 1
        if let executeClosure = executeClosure {
            return executeClosure()
        } else {
            return executeReturnValue
        }
    }

}
class UIImageLoaderMock: UIImageLoader {



    //MARK: - load

    var loadForCallsCount = 0
    var loadForCalled: Bool {
        return loadForCallsCount > 0
    }
    var loadForReceivedArguments: (url: URL, imageView: AsyncImageView)?
    var loadForReceivedInvocations: [(url: URL, imageView: AsyncImageView)] = []
    var loadForClosure: ((URL, AsyncImageView) -> Void)?

    func load(_ url: URL, for imageView: AsyncImageView) {
        loadForCallsCount += 1
        loadForReceivedArguments = (url: url, imageView: imageView)
        loadForReceivedInvocations.append((url: url, imageView: imageView))
        loadForClosure?(url, imageView)
    }

    //MARK: - cancel

    var cancelForCallsCount = 0
    var cancelForCalled: Bool {
        return cancelForCallsCount > 0
    }
    var cancelForReceivedImageView: AsyncImageView?
    var cancelForReceivedInvocations: [AsyncImageView] = []
    var cancelForClosure: ((AsyncImageView) -> Void)?

    func cancel(for imageView: AsyncImageView) {
        cancelForCallsCount += 1
        cancelForReceivedImageView = imageView
        cancelForReceivedInvocations.append(imageView)
        cancelForClosure?(imageView)
    }

}
