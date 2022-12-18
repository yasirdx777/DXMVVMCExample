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


@testable import DXMVVMCExample




















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
class NetworkEngineProtocolMock: NetworkEngineProtocol {



    //MARK: - request<T: Codable>

    var requestEndpointCompletionCallsCount = 0
    var requestEndpointCompletionCalled: Bool {
        return requestEndpointCompletionCallsCount > 0
    }
    var requestEndpointCompletionReceivedArguments: (endpoint: Endpoint, completion: (Result<T , NetworkEngineError>) -> ())?
    var requestEndpointCompletionReceivedInvocations: [(endpoint: Endpoint, completion: (Result<T , NetworkEngineError>) -> ())] = []
    var requestEndpointCompletionClosure: ((Endpoint, @escaping (Result<T , NetworkEngineError>) -> ()) -> Void)?

    func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T , NetworkEngineError>) -> ()) {
        requestEndpointCompletionCallsCount += 1
        requestEndpointCompletionReceivedArguments = (endpoint: endpoint, completion: completion)
        requestEndpointCompletionReceivedInvocations.append((endpoint: endpoint, completion: completion))
        requestEndpointCompletionClosure?(endpoint, completion)
    }

}
