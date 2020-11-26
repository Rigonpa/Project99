//
//  StockCell.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {
    
    static var cellIdentifier: String = String(describing: StockCell.self)
    
    lazy var stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDeleteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleDeleteButtonPressed() {
        viewModel?.deleteButtonPressed()
    }
    
    var viewModel: StockCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            stockNameLabel.text = viewModel.stock.name
            
            setupUI()
        }
    }
    
    fileprivate func setupUI() {
        addSubview(stockNameLabel)
        addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            stockNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stockNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 64),
            deleteButton.widthAnchor.constraint(equalToConstant: 64)
        ])
    }
}
