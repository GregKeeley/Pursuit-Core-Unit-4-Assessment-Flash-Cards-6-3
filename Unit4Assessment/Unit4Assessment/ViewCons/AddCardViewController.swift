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
    
    var newFlashCard: Card?
    
    override func loadView() {
        view = addCardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        navigationItem.title = "Create a Flashcard"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(saveFlashCardButtonPressed(_:)))
        addCardView.questionTextField.delegate = self
        }
    
    @objc private func saveFlashCardButtonPressed(_ sender: UIBarButtonItem) {
        let question = addCardView.questionTextField.text
        let fact1 = addCardView.fact1TextView.text ?? ""
        let fact2 = addCardView.fact2TextView.text ?? ""
        
        let card = Card(id: "", cardTitle: "", quizTitle: question, facts: [fact1, fact2])
        newFlashCard = card
        
        guard let newCard = newFlashCard else {
            showAlert(title: "One or more fields left empty", message: "Please fill in each field to save flash card")
            return }
        do {
            try dataPersistence.createItem(newCard)
            showAlert(title: "Flash card saved!", message: "Success")
            
        } catch {
            showAlert(title: "Error", message: "There was an error saving this flash card: \(error)")
        }
    }
    

}
extension AddCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
