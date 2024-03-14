//
//  Model.swift
//  GrishinTest
//
//  Created by Иван Гришин on 14.03.2024.
//

import Foundation

struct Model {
    let randomValue: Int
}

// MARK: - Test data

extension Model {
    static func getTestData() -> [[Model]] {
        Array(repeating: [], count: Int.random(in: 100...120)).map { _ in
            (0...Int.random(in: 10...20)).map { _ in
                Model(randomValue: Int.random(in: 0...100))
            }
        }
    }
}
