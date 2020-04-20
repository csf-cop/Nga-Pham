//
//  ContactViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/19/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit

final class ContactViewController: ViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var addNewImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTableView()
        // Add click to image Event.
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                     action: #selector(self.addContact))
        addNewImageView.addGestureRecognizer(gesture)

        // MARK: Observer contact changing.
//        notificationCenter.addObserver(self,
//                                       selector: #selector(reloadContacts),
//                                       name: Notification.Name.ReloadContacts,
//                                       object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCollectionViewData()
    }
}

extension ContactViewController {
    @objc private func addContact(sender: UITapGestureRecognizer) {
        let contactVC: ModifyContactViewController = ModifyContactViewController()
        contactVC.viewModel = ModifyContactViewModel()
        navigationController?.pushViewController(contactVC, animated: true)
    }

    private func configTableView() {
        collectionView.register(ContactViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func loadCollectionViewData() {
        guard let viewModel: ContactViewModel = viewModel as? ContactViewModel else { return }
        viewModel.loadContactsData { [] isSuccess in
            if isSuccess {
                self.collectionView.reloadData()
            }
        }
    }

    @objc private func reloadContacts(_ notification: Notification) {
        #warning("Using notification Observer contact change.")
//        DispatchQueue.main.async { [weak self] in
//            guard let this: ContactViewController = self else { return }
//            if let data: [String: Any] = notification.object as? [String: Any],
//                let result: CoreContact = data[NotifiTop.result.rawValue] as? CoreContact {
//                this.viewModel?.additionalContact(contact: result)
//                this.collectionView.reloadData()
//            }
//        }
        print("Call back load Data item.")
        loadCollectionViewData()
    }
}

extension ContactViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel: ContactViewModel = viewModel as? ContactViewModel else { return 0 }
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel: ContactViewModel = viewModel as? ContactViewModel else { return UICollectionViewCell() }
        let cell: ContactViewCell = collectionView.dequeue(ContactViewCell.self, forIndexPath: indexPath)
        cell.viewModel =  viewModel.modelForCell(at: indexPath)
        return cell
    }
}

extension ContactViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel: ContactViewModel = viewModel as? ContactViewModel else { return }
        let contactDetail: ModifyContactViewController = ModifyContactViewController()
        contactDetail.viewModel = viewModel.contactModel(at: indexPath)
        navigationController?.pushViewController(contactDetail, animated: true)
    }
}

extension ContactViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width / 2.5
        let height = widthPerItem * 1.3
        return CGSize(width: widthPerItem, height: height)
    }
}
