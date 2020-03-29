//
//  HomeViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import CoreData

final class HomeViewController: ViewController {

    @IBOutlet private weak var addNewImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()

        // Add click to image Event.
        let singleTapGest: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveToAddJuice))
        addNewImageView.addGestureRecognizer(singleTapGest)

        guard let viewModel: HomeViewModel = viewModel as? HomeViewModel else { return }
        viewModel.handleErrorMessage = { [weak self] error in
            self?.showError(error)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContactData()
    }
}

extension HomeViewController {
    @objc private func moveToAddJuice(sender: UITapGestureRecognizer) {
        let addJuiceVC: AddJuiceViewController = AddJuiceViewController()
        addJuiceVC.viewModel = AddJuiceViewModel()
        navigationController?.pushViewController(addJuiceVC, animated: true)
    }

    private func configCollection() {
        // Regist collection view.
        collectionView.register(JuiceCollectionCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func loadContactData() {
        guard let viewModel: HomeViewModel = viewModel as? HomeViewModel else { return }
        viewModel.loadContactsData { [] isSuccess in
            if isSuccess {
                self.navigationController?.popViewController(animated: true)
            }
        }
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel: HomeViewModel = viewModel as? HomeViewModel else { return 0 }
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel: HomeViewModel = viewModel as? HomeViewModel else { return UICollectionViewCell() }
        let cell: JuiceCollectionCell = collectionView.dequeue(JuiceCollectionCell.self, forIndexPath: indexPath)
        cell.viewModel = viewModel.modelForCell(at: indexPath)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel: HomeViewModel = viewModel as? HomeViewModel else { return }
        let juiceDetail: JuiceDetailViewController = JuiceDetailViewController()
        juiceDetail.viewModel = viewModel.modelCellDetail(at: indexPath)
        navigationController?.pushViewController(juiceDetail, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let widthPerItem = (view.frame.width / 2) - 5
        let height = widthPerItem * 1.3
        return CGSize(width: widthPerItem, height: height)
    }
}
