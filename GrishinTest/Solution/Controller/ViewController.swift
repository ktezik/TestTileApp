//
//  ViewController.swift
//  GrishinTest
//
//  Created by Иван Гришин on 14.03.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var model: [[Model]]
    private lazy var mainView = CollectionView(collectionTypeModel: .outerCollection(model))
    private var timer: Timer?
    
    // MARK: - Initializer
    
    init(model: [[Model]] = Model.getTestData()) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        mainView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
    }
    
    // MARK: - Private Methods
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.updateModelValues()
            self.mainView.update(model: .outerCollection(model))
        }
    }
    
    private func updateModelValues() {
        model.enumerated().forEach { index, horizontalModels in
            let randomIndex = Int.random(in: 0..<horizontalModels.count)
            guard
                horizontalModels.indices.contains(randomIndex),
                model.indices.contains(index)
            else {
                return
            }
            model[index][randomIndex] = Model(randomValue: Int.random(in: 0...100))
        }
    }
}

