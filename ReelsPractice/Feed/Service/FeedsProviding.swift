//
//  FeedsProviding.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Combine

protocol FeedsProviding {
    func fetchFeeds(completion: @escaping (Result<[Post], Error>) -> Void)
}
