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
    
    public var dataPersistence: DataPersistence<FlashCards>!
    
    private var flashCards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
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
        searchView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        fetchFlashCards()
    }
    private func fetchFlashCards() {
        FlashCardAPI.getFlashCards() { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("failed to load flashCards: \(appError)")
            case .success(let flashCards):
                self?.flashCards = flashCards.cards
            }
        }
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
}
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else {
            fatalError("Failed to downcast as \"cardCell")
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.configureCell(flashCards[indexPath.row])
        return cell
    }
    
    
}
