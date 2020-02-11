//
//  FlashCardAPI.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct FlashCardAPI {
    static func getFlashCards(completion: @escaping (Result<FlashCards,AppError>) -> ()) {
        let endpoint = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"

                guard let url = URL(string: endpoint) else {
                    completion(.failure(.badURL(endpoint)))
                    return
                }
                let request = URLRequest(url: url)
                NetworkHelper.shared.performDataTask(with: request) { (result) in
                    switch result {
                    case .failure(let appError):
                        completion(.failure(.networkClientError(appError)))
                    case .success(let flashCardData):
                        do {
                            let flashCards = try JSONDecoder().decode(FlashCards.self, from: flashCardData)
                            completion(.success(flashCards))
                        } catch {
                            completion(.failure(.decodingError(error)))
                        }
                    }
                }
            }
    static func fetchLocalFlashCards() throws -> [Card] {
        guard let path = Bundle.main.path(forResource: "FlashCardJSONData", ofType: "json") else {
            throw AppError.badURL("path for json data is invalid")
        }
        guard let json = FileManager.default.contents(atPath: path) else {
            throw AppError.noData
        }
        do {
            let flashCards = try JSONDecoder().decode([Card].self, from: json)
            return flashCards
        } catch {
            throw AppError.decodingError(error)
        }
    }
}
