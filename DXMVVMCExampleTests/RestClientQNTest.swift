//
//  RestClientQNTest.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 1/24/23.
//

import Quick
import Nimble
import RxSwift

@testable import DXMVVMCExample

class RestClientQNTest: QuickSpec {
    
    var session: URLSession!
    var endpointMock: EndpointMock!
    var restClient: RestClientProtocol!
    
    private let disposeBag = DisposeBag()
    
    override func spec() {
        describe("RestClientTest") {
            beforeEach {
                self.endpointMock = EndpointMock()

                // Set url session for mock networking
                let configuration = URLSessionConfiguration.ephemeral
                configuration.protocolClasses = [URLProtocolMock.self]
                self.session = URLSession(configuration: configuration)

                self.restClient = RestClient(session: self.session)
            }
            
            context("when the response is successful") {
                var mockData: Data!
                beforeEach {
                    // Set mock data
                    let dummyData = DummyData(name: "Yugantar")
                    mockData = try! JSONEncoder().encode(dummyData)

                    // Return data in mock request handler
                    URLProtocolMock.requestHandler = { request in
                        return (HTTPURLResponse(), mockData)
                    }
                }
                
                it("should return the expected response") {
                    var response: DummyData!
                    var error: Error!
                    
                    self.restClient.request(type: DummyData.self, endpoint: self.endpointMock).subscribe(onSuccess: { responseData in
                        response = responseData
                    }, onFailure: { err in
                        error = err
                    }).disposed(by: self.disposeBag)
                    
                    expect(response.name).toEventually(equal("Yugantar"))
                    expect(error).toEventually(beNil())
                }
            }
            
            context("when the response is a failure") {
                var error: URLError!
                beforeEach {
                    // Set mock error
                    error = URLError(.unknown)

                    // Return error in mock request handler
                    URLProtocolMock.requestHandler = { request in
                        throw error
                    }
                }
                
                it("should return the expected error") {
                    var response: DummyData!
                    var returnedError: Error!
                    
                    self.restClient.request(type: DummyData.self, endpoint: self.endpointMock).subscribe(onSuccess: { responseData in
                        response = responseData
                    }, onFailure: { err in
                        returnedError = err
                    }).disposed(by: self.disposeBag)
                    
                    expect(response).toEventually(beNil())
                    expect(returnedError as? URLError).toEventually(equal(error))
                }
            }
        }
    }
}
