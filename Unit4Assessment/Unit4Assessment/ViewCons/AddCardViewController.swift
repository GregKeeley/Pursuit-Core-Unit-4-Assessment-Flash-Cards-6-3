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
        let fact1 = addCardView.fact1TextView.text
        let fact2 = addCardView.fact2TextView.text
        if question!.isEmpty || fact1!.isEmpty || fact2!.isEmpty {
            showAlert(title: "One or more fields left empty", message: "Please fill in each field to save flash card")
            return
        }
        newFlashCard = Card(id: "", cardTitle: question, quizTitle: question, facts: [fact1!] + [fact2!])
        guard let newCard = newFlashCard else { return }
        do {
            try dataPersistence.createItem(newCard)
            showAlert(title: "Flash card saved!", message: "Success")
            addCardView.questionTextField.text = ""
            addCardView.fact1TextView.text = ""
            addCardView.fact2TextView.text = ""
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
// Attempting to drop keyboard on textViews
extension AddCardViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
        
    }
}
