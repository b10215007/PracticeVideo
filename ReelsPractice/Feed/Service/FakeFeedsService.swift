//
//  FakeFeedsService.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

enum FeedsProvidingError: Error {
    case wrongResponse
}

struct FeedsReseponse<T: Decodable>: Decodable {
    let videos: [T]
}

class FakeFeedsService: FeedsProviding {
    
    let delayTime: TimeInterval = 0.8
    let queue = DispatchQueue.global()
    
    private let bundle: Bundle
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    func fetchFeeds(completion: @escaping (Result<[Post], Error>) -> Void) {
        queue.asyncAfter(deadline: .now() + delayTime) { [weak self] in
            self?.fetchFeedsInQueue(completion: completion)
        }
    }
    
    private func fetchFeedsInQueue(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = bundle.url(forResource: "Posts", withExtension: "json") else {
            completion(.failure(FeedsProvidingError.wrongResponse))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(FeedsReseponse<Post>.self, from: data)
            completion(.success(response.videos))
        } catch {
            completion(.failure(FeedsProvidingError.wrongResponse))
        }
    }
}
