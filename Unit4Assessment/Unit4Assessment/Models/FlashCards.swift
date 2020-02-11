//
//  FlashCard.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct FlashCards: Codable & Equatable {
    let cardListType: String
    let cards: [Card]
}
struct Card: Codable & Equatable {
    let id: String
    var cardTitle: String?
    let quizTitle: String?
    var facts: [String]
}
