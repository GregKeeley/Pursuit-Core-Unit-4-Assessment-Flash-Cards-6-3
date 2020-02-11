//
//  FlashCard.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct FlashCard: Codable & Equatable {
    let cardListType: String
    let cards: [Cards]
}
struct Cards: Codable & Equatable {
    let id: String
    let cardTitle: String
    let facts: [String]
}
