//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardsView: UIView {
    
    public lazy var questionTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter Question here"
        return textField
    }()
    public lazy var fact1TextView: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .white
        return textField
    }()
    public lazy var fact2TextView: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = .white
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        constraintsQuestionTextField()
        constraintsFact1TextField()
        constraintsFact2TextField()
    }
    
    private func constraintsQuestionTextField() {
        addSubview(questionTextField)
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            questionTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            questionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            questionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        
        ])
    }
    private func constraintsFact1TextField() {
        addSubview(fact1TextView)
        fact1TextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            fact1TextView.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 10),
            fact1TextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fact1TextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            fact1TextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 4)
        
        ])
    }
    private func constraintsFact2TextField() {
        addSubview(fact2TextView)
        fact2TextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            fact2TextView.topAnchor.constraint(equalTo: fact1TextView.bottomAnchor, constant: 10),
            fact2TextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fact2TextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            fact2TextView.heightAnchor.constraint(equalTo: fact1TextView.heightAnchor)
        
        ])
    }
}
