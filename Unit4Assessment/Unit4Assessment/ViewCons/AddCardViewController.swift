//
//  AddCardViewController.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class AddCardViewController: UIViewController {
    
    private let addCardView = CreateCardsView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    private var newFlashCard: Card?
    
    override func loadView() {
        view = addCardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        navigationItem.title = "Create a Flashcard"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(saveFlashCardButtonPressed(_:)))
        }
    @objc private func saveFlashCardButtonPressed(_ sender: UIBarButtonItem) {
        newFlashCard?.cardTitle = addCardView.questionTextField.text
        newFlashCard?.facts.append(addCardView.fact1TextField.text ?? "")
        newFlashCard?.facts.append(addCardView.fact2TextField.text ?? "")
        guard let newFlashCard = newFlashCard else { return }
        do {
            try dataPersistence.createItem(newFlashCard)
            showAlert(title: "Flash card saved!", message: "Success")
        } catch {
            showAlert(title: "Error", message: "There was an error saving this flash card: \(error)")
        }
    }
    

}
