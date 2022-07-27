//
//  Service.swift
//  PulseSampler
//
//  Created by Ahn Sang Hoon on 2022/07/05.
//

import Foundation

import Alamofire
import Pulse

final class Service: NSObject {
    private let logger = NetworkLogger()
    
    private let url = URL(string: "http://httpbin.org/get")!
    
    private let urlSession = URLSession(configuration: .default)
    
    func request() {
        let task = urlSession.dataTask(with: url)
        task.delegate = self
        task.resume()
    }
    
    func afRequest() {
        // With Manual
        /*
        let session = Alamofire.Session(eventMonitors: [ AFNetworkEventMoinitor(logger: logger)])
    
        session.request(url).response { data in
            print("***** Alamofire Response *****")
            print("\(data)")
            print("******************************")
        }
        */
        
        // With Automatic
        Alamofire.Session(configuration: .default).request(url).response { data in
            print("***** Alamofire Response *****")
            print("\(data)")
            print("******************************")
        }
    }
}

extension Service: URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        logger.logDataTask(dataTask, didReceive: response)
        print("***** URLSession Response *****")
        print("\(response)")
        print("******************************")
        completionHandler(.allow)
    }
}

struct AFNetworkEventMoinitor: EventMonitor {
    private let _logger: NetworkLogger
    
    init(logger: NetworkLogger) {
        self._logger = logger
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        _logger.logDataTask(dataTask, didReceive: data)
    }
}
