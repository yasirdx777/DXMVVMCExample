//
//  RestClientTest.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 1/22/23.
//

import XCTest
import RxSwift

@testable import DXMVVMCExample


final class RestClientTest: XCTestCase {
    
    var session: URLSession!
    var endpointMock: EndpointMock!
    var restClient: RestClientProtocol!
    
    private let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        endpointMock = EndpointMock()
        
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        session = URLSession(configuration: configuration)
        
        restClient = RestClient(session: session)
    }
    
    override func tearDownWithError() throws {
        restClient = nil
    }
    
    func testSuccessfulResponse() throws {
        
        // Set mock data
        let dummyData = DummyData(name: "Yugantar")
        let mockData = try JSONEncoder().encode(dummyData)
        
        // Return data in mock request handler
        URLProtocolMock.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        restClient.request(type: DummyData.self, endpoint: endpointMock).subscribe(onSuccess: { response in
            // Test
            XCTAssertEqual(response.name, "Yugantar")
            expectation.fulfill()
            
        }, onFailure: { error in
            // Test
            XCTAssertEqual(error.localizedDescription, "")
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        
        
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testFailureResponse() throws {
        
        // Set mock error
        let error = URLError(.unknown)
        
        // Return error in mock request handler
        URLProtocolMock.requestHandler = { request in
            throw URLError(.unknown)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "error")
        
        restClient.request(type: DummyData.self, endpoint: endpointMock).subscribe(onSuccess: { response in
            // Test
            XCTAssertNotEqual(response.name, "Yugantar")
            expectation.fulfill()
        }, onFailure: { error in
            // Test
            XCTAssertEqual(error.localizedDescription, URLError(.unknown).localizedDescription)
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        
        
        wait(for: [expectation], timeout: 1)
    }
    

    
}

struct DummyData: Codable {
    var name: String
}


class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
}

