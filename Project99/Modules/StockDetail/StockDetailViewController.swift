//
//  StockDetailViewController.swift
//  Project99
//
//  Created by Ricardo González Pacheco on 25/11/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.tableFooterView = UIView()
        table.register(SckAttributeCell.self, forCellReuseIdentifier: SckAttributeCell.cellIdentifier)
        table.rowHeight = 80
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let viewModel: StockDetailViewModel
    init(viewModel: StockDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        title = "Stock detail"
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StockDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier: SckAttributeCell.cellIdentifier, for: indexPath) as? SckAttributeCell,
            let cellViewModel = viewModel.cellForRowAt(indexPath: indexPath) else { fatalError() }
        cell.viewModel = cellViewModel
        return cell
    }
}

extension StockDetailViewController: StockDetailViewDelegate {
    func refreshTable() {
        tableView.reloadData()
    }
}
