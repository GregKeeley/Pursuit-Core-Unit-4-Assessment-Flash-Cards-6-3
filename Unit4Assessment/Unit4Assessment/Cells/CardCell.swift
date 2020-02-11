//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    public lazy var answerLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    public func configureCell(_ flashCard: Card) {
        questionLabel.text = flashCard.cardTitle
        for fact in flashCard.facts {
            answerLabel.text = fact
        }
    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        constraintsFactsLabel()
        constraintsQuestionLabel()
    }
    private func constraintsQuestionLabel() {
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            questionLabel.topAnchor.constraint(equalTo: topAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        ])
    }
    private func constraintsFactsLabel() {
        addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
        questionLabel.topAnchor.constraint(equalTo: topAnchor),
        questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        ])
    }
}
