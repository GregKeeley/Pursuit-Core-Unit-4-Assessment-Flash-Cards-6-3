//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {

    func testFlashCardModel() {
        let jsonData = """
                        {
                           "cardListType": "q and a",
                           "apiVersion": "1.2.3",
                           "cards": [{
                               "id": "1",
                               "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
                               "facts": [
                                   "Synchronous: waits until the task have completed.",
                                   "Asynchronous: completes a task in the background and can notify you when complete."
                               ]
                           }]
                        }
        """.data(using: .utf8)
        struct FlashCard: Codable & Equatable {
            let cardListType: String
            let cards: Cards
        }
        struct Cards: Codable & Equatable {
            let id: String
            let cardTitle: String
            let facts: String
        }
        let expectedCardTitle = "What is the difference between a synchronous & an asynchronous task?"
        do  {
            let flashCard = try JSONDecoder().decode(FlashCard.self, from: jsonData)
            let actualTitle = flashCard
            XCTAssertEqual(expectedCardTitle, actualTitle)
        } catch {
            
            
        }
    }

}
