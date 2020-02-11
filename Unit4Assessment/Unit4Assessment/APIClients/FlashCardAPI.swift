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
    static func getFlashCards(completion: @escaping (Result<FlashCard,AppError>) -> ()) {
        let endpoint = ""
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
                            let flashCards = try JSONDecoder().decode(FlashCard.self, from: flashCardData)
                            completion(.success(flashCards))
                        } catch {
                            completion(.failure(.decodingError(error)))
                        }
                    }
                }
            }
        }
