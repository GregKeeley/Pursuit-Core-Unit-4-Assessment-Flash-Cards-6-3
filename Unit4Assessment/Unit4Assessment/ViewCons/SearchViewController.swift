//
//  SearchViewController.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchViewController: UIViewController {
    private let searchView = SearchView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    private var flashCards = [Card]() {
        didSet {
            if flashCards.isEmpty {
                searchView.collectionView.backgroundView = EmptyView(title: "Flash Card Collection is Empty", message: "You can add flash cards by making your own in the create tab, or using the suggestions in the search tab")
            } else {
                searchView.collectionView.backgroundView = nil
                DispatchQueue.main.async {
                    self.searchView.collectionView.reloadData()
                }
                
            }
        }
    }
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.register(SearchFlashCardCell.self, forCellWithReuseIdentifier: "cardCell")
        navigationItem.title = "Search Flash Cards"
        fetchFlashCards()
    }
    private func fetchFlashCards() {
        do {
            let localFlashCards = try FlashCardAPI.fetchLocalFlashCards()
            flashCards = localFlashCards
        } catch {
            print("Failed to parse local flash card: \(error)")
        }
        // NOTE: API went 503, changed out function to parse local data in meantime
        //        FlashCardAPI.getFlashCards() { [weak self] (result) in
        //            switch result {
        //            case .failure(let appError):
        //                print("failed to load flashCards: \(appError)")
        //            case .success(let flashCards):
        //                self?.flashCards = flashCards.cards
        //            }
        //        }
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxwidth = (UIScreen.main.bounds.size.width)
        let adjustedWidth = (maxwidth * 0.95)
        let maxHeight = (UIScreen.main.bounds.height)
        let adjustedHeight = (maxHeight * 0.30)
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? SearchFlashCardCell else {
            fatalError("Failed to downcast as \"cardCell")
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
//        cell.delegate = self
        cell.configureCell(flashCards[indexPath.row])
        return cell
    }
    
    
}
