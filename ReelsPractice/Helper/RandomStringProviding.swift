//
//  RandomStringProviding.swift
//  ReelsPractice
//
//  Created by Michael Ma on 2024/5/20.
//

import Foundation

protocol RandomStringProviding {
    
}

extension RandomStringProviding {
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
