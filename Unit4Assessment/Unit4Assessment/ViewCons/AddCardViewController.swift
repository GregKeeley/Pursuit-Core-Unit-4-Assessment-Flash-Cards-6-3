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
    override func loadView() {
        view = addCardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
    }

}
