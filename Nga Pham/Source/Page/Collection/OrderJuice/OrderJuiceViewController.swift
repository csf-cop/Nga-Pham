//
//  OrderJuiceViewController.swift
//  Nga Pham
//
//  Created by Tuan Dang Q. on 3/16/20.
//  Copyright © 2020 Tuan Dang Q. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Photos

final class OrderJuiceViewController: ViewController {


    @IBOutlet private weak var juiceTypePickup: PickerViewTextField!
    @IBOutlet private weak var juiceUnitPickup: PickerViewTextField!
    @IBOutlet private weak var juiceTypeLabel: UILabel!
    @IBOutlet private weak var juiceUnitLabel: UILabel!
    @IBOutlet private weak var imagesStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Đặt trái cây"
        loadData()
    }

    @IBAction func addImagesTouchUpInside(_ sender: UIButton) {
        accessToLibrary()
    }

    @IBAction func orderTouchUpInside(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension OrderJuiceViewController {
    private func loadData() {
        guard let viewModel: OrderJuiceViewModel = viewModel as? OrderJuiceViewModel else { return }
        juiceTypePickup.delegateTextFieldPicker = self
        juiceTypePickup.delegate = self
        juiceTypePickup.updateData(datas: viewModel.fetchCategoriesType(), selectedDatas: [])
        juiceUnitPickup.delegateTextFieldPicker = self
        juiceUnitPickup.delegate = self
        juiceUnitPickup.updateData(datas: viewModel.fetchCategoriesUnit(), selectedDatas: [])
    }

    private func accessToLibrary() {
        let photos: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization ({ [weak self] status in
                guard let this: OrderJuiceViewController = self else { return }
                if status == .authorized {
                    this.presentLibraryPhoto()
                }
            })
        case .authorized:
            presentLibraryPhoto()
        default:
            showAlert(title: App.Strings.Camera.libraryPhotoAlertTitle,
                      message: App.Strings.Camera.libraryPhotoMessage,
                      buttonTitles: CameraConfig.alertButtonTitles,
                      highlightedButtonIndex: CameraConfig.alertButtonTitles.firstIndex(of: App.Strings.cancel)) { index in
                if index == CameraConfig.alertButtonTitles.firstIndex(of: App.Strings.setting) {
                    App.openSetting()
                }
            }
        }
    }

    private func presentLibraryPhoto() {
        DispatchQueue.main.async {
            let viewController: PhotoPickerViewController = PhotoPickerViewController()
            viewController.delegate = self
            var configure: TLPhotosPickerConfigure = TLPhotosPickerConfigure()
            configure.usedCameraButton = false
            configure.numberOfColumn = CameraConfig.numberOfColumn
            configure.allowedVideo = false
            configure.allowedLivePhotos = false
            configure.allowedVideoRecording = false
            configure.tapHereToChange = App.Strings.Camera.tapHereToChange
            configure.doneTitle = App.Strings.complete
            configure.cancelTitle = App.Strings.cancel
            configure.singleSelectedMode = false
            configure.maxSelectedAssets = CameraConfig.maxSelectedAssets
            configure.customLocalizedTitle = CameraConfig.customLocalizedTitle
            viewController.configure = configure

            self.present(viewController, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate
extension OrderJuiceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension OrderJuiceViewController: PickerViewTextFieldDelegate {
    func view(_ view: PickerViewTextField, needsPerformActions action: Action<[String]>) {
        switch action {
        case .send(let values) where view == juiceTypePickup:
            juiceTypeLabel.text = values.first
        case .send(let values) where view == juiceUnitPickup:
            juiceUnitLabel.text = values.first
        default: break
        }
    }
}

// MARK: TLPhotosPickerViewControllerDelegate
extension OrderJuiceViewController: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        guard let viewModel: OrderJuiceViewModel = viewModel as? OrderJuiceViewModel else { return }
        viewModel.getSelectedImage(selectedAssets: withTLPHAssets)
    }

    func dismissComplete() {
        guard let viewModel: OrderJuiceViewModel = viewModel as? OrderJuiceViewModel else {
            imagesStackView.isHidden = true
            return
        }
        // Load images to display.
        let buttons: [UIImageView] = imagesStackView.arrangedSubviews.compactMap({ $0 as? UIImageView })
        for image in buttons {
            image.image = viewModel.uploadableImages[safe: image.tag].unwrapped(or: UIImage())
        }
        imagesStackView.isHidden = false
    }
}

extension OrderJuiceViewController {
    struct CameraConfig {
        static let alertButtonTitles: [String] = [App.Strings.cancel, App.Strings.setting]
        static let typeButtonTitles: [String] = [App.Strings.library, App.Strings.camera]
        static let numberOfColumn: Int = 3
        static let maxSelectedAssets: Int = 4
        static let customLocalizedTitle: [String: String] = ["Camera Roll": App.Strings.Camera.cameraRoll,
                                                             "Selfies": App.Strings.Camera.selfies,
                                                             "Favorites": App.Strings.favorite,
                                                             "My Photo Stream": App.Strings.Camera.myPhotoStream]
    }
}
