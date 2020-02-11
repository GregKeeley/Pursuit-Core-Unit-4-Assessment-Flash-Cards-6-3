//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardsViewController: UIViewController {
    
    private let flashCardView = FlashCardsView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    private var flashCards = [Card]() {
        didSet {
            if flashCards.isEmpty {
                flashCardView.collectionView.backgroundView = EmptyView(title: "Flash Card Collection is Empty", message: "You can add flash cards by making your own in the create tab, or using the suggestions in the search tab")
            } else {
                flashCardView.collectionView.backgroundView = nil
                flashCardView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = flashCardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getFlashCards()
        flashCardView.collectionView.delegate = self
        flashCardView.collectionView.dataSource = self
        flashCardView.collectionView.register(MainFlashCardCell.self, forCellWithReuseIdentifier: "cardCell")
        navigationItem.title = "All Flashcards"
    }

    private func getFlashCards() {
        do {
            flashCards = try dataPersistence.loadItems()
        } catch {
            print("Failed to load flash cards: \(error)")
        }
    }
   
}
extension FlashCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxwidth = (UIScreen.main.bounds.size.width)
        let adjustedWidth = (maxwidth * 0.95)
        let maxHeight = (UIScreen.main.bounds.height)
        let adjustedHeight = (maxHeight * 0.30)
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}
extension FlashCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? MainFlashCardCell else {
            fatalError("Failed to downcast as \"cardCell")
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
//        cell.configureCell(flashCards[indexPath.row])
        return cell
    }
    
    
}
