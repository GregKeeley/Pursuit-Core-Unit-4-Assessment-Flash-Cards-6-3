//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchFlashCardCell: UICollectionViewCell {
    
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    public lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        label.numberOfLines = 0
        return label
    }()
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .green
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return button
    }()
    public lazy var cellButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return button
    }()
    
    public func configureCell(_ flashCard: Card) {
        questionLabel.text = flashCard.cardTitle
        questionLabel.text = flashCard.quizTitle
        for fact in flashCard.facts {
            answerLabel.text = fact
        }
    }
    
    private var isShowingAnswer = false
    private lazy var tapFlipCardGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    private lazy var addQuestionTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    @objc private func didTapAddButton(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            
            return
        }
    }
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            animate()
            return
        }
    }
    private func animate() {
        let duration: Double = 1.0
        if isShowingAnswer {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.questionLabel.alpha = 1
                self.answerLabel.alpha = 0
                self.isShowingAnswer = true
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.isShowingAnswer = false
                self.questionLabel.alpha = 0
                self.answerLabel.alpha = 1
                self.layoutIfNeeded()
            }, completion: nil)
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
        constraintsAddButton()
        constraintsCellButton()
        addGestureRecognizer(tapFlipCardGesture)
    }
    private func constraintsQuestionLabel() {
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            questionLabel.topAnchor.constraint(equalTo: topAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        ])
    }
    private func constraintsFactsLabel() {
        addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
        answerLabel.topAnchor.constraint(equalTo: topAnchor),
        answerLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        answerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        
        ])
    }
    private func constraintsAddButton() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            addButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        
        ])
    }
    private func constraintsCellButton() {
        addSubview(cellButton)
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            cellButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            cellButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
}
