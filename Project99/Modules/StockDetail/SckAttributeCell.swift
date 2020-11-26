//
//  SckAttributeCell.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class SckAttributeCell: UITableViewCell {
    
    static var cellIdentifier: String = String(describing: SckAttributeCell.self)
    
    lazy var attrNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    lazy var attrValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var viewModel: SckAttributeCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            switch viewModel.position {
            case 0:
                attrNameLabel.text = "Name: "
            case 1:
                attrNameLabel.text = "Hot: "
            case 2:
                attrNameLabel.text = "Ric code: "
            case 3:
                attrNameLabel.text = "Category: "
            default:
                break
            }
            
            attrValueLabel.text = viewModel.value
            
            setupUI()
        }
    }
    
    fileprivate func setupUI() {
        addSubview(attrNameLabel)
        addSubview(attrValueLabel)
        
        NSLayoutConstraint.activate([
            attrNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            attrNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            attrValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -64),
            attrValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            attrValueLabel.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
