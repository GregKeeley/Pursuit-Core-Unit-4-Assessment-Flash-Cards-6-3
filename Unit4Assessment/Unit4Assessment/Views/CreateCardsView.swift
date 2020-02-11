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
    public lazy var fact1TextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter Fact #1 here"
        return textField
    }()
    public lazy var fact2TextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter fact #2 here"
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
        addSubview(fact1TextField)
        fact1TextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            fact1TextField.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 10),
            fact1TextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fact1TextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            fact1TextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 4)
        
        ])
    }
    private func constraintsFact2TextField() {
        addSubview(fact2TextField)
        fact2TextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            fact2TextField.topAnchor.constraint(equalTo: fact1TextField.bottomAnchor, constant: 10),
            fact2TextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fact2TextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            fact2TextField.heightAnchor.constraint(equalTo: fact1TextField.heightAnchor)
        
        ])
    }
}
