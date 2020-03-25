//
//  PhotoPickerViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/20/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import Foundation
import TLPhotoPicker

final class PhotoPickerViewController: TLPhotosPickerViewController {
    override func makeUI() {
        super.makeUI()
        view.backgroundColor = .white
        doneButton.isEnabled = !selectedAssets.isEmpty
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        doneButton.isEnabled = !selectedAssets.isEmpty
    }
}
