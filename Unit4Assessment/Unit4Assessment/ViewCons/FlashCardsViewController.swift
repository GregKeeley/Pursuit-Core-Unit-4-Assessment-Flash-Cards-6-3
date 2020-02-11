//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence
// custom Delegation
protocol SavedFlashCardDelegate: AnyObject {
    func didSelectMoreButton(_ mainFlashCardCell: MainFlashCardCell, flashCard: Card)
}

class FlashCardsViewController: UIViewController {
    // custom Delegation
    weak var delegate: SavedFlashCardDelegate?

    
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
    override func viewWillAppear(_ animated: Bool) {
        getFlashCards()
    }
    private func getFlashCards() {
        do {
            flashCards = try dataPersistence.loadItems()
            
        } catch {
            print("Failed to load flash cards: \(error)")
        }
    }
   
}
extension FlashCardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        getFlashCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        getFlashCards()
    }
}
// custom delegation
extension FlashCardsViewController: SavedFlashCardDelegate {
    func didSelectMoreButton(_ savedFlashCardCell: MainFlashCardCell, flashCard: Card) {
            print("didSelectMoreButton: \(flashCard.cardTitle!)")
          let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
                self.deleteCard(flashCard)
            }
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true)
        }
        private func deleteCard(_ flashCard: Card) {
            guard let index = flashCards.firstIndex(of: flashCard) else {
                return
            }
            do {
                try dataPersistence.deleteItem(at: index)
                showAlert(title: "Deleted", message: "Flash card deleted")
                flashCardView.collectionView.reloadData()
            } catch {
                print("error deleting flash card: \(error)")
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        // custom delegation
        cell.delegate = self
        cell.configureCell(flashCards[indexPath.row])
        return cell
    }

}
