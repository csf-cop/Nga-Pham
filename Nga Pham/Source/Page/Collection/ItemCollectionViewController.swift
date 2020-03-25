//
//  ItemCollectionViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class ItemCollectionViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addNewImageView: UIImageView!
    
    var viewModel: ItemCollectionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTableUI()
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.orderJuice))
        addNewImageView.addGestureRecognizer(gesture)
    }
}

extension ItemCollectionViewController {
    private func configTableUI() {
        tableView.register(ItemCollectionCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
    }

    @objc private func orderJuice(sender: UITapGestureRecognizer) {
        let orderJuiceVC: OrderJuiceViewController = OrderJuiceViewController()
        orderJuiceVC.viewModel = OrderJuiceViewModel()
        navigationController?.pushViewController(orderJuiceVC, animated: true)
    }
}

extension ItemCollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel: ItemCollectionViewModel = viewModel else { return 0 }
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel: ItemCollectionViewModel = viewModel else { return UITableViewCell() }
        let cell: ItemCollectionCell = tableView.dequeue(ItemCollectionCell.self)
        cell.viewModel = viewModel.viewModelForItemCollectionCell(at: indexPath)
        return cell
    }
}

extension ItemCollectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel: ItemCollectionViewModel = viewModel else { return }
        let juiceDetail: JuiceDetailViewController = JuiceDetailViewController()
        juiceDetail.viewModel = viewModel.modelCellDetail(at: indexPath)
        navigationController?.pushViewController(juiceDetail, animated: true)
    }
}
