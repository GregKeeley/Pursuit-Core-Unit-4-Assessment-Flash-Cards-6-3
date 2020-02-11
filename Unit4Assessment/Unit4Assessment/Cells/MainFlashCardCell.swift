//
//  MainFlashCardCell.swift
//  Unit4Assessment
//
//  Created by Gregory Keeley on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//


import UIKit

class MainFlashCardCell: UICollectionViewCell {
    // custom delegation
    private var currentFlashCard: Card!
    // custom delegation
    weak var delegate: SavedFlashCardDelegate?
    
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
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    public lazy var cellButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        return button
    }()
    
    // custom delegation
    @objc private func moreButtonPressed(_ sender: UIButton) {
        delegate?.didSelectMoreButton(self, flashCard: currentFlashCard)
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            animate()
            return
        }
    }
    
    public func configureCell(_ flashCard: Card) {
        currentFlashCard = flashCard
        questionLabel.text = flashCard.cardTitle
        for fact in flashCard.facts {
            answerLabel.text = fact
        }
    }
    
    private var isShowingAnswer = false
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()

    private func animate() {
        let duration: Double = 1.0
        if isShowingAnswer {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.questionLabel.alpha = 1
                self.answerLabel.alpha = 0
                self.isShowingAnswer = false
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.isShowingAnswer = true
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
        addGestureRecognizer(tapGesture)
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
        
            cellButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            cellButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
}
