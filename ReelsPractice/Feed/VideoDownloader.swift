//
//  VideoDownloader.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/21.
//

import Foundation

final class VideoDownloader: NSObject {
    
    private lazy var session: URLSession = URLSession(
        configuration: .ephemeral,
        delegate: self,
        delegateQueue: .main)
    private var task: URLSessionTask?
    
    private var urls: [URL]
    init(urls: [URL]) {
        self.urls = urls
    }
    
    func start() {
        let url = urls.removeFirst()
        download(url)
    }
    
    func resume() {
        task?.resume()
    }
    
    func suspend() {
        task?.suspend()
    }
    
    func cancel() {
        session.invalidateAndCancel()
    }
    
    private func download(_ url: URL) {
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 60)
        
        task = session.dataTask(with: urlRequest)
        task?.resume()
    }
}

extension VideoDownloader: URLSessionDataDelegate {
    
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        
    }
    
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive data: Data
    ) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error == nil {
            
        } else {
            
        }
    }
}
